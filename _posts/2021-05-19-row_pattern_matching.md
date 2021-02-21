---
layout: post
title:  "Row pattern recognition with MATCH_RECOGNIZE"
author: Kasia Findeisen (kasiafi)
excerpt_separator: <!--more-->
---

The `MATCH_RECOGNIZE` syntax was introduced in the latest SQL specification
of 2016. It is a super powerful tool for analyzing trends in your data. We are
proud to announce that Trino supports this great feature since
[version 356]({{site.url}}/docs/current/release/release-356.html). With
`MATCH_RECOGNIZE`, you can define a pattern using the well-known regular
expression syntax, and match it to a set of rows. Upon finding a matching row
sequence, you can retrieve all kinds of detailed or summary information about
the match, and pass it on to be processed by the subsequent parts of your
query. This is a new level of what a pure SQL statement can do.

This blog post gives you a taste of row pattern matching capabilities, and a
quick overview of the `MATCH_RECOGNIZE` syntax.

<!--more-->

## A regular expression and a table: a fruitful relationship

The regex matching we all know is about searching for patterns in character
strings. But how does a regex match a sequence of rows? Certainly, a row of
data is a more complex structure than a character. And so, row pattern matching
is more expressive than regex matching in text. Unlike characters, which stay
constantly in their places in a string, rows aren't assigned up-front to
pattern components. This is where the additional level of complexity comes
from: whether the row is an `A`, `B` or `C`, is conditional. It is revealed as
the pattern matching goes forward. It depends on the data in the row, but also
on the context of the current match and even on the match number. Also, a row
can match different labels at a time.
 
Consider this simple example:

```
PATTERN: A B+ C D?
```

First, let's match it to the string `"ABBCEE"`. There is exactly one way to
match it: the prefix `"ABBC"` is a match.

Now, let's see what it takes to match a pattern to rows of a table.
Consider the table `numbers` with a single column `number`:

![](/assets/blog/match-recognize/table-numbers.svg)

You need `defining conditions` to define how the rows of the table can be
mapped to pattern components `A`, `B`, `C` and `D`:


```
DEFINE:
    A <- true (matches every row)
    B <- number is greater than previous number
    C <- number is lower or equal to A
    D <- matches every row, but only in the first match;
         otherwise doesn't match any row
```
 
As you can see, the conditions can refer to other pattern components (`C`
 depends on `A`), or the sequential match number (`D`).
 
When searching for a match, the engine goes row by row, and assigns labels
according to the pattern. Every time the pattern shows the next component
(label) to be matched, the defining condition of that component is evaluated
for the current row in the context of the partial match.

![](/assets/blog/match-recognize/first-match.svg)

After finding a match, you can step one row forward and search for another one.

![](/assets/blog/match-recognize/second-match.svg)

So far, two matches were found in the same set of rows. Interestingly, a row
that was labeled as `B` in the first match, became `A` in the second match.
Let's try to find another match.

![](/assets/blog/match-recognize/third-match.svg)

## Time to get more technical

...and use some real <s>life</s> money examples.

In the preceding examples, the pattern consisted of components `A`, `B`, `C`
and `D`. They were chosen this way to capture the analogy between pattern
matching in a string and pattern matching in a set of rows. According to the
SQL specification, row pattern components can be named with arbitrary
identifiers, as long as they are compliant with the SQL identifier semantics,
so you don't need to limit yourself to single-letter names, and instead you can
use more verbose labels.

Officially, the pattern components, or labels, are called the `primary pattern
variables`. They are the basic components of the row pattern. Consider the
following example:

```
PATTERN( START DOWN+ UP+ )
```

There are three primary pattern variables: `START`, `DOWN` and `UP`. The `+` is
the "one or more" quantifier you know from the regex syntax. Intuitively, this
pattern should match a sequence of rows which are first "decreasing", and then
"increasing". You need to inform the engine how it should map rows to the
variables. In other words, you need to define what the "decreasing" and
"increasing" rows are:

```
DEFINE DOWN AS price < PREV(price),
       UP AS price > PREV(price)
```

Now it's clear that "decreasing" and "increasing" is about the `price` values.
There is no defining condition for the `START` variable, which informs the
engine that the match can start anywhere.

