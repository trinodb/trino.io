---
layout: post
title:  "Optimizing the Casts Away"
author: Martin Traverso
---

The next release of Presto (version 312) will include a new optimization to remove unnecessary casts 
which might have been added implicitly by the query planner or explicitly by users when they wrote the query.

This is a long post explaining how the optimization works. If you're only interested in the results,
skip to the [last section](#results). For the full details, read on! 


<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS_CHTML">
</script>

<div style="display:none">
$$ 
\newcommand\cast[2]{
    \text{cast}_{\text{#1} \rightarrow \text{#2}}
} 
\newcommand\trueOrNull[1]{
  \text{if}(#1 \text{ is null}, \text{null}, \text{true})
} 
\newcommand\falseOrNull[1]{
  \text{if}(#1 \text{ is null}, \text{null}, \text{false})
} 
$$
</div>

Like many programming languages, SQL allows certain operations between values of different 
types if there are implicit conversions (a.k.a., implicit casts or coercions) between those types.
This improves usability, as it allows writing expressions like `1.5 > 2` without worrying *too much*
whether the types are compatible (`1.5` is of type `decimal(2,1)`, while `2` is an `integer`).

During query analysis and planning, Presto introduces explicit casts for any implicit conversion in the
original query as it translates it into the intermediate query plan representation the engine uses 
internally for optimization and execution. This eliminates a layer of complexity for the optimizer, 
which, as a result, doesn't need to reason about types (type inference) or worry about whether expressions 
are properly typed. 

More importantly, it simplifies the job of defining and implementing operators (e.g., `>`, `<`, `=`, etc). 
Without implicit conversions, there would need to exist a variant of every operator for every combination
 of compatible types. For example, it would be necessary to have an implementation of the `=` operator for 
 `(tinyint, tinyint)`, `(tinyint, smallint)`, `(tinyint, integer)`, 
`(tinyint, bigint)`, `(smallint, integer)`, and so on.

Given two columns, `s :: tinyint` and `t :: smallint`, and an expression such as `s = t`, the planner 
determines that `tinyint` can be implicitly coerced to `smallint` and derives the following expression:

```
CAST(s AS smallint) = t   
```

This is not without challenges. The predicate pushdown logic relies on simple equality and 
range comparisons to move predicates around, and importantly, to infer that certain predicates
in one branch of a join can be used to constrain the values on the other side of the join. An
expression like the one above is not "simple" from this perspective due to the type conversion 
involved, and it can defeat the (arguably simplistic) predicate inference algorithm.  

Secondly, if `t` is a constant (or an expression that is effectively constant), the engine has to 
convert every value of `s` it sees during query execution in order to compare it with `t`. This 
brings up the obvious question: "can't it somehow convert `t` to `tinyint` and compare directly"?
It would look like:
 
```
s = CAST(t AS tinyint)
``` 

Since `t` is a constant, the term `CAST(t AS tinyint)` can be trivially pre-computed and reused 
for the entire query. It's not that simple in the general case, though. Narrowing cast, such 
as a conversion from `smallint` to `tinyint`, or from `double` to `integer` can fail or alter
the value due to rounding or truncation, so we must take special care to avoid errors or 
change query semantics. We discuss this at length in the sections below. 

# Some properties of (well-behaved) implicit casts

Let's take a short detour and talk briefly about some properties of well-behaved implicit 
casts we can exploit to do the transformation we described in the previous section.

Since the query engine is free to insert implicit casts wherever it sees fit, these functions
need to follow some ground rules. Failure to do so can result in queries producing incorrect
results due to changes in query semantics.

Implicit casts need to have the following properties:
* [Injective](https://en.wikipedia.org/wiki/Injective_function). Given $$\cast{S}{T}$$ every value in `S` 
  must map to a distinct value in `T` (this does not imply that every value in `T` has to map to a value 
  in `S`, though).
* Order-preserving. Given $$ s_1 \in S $$ and $$ s_2 \in S $$, 

$$
\begin{equation}
s_1 = s_2 \quad \Rightarrow \quad \cast{S}{T}(s_1) = \cast{S}{T}(s_2) \\
s_1 < s_2 \quad \Rightarrow \quad \cast{S}{T}(s_1) < \cast{S}{T}(s_2) \\
s_1 > s_2 \quad \Rightarrow \quad \cast{S}{T}(s_1) > \cast{S}{T}(s_2)
\end{equation}
$$
     
For exact numeric types (e.g., `smallint`, `integer`, `decimal`, etc.), this holds as long as 
`T` has enough integer digits to hold the integral part of `S` and enough fractional digits to 
hold the fractional part of `S`.

As an example, the picture below depicts how every value of type `tinyint`, which has a range
of $$[-128, 127]$$, maps to a distinct value of a wider type such as `smallint`. Also, every value 
of the wider type that is within the range of representable values of `tinyint` has a distinct 
mapping to a `tinyint`. So, for the values within the `tinyint` range, the `tinyint` → `smallint`
conversion is [bijective](https://en.wikipedia.org/wiki/Bijection). This is not necessary for the 
transformation to work, but it simplifies one of the cases we'll consider. We'll cover this more later. 

![](/assets/blog/optimizing-casts/tinyint-integer.svg)

On the other hand, some conversions such as those between integer types and decimal types with fractional
parts are injective but not bijective, even when excluding the values outside the range of the narrower
 type.

![](/assets/blog/optimizing-casts/tinyint-decimal.svg)


The properties clearly hold for `tinyint` → `smallint` → `integer` → `biginteger`. They also hold for:
* `tinyint` → `decimal(3,0)` → `decimal(4,1)` → `decimal(5,2)` → ...
* `smallint` → `decimal(5,0)` → `decimal(6,1)` → `decimal(7,2)` → ...
* `integer` → `decimal(10,0)` → `decimal(11,1)` → ...
* `bigint` → `decimal(19,0)` → `decimal(20, 1)` → ...

It even works for conversions between exact and approximate numbers, such as:
* `smallint` → `real` 
* `real` → `double`
* `integer` → `double`

It does *not* work for `bigint` → `double`, `integer` → `real`, or `decimal` → `double` when precision is large
because not all `bigint`s fit in a `double` (64 bits vs 53-bit mantissa) and not all `integer`s fit in a `real` 
(32 bits vs 23-bit mantissa). Sadly, for legacy reasons Presto allows those conversions implicitly. We "justify" 
it with the argument that "since they are dealing with approximate numerics anyway, and given the conversions only 
lose precision in the least significant part, they are sort of ok". This is something we'll revisit in the
future once we have a reasonable story around dealing with inherent break in backward-compatibility
of removing such conversions. 

Finally, the properties also apply for `varchar` to `varchar` conversions:
* `varchar(0)` → `varchar(1)` → `varchar(2)` → ... → `varchar`   

# Getting to the point... 

With this in mind, let's look at the simplest scenario: conversions between integer types. 

As in the example we covered in the introduction, the transformation is straightforward 
when the constant can be represented in the narrower type. Given `s :: tinyint`:

```
CAST(s AS smallint) = smallint '1'     ⟺  s = tinyint '1'
CAST(s AS smallint) = smallint '127'   ⟺  s = tinyint '127'
CAST(s AS smallint) = smallint '-128'  ⟺  s = tinyint '-128'

CAST(s AS smallint) > smallint '10'    ⟺  s > tinyint '10'
CAST(s AS smallint) < smallint '10'    ⟺  s < tinyint '10'
```

Of course, when the value is at the edge of the range of the narrower type, we can cleverly 
turn some inequalities into equalities:

```
CAST(s AS smallint) >= smallint '127'   ⟺  s >= tinyint '127'  
                                        ⟺  s =  tinyint '127'
                                       
CAST(s AS smallint) <= smallint '-128'  ⟺  s <= tinyint '-128'  
                                        ⟺  s =  tinyint '-128'
```

Additionally, we may be able to tell that an expression is always `true` or `false`. Special
care needs to be taken when the value is `null`, though, since in SQL any comparison with `null` 
yields `null`:

```
CAST(s AS smallint) > smallint '127'    ⟺  s > tinyint '127'  
                                        ⟺  if(s is null, null, false)
                                        
CAST(s AS smallint) <= smallint '127'   ⟺  s <= tinyint '127'  
                                        ⟺  if(s is null, null, true)

CAST(s AS smallint) < smallint '-128'   ⟺  s < tinyint '-128'  
                                        ⟺  if(s is null, null, false)
                                        
CAST(s AS smallint) >= smallint '-128'  ⟺  s >= tinyint '-128'  
                                        ⟺  if(s is null, null, true)
```

We can make similar inferences when the value is outside the range of possible values
for `tinyint`. For equality comparisons, it's trivial.

```
CAST(s AS smallint) = smallint '1000'  ⟺  if(s is null, null, false)    
```

Conversely,

```
CAST(s AS smallint) <> smallint '1000'  ⟺  if(s is null, null, true)
```

Just like the earlier cases involving comparisons with values at the edge of the range,
we can apply the same idea when the value falls outside of the range:

```
CAST(s AS smallint) < smallint '1000'   ⟺  if(s is null, null, true) 
CAST(s AS smallint) < smallint '-1000'  ⟺  if(s is null, null, false)

CAST(s AS smallint) > smallint '1000'   ⟺  if(s is null, null, false) 
CAST(s AS smallint) > smallint '-1000'  ⟺  if(s is null, null, true)
```
        
    
# Unrepresentable values

Values that are outside the range of the narrower type may not be the only ones without a mapping. 
For example, for a type such as `decimal(2,1)`, any value with a fractional part (e.g., `1.5`, `2.3`) cannot 
be represented as a `tinyint`. 

We can tell whether a value `t` in `T` is representable in `S` by converting it to `S` and back to `T`. We'll 
call this value `t'`. 

If `t <> t'`, `t` is not representable in `S`, and similar rules as for out-of-range values apply when the 
expression involves an equality. For instance, given `s :: tinyint`:

```
CAST(s AS double) =  double '1.1'  ⟺  if(s is null, null, false)    
CAST(s AS double) <> double '1.1'  ⟺  if(s is null, null, true)
```
 
When some values in `T` are not representable in `S`, the cast between `T → S` will generally either truncate
or round. The SQL specification doesn't mandate which of those alternatives an implementation should follow,
and even allows that to vary for conversions between various combinations of types.

This throws a bit of a wrench in our plans, so to speak. If we can't tell whether a cast will round or truncate,
how would we know whether a `>` comparison should turn into a `>` or `>=` in the resulting expression? To 
illustrate, let's consider this example. Given `s :: tinyint`:

```
CAST(s AS double) > double '1.9'
```
    
If the conversion from `double` → `tinyint` truncates, the expression above is equivalent to:

```
s > tinyint '1'
```
    
On the other hand, if the conversion rounds, `1.9` becomes `2`, and the expression is equivalent to:

```
s >= tinyint '2'              
```

In order to know which operator to use in the transformed expression (e.g., `>` vs `>=`), it is therefore 
crucial to distinguish between those two behaviors. The good news is that there's a simple and elegant way
out of this hole. 

An important observation is that we don't need to know how the conversion behaves *in general*, but only how 
it behaves when applied to the constant `t`. Regardless of whether the conversion truncates or rounds, for a 
given value of `t`, the outcome can be seen to *round up* or *round down*, as depicted below.

--------------------------------------------------|--------------------------------------------------
![](/assets/blog/optimizing-casts/round-down.svg) | ![](/assets/blog/optimizing-casts/round-up.svg)

We can easily tell which of those scenarios applies by comparing `t` with `t'`: if `t > t'`, the operation rounded
down. Conversely, if `t < t'`, it rounded up. If `t = t'`, the value is representable in `S`, and the rules from the 
previous section apply.

# Oh, the nullability

Let's take another quick detour and talk about the issue of nullability. After all, no discussion about
SQL is complete without an exploration of the semantics of ``null``.

SQL uses [three-valued logic](https://en.wikipedia.org/wiki/Three-valued_logic#Application_in_SQL). In addition
to `true` and `false`, logical expressions can evaluate to an *unknown* value, which is indicated by `null`.
Logical operations `AND` and `OR` behave according to the following rules:
 
$$

\begin{array}{|c|c|c|c|}
\hline
\text{A} & \text{B} & \text{A and B} & \text{A or B} \\ 
\hline
\text{true}& \text{null} & \text{null} & \text{true} \\ 
\hline
\text{false}& \text{null} & \text{false} & \text{null} \\ 
\hline
\end{array}
$$


The logical comparison operators =, <>, >, ≥, <, ≤ evaluate to `null` when one or both operands are `null`.
Hence, if `t` is `null`, our expression `cast(s as smallint) = t` can be simply replaced with a constant `null`.

As we mentioned in the previous section, there are cases where `cast(s as smallint) = t` can be reduced to 
`true` or `false`, *except* for the fact that if `s` is null, the expression needs to return `null` to preserve
semantics. So, we use the following forms to capture this:
 
```
if(s IS null, null, false)
if(s IS null, null, true)
```

The catch with that is that the optimizer does not understand the semantics of these `if` expressions and cannot 
use them for deriving additional properties. In essence, it becomes an optimization barrier. On the other hand,
the optimizer is pretty good at manipulating logical conjunctions (`AND`) and disjunctions (`OR`). So, let's see 
how we can use boolean logic to obtain an equivalent formulation.

We can exploit the properties of SQL boolean logic to derive expressions that behave in the same manner as the 
`if()` constructs from above:

$$
\begin{align}
    \text{if}(s \text{ is null}, \text{null}, \text{false}) & \iff (s \text{ is null}) \text{ and null} \\
    \text{if}(s \text{ is null}, \text{null}, \text{true})  & \iff (s \text{ is not null}) \text{ or null} \\
\end{align}    
$$

Let's break it down to see why that works.

$$
\begin{align}         
   \text{if}(s \text{ is null}, \text{null}, \text{false}) & = (s \text{ is null}) \text{ and null} \\ 
      & = \begin{cases}
             \text{true and null}  & = \text{null},   & \text{if } s \text{ is null} \\
             \text{false and null} & = \text{false},  & \text{if } s \text{ is not null} 
          \end{cases} \\[5pt]
   \text{if}(s \text{ is null}, \text{null}, \text{true})  & = (s \text{ is not null}) \text{ or null} \\
      & = \begin{cases}
              \text{false or null}  & = \text{null},   & \text{if } s \text{ is null} \\
              \text{true or null}   & = \text{true},   & \text{if } s \text{ is not null} 
           \end{cases}
\end{align}      
$$   

# Putting it all together

Now that we've had a taste of how this optimization works, let's put it all together into one rule to rule
them all.

Given an expression of the following form,

$$ \cast{S}{T}(s) \otimes t \quad s \in S, t \in T, \otimes \in [=, \ne, <, \le, >, \ge] $$

we derive a transformation based on the rules below.

1. If $$t \text{ is null} \Rightarrow \cast{S}{T}(s) \otimes t \iff \text{null} \tag{1} $$ $$ \\[5pt] $$
2. If $$ \exists s' \in S \ldotp s' = \cast{T}{S}(t) $$, we calculate $$ t' = \cast{S}{T}(s') $$ and consider 
the following cases:  
    1. <a name="2.1"/> If $$ t = t' \Rightarrow \cast{S}{T}(s) \otimes t \iff s \otimes \cast{T}{S}(t) \tag{2.1} $$ $$ \\[5pt] $$     
        * <a name="2.1.1"/> In the special case where $$ \\[5pt] $$ $$  \quad  s' = \text{min}_S  \Rightarrow   
 \left\{
  \begin{array}{@{}ll@{}}
        \cast{S}{T}(s) > t   & \iff s \ne \text{min}_{S}     \\
        \cast{S}{T}(s) \ge t & \iff \trueOrNull{s}           \\
        \cast{S}{T}(s) <   t & \iff \falseOrNull{s}          \\
        \cast{S}{T}(s) \le t & \iff s = \text{min}_{S}
  \end{array}\right. \tag{2.1.1}  \\[5pt]
$$  
        * <a name="2.1.2"/> In the special case where $$ \\[5pt] $$ $$  \quad s' = \text{max}_S  \Rightarrow 
 \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) > t   & \iff \falseOrNull{s}        \\
          \cast{S}{T}(s) \ge t & \iff s = \text{max}_{S}     \\
          \cast{S}{T}(s) <   t & \iff s \ne \text{max}_{S}   \\
          \cast{S}{T}(s) \le t & \iff \trueOrNull{s}
  \end{array}\right. \tag{2.1.2} \\[5pt] $$  
    2. Otherwise, $$ \\[5pt] $$ $$ \quad  t \ne t' \Rightarrow 
 \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) = t   & \iff \falseOrNull{s}        \\
          \cast{S}{T}(s) \ne t & \iff \trueOrNull{s}            
  \end{array}\right. \tag{2.2} \\[5pt] $$  

        * Further, if $$ \\[5pt] $$ $$ \quad \quad  t < t' \Rightarrow 
 \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) > t   & \iff s \ge \cast{T}{S}(t)    \\
          \cast{S}{T}(s) \ge t & \iff s \ge \cast{T}{S}(t)    \\
          \cast{S}{T}(s) <   t & \iff s <  \cast{T}{S}(t)     \\
          \cast{S}{T}(s) \le t & \iff s <  \cast{T}{S}(t)
  \end{array}\right. \tag{2.2.1} \\[5pt] $$  
        In the special case where $$ \\[5pt] $$ $$  \quad \quad s' = \text{max}_S  \Rightarrow  
 \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) > t   & \iff s = \text{max}_{S}    \\
          \cast{S}{T}(s) \ge t & \iff s = \text{max}_{S}    \\
  \end{array}\right. \\[5pt] \tag{2.2.1.1} $$  

        * Otherwise, if $$ \\[5pt] $$ $$ \quad \quad  t > t' \Rightarrow
 \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) > t   & \iff s >    \cast{T}{S}(t)    \\
          \cast{S}{T}(s) \ge t & \iff s >    \cast{T}{S}(t)    \\
          \cast{S}{T}(s) <   t & \iff s \le  \cast{T}{S}(t)    \\
          \cast{S}{T}(s) \le t & \iff s \le  \cast{T}{S}(t)
  \end{array}\right. \\[5pt] \tag{2.2.2} $$  
        In the special case where $$ \\[5pt] $$ $$  \quad \quad s' = \text{min}_S  \Rightarrow  
  \left\{
  \begin{array}{@{}ll@{}}
          \cast{S}{T}(s) <   t & \iff s = \text{min}_{S}    \\
          \cast{S}{T}(s) \le t & \iff s = \text{min}_{S}
 \end{array}\right. \\[5pt] \tag{2.2.2.1} $$  

3. If $$ \cast{T}{S} $$ is undefined or $$ \cast{T}{S}(t) $$ fails, $$ \\[5pt] $$ $$
  t < \cast{S}{T}(\text{min}_S) \Rightarrow  
  \left\{
    \begin{array}{@{}ll@{}}
            \cast{S}{T}(s) =   t & \iff \falseOrNull{s}    \\
            \cast{S}{T}(s) \ne t & \iff \trueOrNull{s}     \\
            \cast{S}{T}(s) <   t & \iff \falseOrNull{s}    \\
            \cast{S}{T}(s) \le t & \iff \falseOrNull{s}    \\
            \cast{S}{T}(s) >   t & \iff \trueOrNull{s}     \\
            \cast{S}{T}(s) \ge t & \iff \trueOrNull{s}     
   \end{array}\right. \\[5pt] \tag{3.1} 
$$
$$
  t = \cast{S}{T}(\text{min}_S) \Rightarrow  
  \left\{
    \begin{array}{@{}ll@{}}
            \cast{S}{T}(s) =   t & \iff s = \text{min}_S       \\
            \cast{S}{T}(s) \ne t & \iff s > \text{min}_S       \\
            \cast{S}{T}(s) <   t & \iff \falseOrNull{s}        \\
            \cast{S}{T}(s) \le t & \iff s = \text{min}_S       \\
            \cast{S}{T}(s) >   t & \iff s > \text{min}_S       \\
            \cast{S}{T}(s) \ge t & \iff \trueOrNull{s}     
   \end{array}\right. \\[5pt] \tag{3.2}
$$
$$
  t > \cast{S}{T}(\text{max}_S) \Rightarrow  
     \left\{
       \begin{array}{@{}ll@{}}
               \cast{S}{T}(s) =   t & \iff \falseOrNull{s}    \\
               \cast{S}{T}(s) \ne t & \iff \trueOrNull{s}     \\
               \cast{S}{T}(s) <   t & \iff \trueOrNull{s}     \\
               \cast{S}{T}(s) \le t & \iff \trueOrNull{s}     \\
               \cast{S}{T}(s) >   t & \iff \falseOrNull{s}    \\
               \cast{S}{T}(s) \ge t & \iff \falseOrNull{s}    
      \end{array}\right. \\[5pt] \tag{3.3}
$$
$$
  t = \cast{S}{T}(\text{max}_S) \Rightarrow  
    \left\{
      \begin{array}{@{}ll@{}}
              \cast{S}{T}(s) =   t & \iff s = \text{max}_S   \\
              \cast{S}{T}(s) \ne t & \iff s < \text{max}_S   \\
              \cast{S}{T}(s) <   t & \iff s < \text{max}_S   \\
              \cast{S}{T}(s) \le t & \iff \trueOrNull{s}     \\
              \cast{S}{T}(s) >   t & \iff \falseOrNull{s}    \\
              \cast{S}{T}(s) \ge t & \iff s = \text{max}_S       
     \end{array}\right. \\[5pt] \tag{3.4}
$$   
    Otherwise, the transformation is not applicable.

# OMGWTFNaN

As if all of this weren't enough, there's an additional complication we need to handle for types such
as `real` and `double`. Those types are what the SQL specification calls *approximate numeric* types.
Presto implements them as [IEEE-754](https://en.wikipedia.org/wiki/IEEE_754) single and double 
precision floating point numbers, respectively.

In addition to finite numbers, IEEE-754 defines an additional set of values: `∞` and `NaN` (not a number).
It is worth noting that `-∞` and `+∞` do not behave like `∞` in the mathematical sense. They are actual values
in the ordered set of numbers, but they don't represent any finite number. Therefore, the following relations hold: 

``` 
-∞ < -1.23E30 < 0 < 3.45E25 < +∞
-∞ = -∞
+∞ = +∞ 
```

Since `-∞` and `+∞` can be treated as regular values, we can use them as the minimum and maximum values of the range
for these types. Any other choice would not work, since all values of a type must be contained within the range of the type
for the transformation to be valid. That is, 

$$ \forall v \in T \quad T_{\text{min}} \le v \le T_{\text{max}} $$  

Let's look at an example to understand why this is necessary. Instead of using $$[-∞, ∞]$$ as the range, 
let's say we picked the minimum and maximum representable values for the `real` type (-3.4028235E38 and 3.4028235E38), and
consider this expression (`s :: real`):

```
cast(s AS double) >= double '3.4028235E38'
``` 

From the rules in the previous section, $$ t = 3.4028235\text{E}38 $$, $$ s'= 3.4028235\text{E}38 $$ and $$ t' = 3.4028235E38 $$. Since 
$$ t = t' $$ and $$ s' = max_S $$, from [rule 2.1.2](#2.1.2), the expression reduces to:

```
s = 3.4028235E38 
```
 
This is clearly incorrect. When `s = Infinity`, `cast(s AS double)` results in `double 'Infinity'`, which is not equal
to 3.4028235E38.


On the other hand, `NaN` doesn't obey any of the comparison rules. It's neither equal nor distinct from itself, and
it's neither larger, nor smaller than any other value:

```
NaN =  NaN  ⟺  false  
NaN <> NaN  ⟺  false
NaN > 0     ⟺  false
NaN = 0     ⟺  false
NaN < 0     ⟺  false
``` 

So, `NaN` is not part of the ordered set of values for these types, and the requirement that every value be contained 
in the range doesn't hold. From [rule 2.1.1](#2.1.1), an expression such as:

```
cast(s AS double) >= double '-Infinity'
``` 
 
reduces to `if(s is null, null, true)`, which is incorrect, since the expression returns `false` when `s` is `NaN`.

Is all hope lost for `real` and `double`? Fortunately, not. The range is only needed as an optimization. If we
forgo defining a range for types that don't have the required properties, the special cases [2.1.1](#2.1.1) and 
[2.1.2](#2.1.2) don't apply, and by [rule 2.1](#2.1), the expression is equivalent to:

```
s >= real '-Infinity'
```

which correctly returns `false` when `s` is `NaN`.


# <a name="results"/> Show me the money!

So, does all of this even matter? Why, yes! Glad you asked.

As with any performance optimization, you can improve things by working smarter (can you avoid work that can be 
proven to be unnecessary) or by working harder (can you do the work you have to do more efficiently). This
optimization does a little of both. Let's consider three scenarios when it has a positive effect.

#### Dead code

Since in some cases it can prove that the comparisons will always produce `false`, regardless of the input,
it can short-circuit entire conditions or subplans before even a single row of data is read. Some query generation 
tools are not sophisticated enough and may emit queries that contain that kind of construct. Also, everyone makes
mistakes, and it's not hard to end up with queries that contain what's effectively *dead code*.  The last thing you
want is to sit in front of the screen waiting for a query to complete ... waiting ... waiting ... just for Presto
to tell you `¯\_(ツ)_/¯`. 

For example, given:

```sql
CREATE TABLE t(x smallint);

-- <insert lots of rows into t> --
```

```sql
SELECT * 
FROM t 
WHERE x IS NOT NULL AND x > 1000000 
```

Produces the following query plan (`Values` is an empty inline table):

```
- Output[x]
  - Values
```

#### Improved JOIN performance

What's nice about this optimization is that it *enables* other optimizations to work better. We mentioned earlier
that comparisons that are not simple expressions between columns, or between columns and constants, make it harder for the
predicate pushdown optimization to infer predicates that can be propagated to the other branch of a join.

Given two tables:

```sql
CREATE TABLE t1 (v smallint);
CREATE TABLE t2 (v bigint);
```
    
And the following query:

```sql
SELECT *
FROM t1 JOIN t2 ON t1.v = t2.v
WHERE t1.v = BIGINT '1';
```

The query plan without this optimization is:
```
- Output[name]
  - InnerJoin[expr = v]
    - ScanFilterProject[t1, filter = CAST(v AS bigint) = BIGINT '1']
        expr := CAST(v AS bigint)
    - TableScan[t2]
```

The optimization allows the predicate pushdown logic to apply the condition to the other side of the join, producing
a much better plan. If data in `t1` and `t2` is somehow organized by `v` (e.g., a partition key in Hive), or if the
connector understands how to apply the filter at the source, the query won't need to even read certain parts of the
table. The query plan with the optimization enabled: 

```
- Output[name]
  - CrossJoin
    - ScanFilterProject[t1, filter = (v = SMALLINT '1')]
    - ScanFilterProject[t2, filter = (v = BIGINT '1')]
```

#### Best bang for the buck
   
Finally, if the condition absolutely needs to be evaluated, the transformed expression could be significantly
more efficient, especially when the cast between the two types is expensive. To illustrate, given a table
with 1 billion rows and a column `k :: bigint`:

```sql
SELECT count_if(k > CAST(0 as decimal(19)) 
FROM t
```

Without the optimization:
```
- [...]
    - ScanProject
===>    CPU: 3.75m (66.34%), Scheduled: 5.56m (145.22%)
        expr := (CAST("k" AS decimal(19,0)) > CAST(DECIMAL '0' AS decimal(19,0)))
        
        
Query 20190515_072240_00006_rgzb4, FINISHED, 4 nodes
Splits: 110 total, 110 done (100.00%)
0:22 [1000M rows, 8.4GB] [46M rows/s, 395MB/s]
```

With the optimization:
```
- [...]
    - ScanProject
===>    CPU: 29.93s (58.17%), Scheduled: 47.44s (145.07%)
        expr := ("k" > BIGINT '0')
        
        
Query 20190515_071912_00005_bz6cb, FINISHED, 4 nodes
Splits: 110 total, 110 done (100.00%)
0:03 [1000M rows, 8.4GB] [335M rows/s, 2.81GB/s]        
```

Thirsty for more? Here's the [code]({{site.github_repo_url}}/blob/master/presto-main/src/main/java/io/prestosql/sql/planner/iterative/rule/UnwrapCastInComparison.java). 
Happy querying!

*Many thanks to [kasiafi](https://github.com/kasiafi) for their thoughtful and thorough feedback on early
drafts of this post.*
