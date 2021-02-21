---
layout: post
title:  "Introducing new window features"
author: Kasia Findeisen (kasiafi)
---

In Trino, we are thrilled to get feedback and feature requests from our
fantastic community, and we're tirelessly motivated to meet the expectations!
The SQL specification is another source of inspiration. From time to time, we
go through those encrypted scrolls to give you a new feature that you didn't
even know you needed!

Recently, there was a push in Trino to extend support for window functions.
In this post, we explain the complexities of window function, and describe a
couple of our recent additions. If "window" doesn't sound familiar, read on.
Already a window expert? Skip to [what's new](#new features).

A window is the structure you run your window function `OVER`. It has three
components:

- partitioning
- ordering
- frame

You use partitioning to break your input data into independent chunks. Ordering
is to order rows within the partition. And frame is a kind of “sliding window”.
For every processed row, the frame encloses a certain portion of the sorted
partition. Your window function processes this portion and yields the result
for the row.

A “running average” is one simple example:

```
SELECT avg(totalprice) OVER (
    PARTITION BY custkey
    ORDER BY orderdate
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM orders
```

For a particular customer identified by `custkey`, it sorts their orders by
date and computes a sequence of average prices since the beginning up to each
consecutive entry. The window frame for a row includes all rows from the start
up to and including that row.

![](/assets/blog/window-features/running-average.svg)

According to standard SQL, there are 3 ways to specify the frame. The first way
is `ROWS` (like in the example). With `ROWS`, you can specify frame bounds by a
physical offset from the current row. While `ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW` means “between the beginning of the partition and the current
row”, you can also specify precisely where the frame starts and ends, for
example with: `ROWS BETWEEN 10 PRECEDING AND 5 FOLLOWING`.

`RANGE` is a more complicated way of defining frame on ordered data. It does
not rely on physical offset (in rows), but on logical offset (in value). That
is, the frame includes rows where the value is within a certain range from the
value in the current row.

Until recently, Trino only supported `RANGE` in limited cases.
You could use `RANGE UNBOUNDED PRECEDING`, `CURRENT ROW` and `UNBOUNDED
FOLLOWING`:

- `UNBOUNDED PRECEDING` includes all rows since the partition start,
- `UNBOUNDED FOLLOWING` includes all rows until the partition end,
- `CURRENT ROW` is trickier. It includes all rows where values of the sort key
are the same as in the current row. We call them a _peer group_.

It's time to introduce the first new feature:

## <a name="new features"/> Full support for frame type RANGE

Since [version 346]({{site.url}}/docs/current/release/release-346.html), it is
possible to specify `RANGE` with an offset value. The frame includes all rows
whose value is within this range from the current row.

Let's modify our example:

```
SELECT avg(totalprice) OVER (
    PARTITION BY custkey
    ORDER BY orderdate
    RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW)
FROM orders
```

Now, for every row, we get the average price from the preceding month. Note that
the offset `interval '1' month` applies to `orderdate`, which is the sorting
column.

![](/assets/blog/window-features/running-average-range.svg)

Of course, we don't have to order by date. The sorting column can be of any
numeric or date/time type, and the offset must be compatible. Also, the offset
doesn't have to be a literal. It can come in another column of a table or,
generally, it can be any expression, as long as the type matches.

A frame of type `RANGE` does not quite fit in the abstraction of a “sliding
window”. Frames can be bigger or smaller depending not only on the offset
values but also on the actual input data. A long series of similar entries can
produce a huge frame, while a gap in input values can result in an empty frame.

For illustration, imagine a group of students, and the results of some test they
took. Our table has two columns: `student_id` and `result`, which is the number
of points. For each student, let's find how many students did better by 1 to 2
points:

```
WITH students_results(student_id, result) AS (VALUES
    ('student_1', 17),
    ('student_2', 16),
    ('student_3', 18),
    ('student_4', 18),
    ('student_5', 10),
    ('student_6', 20),
    ('student_7', 16))
SELECT
    student_id,
    result,
    count(*) OVER (
        ORDER BY result
        RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING) AS close_better_scores_count
FROM students_results;

 student_id | result | close_better_scores_count
------------+--------+---------------------------
 student_5  |     10 |                         0
 student_7  |     16 |                         3
 student_2  |     16 |                         3
 student_1  |     17 |                         2
 student_3  |     18 |                         1
 student_4  |     18 |                         1
 student_6  |     20 |                         0
(7 rows)
```

Note that the frame does not contain the current row. For a particular student,
it only includes students with better results, and not themselves. For the
unfortunate `student_5`, there are no students with similar test results. The
frame is also empty for the lucky `student_6` who scored the most points.

![](/assets/blog/window-features/students-range.svg)

Besides `ROWS` and `RANGE`, there is another way to specify the frame on
ordered data. And yes, Trino supports this mechanism! Let me introduce the
second of our recent additions:

## Support for frame type GROUPS

This feature, added in
[version 346]({{site.url}}/docs/current/release/release-346.html), allows you to
include or exclude the whole _peer groups_ of rows in ordered data.

For illustration, let's consider again the `students_results` table. For each
student, let's find the gap between their result and the result of a student (or
students) who did slightly better.

```
WITH students_results(student_id, result) AS (VALUES
    ('student_1', 17),
    ('student_2', 16),
    ('student_3', 18),
    ('student_4', 18),
    ('student_5', 10),
    ('student_6', 20),
    ('student_7', 16))
SELECT
    student_id,
    result,
    max(result) OVER (
        ORDER BY result
        GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING) - result AS gap_till_better_score
FROM students_results;

 student_id | result | gap_till_better_score
------------+--------+-----------------------
 student_5  |     10 |                     6
 student_7  |     16 |                     1
 student_2  |     16 |                     1
 student_1  |     17 |                     1
 student_3  |     18 |                     2
 student_4  |     18 |                     2
 student_6  |     20 |                     0
(7 rows)
```