The preceding example shows the two key clauses of row pattern recognition:
`PATTERN` and `DEFINE`. Let's see what other keywords there are in the
`MATCH_RECOHNIZE` clause.

## Syntax overview

The `MATCH_RECOGNIZE` syntax is long and rich enough to capture everything that
a pattern matching tool needs, and all the options which let you easily toggle
your matching strategies.

Technically, `MATCH_RECOGNIZE` is part of the `FROM` clause:

```
SELECT ...
    FROM some_table
        MATCH_RECOGNIZE (
          [ PARTITION BY column [, ...] ]
          [ ORDER BY column [, ...] ]
          [ MEASURES measure_definition [, ...] ]
          [ rows_per_match ]
          [ AFTER MATCH skip_to ]
          PATTERN ( row_pattern )
          [ SUBSET subset_definition [, ...] ]
          DEFINE variable_definition [, ...]
          )
```

`MATCH_RECOGNIZE` can be used in the query as one of the stages of processing
data. You can `SELECT` from its results or even stream them into another
`MATCH_RECOGNIZE`.

The `PATTERN` and `DEFINE` clauses are the heart of row pattern recognition.
They are also the only two required subclauses of `MATCH_RECOGNIZE`. They were
touched upon in the previous section.

The pattern syntax is close to regular expression syntax. It also supports some
extensions specific to row pattern recognition. They are explained in
[Row pattern syntax](#pattern-syntax).

The `PARTITION BY` and `ORDER BY` clauses are similar to those in the `WINDOW`
syntax. They help you structure the input data. You can use `PARTITION BY` to
break up your data into independent chunks. `ORDER BY` is useful to establish 
the order of rows before searching for the pattern. Typically, you want to
analyze series of events over time, so ordering by date is a good choice.

![](/assets/blog/match-recognize/partition-by-order-by.svg)

In the `MEASURES` clause, you can specify what information you need about every
match that is found. In the example, if you're interested in the order date,
the lowest value of `price` and the sequential number of the match, this is the
way to retrieve them:

```
MEASURES order_date AS date,
         LAST(DOWN.price) AS bottom_price,
         MATCH_NUMBER() AS match_no
```

`date`, `bottom_price` and `match_no` are exposed by the pattern recognition
clause as output columns.

The expressions in the `MEASURES` and `DEFINE` clauses allow you to combine the
input data with the information about the matched pattern. They support many
extensions and special constructs to help you get the most of your data, both
when defining the pattern, and retrieving useful information after a successful
match. The special keyword `LAST` is one example. For the full list of the
magic spells, check [Expressions for special tasks](#expressions).

The `MATCH_RECOGNIZE` clause has two useful toggles. The first of them lets you
choose whether the output includes all rows of the match, or a single-row
summary. For all rows, specify `ALL ROWS PER MATCH`. For a single row, choose
the default `ONE ROW PER MATCH`. There are also sub-options available, enabling
different handling of empty matches and unmatched rows.

![](/assets/blog/match-recognize/rows-per-match.svg)

Another toggle is the `AFTER MATCH SKIP` clause. It allows you to specify where
the row pattern matching resumes after finding a match. The default option is
`AFTER MATCH SKIP PAST LAST ROW`, but you can also skip to the next row or to a
specific position in the match based on the matched pattern variables.

![](/assets/blog/match-recognize/after-match-skip.svg)

The `SUBSET` clause is where the `union pattern variables` are defined. They
are a concise way to refer to a group of primary pattern variables:

```
SUBSET U = (DOWN, UP)
```

The following expression returns the value of `price` from the last row
matched either to `DOWN` or `UP` primary variable:

```
LAST(U.price)
```

## <a name="pattern-syntax"/> Row pattern syntax

The basic element of row pattern is the primary pattern variable. Other syntax
components include:

**Concatenation**

```
A B C
```

**Alternation**

```
A | B | C
```

**Permutation**

```
PERMUTE(A, B, C)
```

**Grouping**

```
(A B C)
```

**Partition start anchor**

```
^
```

**Partition end anchor**

```
$
```

**Empty pattern**

```
()
```

**Exclusion syntax**

```
{- row_pattern -}
```

Exclusion syntax is useful in combination with the `ALL ROWS PER MATCH` option.
If you find some sections of the match uninteresting, you can wrap them in the
exclusion, and they are dropped from the output.

![](/assets/blog/match-recognize/exclusion.svg)

**Quantifiers**

Row pattern syntax supports all kinds of quantifiers: the basic ones `*`, `+`,
`?`, and others, which let you specify the exact number of repetitions, or the
accepted range: `{n}`, `{n, m}`, `{n,}`, `{,n}`. Make sure you don't confuse
those:

- `{n}` is for exactly n repetitions,
- `{n,}` is equal to `{n, ∞}`,
- `{,n}` is equal to `{0, n}`.

Quantifiers are greedy by default. It means that they prefer higher number of
repetitions over lower number. If you want it the other way, you can change a
quantifier to reluctant by appending `?` immediately after it. So, `(pattern)?`
prefers a single match of the pattern, while `(pattern)??` would rather omit
the pattern altogether.

### Match preference

`MATCH_RECOGNIZE` is supposed to produce at most one match starting from a
specific row. If there are more matches available, the winner is chosen based
on the order of preference. The greedy and reluctant quantifiers are one
example of preference. Other pattern components have their own rules:

- pattern alternation prefers the left-hand components to the right-hand ones.

- pattern permutation is equivalent to alternation of all permutations of its
components. If multiple matches are possible, the match is chosen based on the
lexicographical order established by the order of components in the `PERMUTE`
list. For `PERMUTE(A, B, C)`, the preference of options goes as follows:
`A B C`, `A C B`, `B A C`, `B C A`, `C A B`, `C B A`.

## <a name="expressions"/> Expressions for special tasks

The `MATCH_RECOGNIZE` clause provides special expression syntax, available in
the `MEASURES` and `DEFINE` clauses. Its purpose is to combine the input data
with the information about the match. The syntax includes:

- **Pattern variable references**

They allow referring to certain components of the match, for example
`DOWN.price`, `UP.order_date`.

- **Logical navigation operations: `LAST`, `FIRST`**

They allow you to navigate over the rows of a match based on the pattern
variables assigned to them. For example, `LAST(DOWN.price, 3)` navigates to the
last row labeled as "DOWN", goes three occurrences of the "DOWN" label
backwards, and gets the `price` value from that row. The default offset is `0`:
`LAST(DOWN.price)` gets the `price` value from the last row labeled as "DOWN".
If the logical navigation goes beyond the match bounds, the operation returns
`null`.

- **Physical navigation operations: `PREV`, `NEXT`**

They let you navigate over the rows of the partition by a specified offset.
Physical navigations use logical navigations as the starting point. For
example, `NEXT(DOWN.price, 5)` first navigates to the last row labeled as
"DOWN". Starting from there, it goes five rows forward and gets the `price`
value from that row. In the preceding example, the logical navigation `LAST` is
implicit, but you can specify the nested logical navigation explicitly, for
example `NEXT(FIRST(DOWN.price, 4), 5)`. The default offset is `1`, which means
that the physical navigations by default go one row backwards, or one row
forward.

The physical navigation can retrieve values beyond the match bounds. It gives
you great flexibility. For example, the defining conditions of pattern
variables can peek at the values ahead. Also, when computing row pattern
measures, you can refer to the wider context of the match.
  
- **The `CLASSIFIER` function**

It returns the primary pattern variable associated with the row.

- **The `MATCH_NUMBER` function**

It returns the sequential number of the match within the partition.

- **The `RUNNING` and `FINAL` keywords**

The expressions in the `DEFINE` clause are evaluated when the pattern matching
is in progress. At each step, the engine only knows a part of the match. This
is the *running semantics*.

The expressions of the `MEASURES` clause are evaluated when the match is
complete. The engine can see the whole match from the position of the final
row. This is the *final semantics*.

However, with the `ALL ROWS PER MATCH` option, when the match result is
processed row by row, you can choose either approach to compute the measures.
To do that, you can specify the `RUNNING` or `FINAL` keyword before the logical
navigation operation, for example `RUNNING LAST(DOWN.price)` or
`FINAL LAST(DOWN.price)`.

The *running semantics* is the default both in the `DEFINE` and `MESAURES`
clauses. Note that `FINAL` only applies to the `MEASURES` clause.

To sum up, here's one complex measure expression combining different elements
of the special syntax:

![](/assets/blog/match-recognize/measure-example.svg)

## Trino CLI show-off time!

Now, let's see the whole machinery come to life. This is the same example data
that we used before, and the same goal: detect a "V"-shape of the `price`
values over time for different customers.

```
trino> WITH orders(customer_id, order_date, price) AS (VALUES
    ('cust_1', DATE '2020-05-11', 100),
    ('cust_1', DATE '2020-05-12', 200),
    ('cust_2', DATE '2020-05-13',   8),
    ('cust_1', DATE '2020-05-14', 100),
    ('cust_2', DATE '2020-05-15',   4),
    ('cust_1', DATE '2020-05-16',  50),
    ('cust_1', DATE '2020-05-17', 100),
    ('cust_2', DATE '2020-05-18',   6))
SELECT customer_id, start_price, bottom_price, final_price, start_date, final_date
    FROM orders
        MATCH_RECOGNIZE (
            PARTITION BY customer_id
            ORDER BY order_date
            MEASURES
                START.price AS start_price,
                LAST(DOWN.price) AS bottom_price,
                LAST(UP.price) AS final_price,
                START.order_date AS start_date,
                LAST(UP.order_date) AS final_date
            ONE ROW PER MATCH
            AFTER MATCH SKIP PAST LAST ROW
            PATTERN (START DOWN+ UP+)
            DEFINE
                DOWN AS price < PREV(price),
                UP AS price > PREV(price)
            );

 customer_id | start_price | bottom_price | final_price | start_date | final_date
-------------+-------------+--------------+-------------+------------+------------
 cust_1      |         200 |           50 |         100 | 2020-05-12 | 2020-05-17
 cust_2      |           8 |            4 |           6 | 2020-05-13 | 2020-05-18
(2 rows)
``` 

Two matches are detected, one for `cust_1`, and one for `cust_2`.

## Empty matches explained

An empty match is a legit result of row pattern recognition. There are
different pattern constructs that can result in an empty match. The empty
pattern syntax `()` is the trivial one. Empty match can also result e.g. from
quantification: `A*`, or alternation: `A | ()`.

An empty match does not consume any input rows, but like every match, it is
associated with a row, called the _starting row_. That is the row at which the
pattern matching started. Note that if the pattern allows an empty match, it
guarantees that no rows remain unmatched. Also, an empty match, as well as
non-empty matches, gets a sequential number, which can be retrieved by the
`MATCH_NUMBER` function.

Depending on your use case, you can consider empty matches informative or just
see them as a leftover of the algorithm.

There's one more thing linked to empty matches. Some patterns have the
dangerous potential of looping endlessly over a piece that doesn't consume any
rows. It doesn't have to be as explicit as `()*`. There are complex patterns
that don't show their looping potential at first glance. We handled them
carefully so that you never have to waste your time on looping queries. 

## In a few words, what's so cool about row pattern matching?

From the SQL viewpoint, you can think of row pattern matching as extended
window functions. Window functions allow you to capture some dependencies in
rows of data based on their relative position or value. Row pattern matching
allows you to detect arbitrarily complicated dependencies, based not only on
the input values but also on the details of the actual match and on the match
number.

Before the introduction of `MATCH_RECOGNIZE`, you had to feed your data to
external tools to reason about trends and patterns. Now, you can achieve it
directly in your query, and even build your query upon the pattern recognition
clause to further process the match results.

Row pattern matching is typically used:

- in trade applications for tracking trends or identifying customers with
specific behavioral patterns,
 
- in shipping applications for tracking packages through all possible valid
paths,

- in financial applications for detecting unusual incidents, which might signal
fraud.

What's your use case?

I hope you enjoy Trino's new feature. Refer to
[Trino docs](https://trino.io/docs/current/sql/match-recognize.html) for even
more details, examples and usage tips. [Please **do** reach out to us with any
questions or issues](/slack.html). We plan to support row pattern matching in
the `WINDOW` clause soon, so stay tuned!