The window function for each student returns the closest better result. The
frame of type `GROUPS` used here, includes all entries equal to the current
entry in terms of points (that is the student's _peer group_), and the next
group.

![](/assets/blog/window-features/students-groups.svg)

In frames of type `GROUPS`, like in other frame types, the offset doesn't have
to be constant. It can be any expression, as long as its type is exact numeric
with scale 0. Simply put, we can skip any integer number of groups.

### Under the covers

How do we deal with finding the frame bounds effectively? With `ROWS` it's easy.
We only need to skip a determined number of rows forward or backwards.

With `RANGE`, we need to examine the actual values to see if they fall within
the given range. Our approach is optimized for the case where the offset values
are constant for all rows. Our solution involves caching frame bounds computed
for the preceding row, and using them as the starting point to find frame
bounds for the current row. Ideally, we never have to move the frame bounds
back as we process subsequent rows. In such a case, the amortized cost of frame
bound calculations per row is constant.

![](/assets/blog/window-features/sliding-frame-range.svg)

Our strategy for determining frame bounds for `GROUPS` is similar. We cache the
frame bounds computed for the preceding row and use them as the starting point
for the current row. If the frame offset is constant, frame bounds slide from
one peer group to another every time the processed row leaves one peer group and
enters the next one.

![](/assets/blog/window-features/sliding-frame-groups.svg)

## Support for WINDOW clause

As all the preceding examples show, a window function is a big chunk of syntax.
What if we wanted to use several window functions over the same window? Say, we
need an average price and a total price from the preceding month. And the top
price. Does it have to look like the below?

```
SELECT
    avg(totalprice) OVER (
        PARTITION BY custkey 
        ORDER BY orderdate
        RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW),
    sum(totalprice) OVER (
        PARTITION BY custkey 
        ORDER BY orderdate
        RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW),
    max(totalprice) OVER (
        PARTITION BY custkey 
        ORDER BY orderdate
        RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW)
FROM orders
```

Well, no more. Starting with
[Trino 352]({{site.url}}/docs/current/release/release-352.html), you can
predefine a window specification, and then use it or redefine it wherever you
need. This is thanks to the third of our new additions: support for `WINDOW`
clause.

Technically speaking, the `WINDOW` clause is part of the `FROM` clause:

```
SELECT …
    FROM …
        WHERE …
        GROUP BY …
        HAVING …
        WINDOW …
ORDER BY …
OFFSET …
LIMIT / FETCH …
```

In the `WINDOW` clause, you can define any number of named windows. Then you
can simply refer to them by their names in the `SELECT` list or an `ORDER BY`
clause.

Let's check how the `WINDOW` clause helps with our example query:

```
SELECT 
	avg(totalprice) OVER w,
	sum(totalprice) OVER w,
	max(totalprice) OVER w
FROM orders
WINDOW w AS (
    PARTITION BY custkey
    ORDER BY orderdate
    RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW)
```

To be even more concise, the `WINDOW` clause allows you to define more
specialized windows from existing window definitions:

```
WINDOW 
	w1 AS (PARTITION BY custkey),
	w2 AS (w1 ORDER BY orderdate),
	w3 AS (w2 RANGE BETWEEN interval '1' month PRECEDING AND CURRENT ROW)
```

Alternatively you can define the window only partially and then complete it
where it's used:

```
SELECT 
	avg(totalprice) OVER (w ROWS BETWEEN 10 PRECEDING AND CURRENT ROW) AS recent_average,
	sum(totalprice) OVER (w ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING) AS next_buys,
FROM orders
    WINDOW w AS (PARTITION BY custkey ORDER BY orderdate)
```

There are some ANSI rules, though, you need to follow when redefining windows:

- `PARTITION BY` is only allowed in the base definition,
- `ORDER BY` can only be specified once in the named windows reference chain,
- frame can only be specified in the final definition.

In case you wonder, there's no need to worry if some predefined windows are
eventually unused. Unused windows do not affect the efficiency of your query
execution. Partitioning, sorting and frame bound computations are costly
operations. That's why we made sure that unused window parts do not appear in
the query plan.

There's one last detail about the `WINDOW` clause that needs clarification. The
columns referenced in the `WINDOW` clause are columns of the input table. In the
following example, `country_code` is clearly a column of the table `countries`:

```
... FROM countries WINDOW w AS (ORDER BY country_code)
```

Obvious enough. Why am I telling this?

Window functions can be used in two different clauses of a query, `SELECT` and
`ORDER BY`. With the `ORDER BY` clause, there is a rule that column references
used there refer to the output table rather than the input table. Consider this
query:

```
WITH countries(country_code) AS (VALUES 'pol', 'CAN', 'USA')
SELECT upper(country_code) AS country_code
    FROM countries
    WINDOW w AS (ORDER BY country_code)
ORDER BY row_number() OVER w
```

Window `w` is used in the `ORDER BY` clause. So, does the window's ordering use
the original `country_code` column from the input table, or does it "see" the
uppercased `country_code` from the output table?

![](/assets/blog/window-features/country-code.svg)

The SQL spec is clear about it: a column reference in the named window always
refers to the original column, no matter where you use this window. In the
example, the result is ordered according to the original values: lowercase `pol`
after uppercase `USA`:

![](/assets/blog/window-features/country-code-result.svg)

As expected: 

```
 country_code
--------------
 CAN
 USA
 POL
(3 rows)
```

And here the story ends. Thanks for your attention! I hope you enjoy Trino's
new superpowers. In case of questions or issues — <a href="/slack.html">you
know where to find us</a>. More goodies are on the way, so stay tuned! How
about regex matching on tables?



