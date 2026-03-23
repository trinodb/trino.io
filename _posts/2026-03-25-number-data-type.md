---
layout: post
title: "Introducing the NUMBER data type"
author: "Piotr Findeisen, Starburst Data"
excerpt_separator: <!--more-->
---

One of Trino's core strengths is breaking down data silos—enabling data
engineers to query diverse data sources through a single SQL interface. However,
when those sources use high-precision numeric types beyond Trino's 38-digit
DECIMAL limit, that promise breaks down. Users faced an impossible choice: skip
the columns entirely and lose access to critical data, or accept lossy rounding
that compromises data integrity.

This challenge required a new approach: a dedicated data type for high-precision,
variable-scale decimals.

<!--more-->

Adding a new built-in data type to Trino is exceptionally rare. The last time we
introduced a new type was the UUID type in May 2019—nearly seven years ago.
Types are fundamental building blocks that touch many parts of the system, from
the type registry, through coercion rules to connectors, functions, and the protocol.
They require careful design and long-term commitment.

With Trino 480, we're excited to introduce the NUMBER type—a high-precision
decimal type that breaks down these data silos and enables seamless access to
numeric data across diverse database systems. This addition is particularly
powerful for data engineers working with Oracle, PostgreSQL, MySQL, MariaDB, and
SingleStore, which support numeric precision beyond the traditional 38-digit
DECIMAL limit.

Let's explore why NUMBER matters, how it works, and how it will simplify your
data integration workflows.

## The challenge: precision beyond 38 digits

Trino's DECIMAL type has long supported exact numeric values with precision up
to 38 decimal digits, which covers the vast majority of use cases. However,
many database systems support higher precision:

* **Oracle NUMBER**: when declared as `NUMBER(p, s)`, precision must be in [1, 38] and
  scale in [-84, 127]. When declared as `NUMBER` without precision/scale, each value
  can have different scale, and actual precision can reach 40 decimal digits. Oracle can
  store values from 10^-130 to (but not including) 10^126.
* **PostgreSQL NUMERIC**: supports precision and scale in range from -1000 to 1000;
  supports very high precision numbers with up to 131,072 digits before the decimal point.
  When declared without precision/scale constraints, each value can have different scale.
* **MySQL, MariaDB, SingleStore DECIMAL**: up to 65 digits of precision (scale 0-30)

Before Trino 480, accessing these high-precision numeric columns required
choosing between two unsatisfying options:

1. **Skip the columns entirely** and lose access to potentially critical data.
   This was the default behavior.
2. **Accept lossy conversions** - Use `decimal-mapping=ALLOW_OVERFLOW` with
   `decimal-default-scale=S` to force values into `DECIMAL(38, S)`, losing precision
   through rounding and failing for numbers greater than or equal to 10^(38-S).
   For example, with scale 10, values ≥ 10^28 would fail.

Neither option is ideal for data federation and warehousing scenarios where
preserving data fidelity is essential.

## Enter NUMBER: arbitrary-precision decimals in Trino

The NUMBER type solves this problem by supporting floating-point decimal numbers
of high precision and flexible scale. In practice, NUMBER supports values with
up to 200 digits of precision -- far exceeding what most database workloads require.
Each value can have a different scale, allowing for values as small as 10^-16000
(or even smaller) and as large as 10^16000 (or even larger) within the same column.

Here's what NUMBER looks like in action:

```sql
-- High-precision literal (50+ digits)
SELECT NUMBER '3.1415926535897932384626433832795028841971693993751';
```

```text
 3.1415926535897932384626433832795028841971693993751
```

```sql
-- Scientific notation with extreme precision
SELECT NUMBER '12345678901234567890123456789012345678901234567890e30';
```

```text
 1.234567890123456789012345678901234567890123456789E+79
```

```sql
-- Verify the type
SELECT typeof(NUMBER '123.456');
```

```text
 number
```

### Special values

NUMBER also supports special values similar to IEEE 754 floating-point types:

```sql
SELECT
  NUMBER 'Infinity' as positive_infinity,
  NUMBER '-Infinity' as negative_infinity,
  NUMBER 'NaN' as not_a_number;
```

```text
 positive_infinity | negative_infinity | not_a_number
-------------------+-------------------+--------------
 +Infinity         | -Infinity         | NaN
```

These special values follow intuitive comparison and ordering semantics that
follow DOUBLE behavior. `NaN` compares as inequal to all values, including
itself. Any comparison with `NaN` returns false. When sorting, values are
ordered as follows: `-Infinity`, all finite values, `+Infinity` followed by `NaN`.

The special values are particularly useful for handling edge cases in source data.
In particular, PostgreSQL's NUMERIC type can represent `NaN` and `Infinity`, and
these values are now seamlessly mapped to NUMBER when queried through the PostgreSQL
connector.

## Seamless connector integration

The real power of NUMBER becomes apparent when querying external databases. Five
connectors now automatically map high-precision numeric types to NUMBER,
requiring **no configuration changes**:

### Oracle connector

Oracle's NUMBER type supports variable precision and scale. The Oracle connector
now maps:

* `NUMBER(p, s)` where p > 38 → Trino `NUMBER`
* `NUMBER` without precision/scale → Trino `NUMBER`
* `NUMBER` with extreme scale values → Trino `NUMBER`

```sql
-- Query an Oracle table with high-precision columns
SELECT order_id, unit_price, extended_price
FROM oracle.sales.orders
WHERE extended_price > NUMBER '1000000000000000000000000';
```

### PostgreSQL connector

PostgreSQL's NUMERIC type supports very high precision and even "unconstrained"
precision. The connector automatically handles:

* `NUMERIC(p, s)` where p > 38 → Trino `NUMBER`
* `NUMERIC` without precision/scale → Trino `NUMBER`

```sql
-- Access PostgreSQL scientific data without precision loss
SELECT measurement_id, precise_value -- a NUMERIC column
FROM postgresql.lab.measurements
```

### MySQL, MariaDB, and SingleStore connectors

These MySQL-compatible databases support DECIMAL precision up to 65 digits. The
connectors now map:

* `DECIMAL(p, s)` where p > 38 → Trino `NUMBER`

```sql
-- Join across different databases with high precision
SELECT
  m.account_id,
  m.balance as mysql_balance,
  o.balance as oracle_balance
FROM mysql.banking.accounts m
JOIN oracle.banking.accounts o ON m.account_id = o.account_id
WHERE abs(m.balance - o.balance) > NUMBER '0.01';
```

## Backwards compatibility and migration

The NUMBER type integration is designed to be seamless and backward compatible:

### Automatic mapping

If you previously relied on the default behavior (no `decimal-mapping`
configuration), your queries now automatically use NUMBER for high-precision
columns. No configuration changes needed.

### Legacy configurations still work

If you explicitly configured `decimal-mapping=ALLOW_OVERFLOW` or
`decimal-mapping=STRICT`, your existing configuration continues to work. The
NUMBER mapping is disabled when these options are set, ensuring no surprises.

However, the `decimal-mapping` configuration and related session properties
(`decimal_mapping`, `decimal_default_scale`, `decimal_rounding_mode`) are now
**deprecated** and will be removed in a future Trino release. We recommend
migrating to NUMBER-based workflows:

**Before (with lossy conversion):**
```properties
# catalog/postgresql.properties
connection-url=jdbc:postgresql://host:5432/database
connection-user=user
connection-password=password
decimal-mapping=ALLOW_OVERFLOW
decimal-default-scale=10
decimal-rounding-mode=HALF_UP
```

**After (lossless with NUMBER):**
```properties
# catalog/postgresql.properties
connection-url=jdbc:postgresql://host:5432/database
connection-user=user
connection-password=password
# No decimal-mapping needed - NUMBER is used automatically!
```

For Oracle, if you previously used `oracle.number.rounding-mode` to handle
high-precision NUMBER columns, you can now remove this configuration to enable
native NUMBER mapping.

## Working with NUMBER

### Type conversions

NUMBER integrates naturally with Trino's type system:

```sql
-- Convert from other numeric types
SELECT
  CAST(DECIMAL '123.45' AS NUMBER) as from_decimal,
  CAST(12345 AS NUMBER) as from_integer,
  CAST(123.45e0 AS NUMBER) as from_double;
```

```text
 from_decimal | from_integer | from_double
--------------+--------------+-------------
 123.45       | 12345        | 123.45
```

```sql
-- Convert NUMBER to other types
SELECT
  CAST(NUMBER '123.456' AS BIGINT) as to_bigint,
  CAST(NUMBER '123.456' AS DOUBLE) as to_double,
  CAST(NUMBER '123.456' AS DECIMAL(10,2)) as to_decimal;
```

```text
 to_bigint | to_double | to_decimal
-----------+-----------+------------
 123       | 123.456   | 123.46
```

### Aggregate functions

Common aggregate functions work naturally with NUMBER:

```sql
-- Aggregate high-precision values
SELECT
  department,
  sum(revenue) as total_revenue,
  avg(revenue) as average_revenue,
  min(revenue) as min_revenue,
  max(revenue) as max_revenue
FROM oracle.sales.transactions
GROUP BY department;
```

### Creating tables with NUMBER columns

The Oracle and PostgreSQL connectors support creating tables with NUMBER columns:

```sql
-- Create a PostgreSQL table with NUMBER column
CREATE TABLE postgresql.schema.measurements (
  id BIGINT,
  precise_value NUMBER
);

-- Create an Oracle table with NUMBER column
CREATE TABLE oracle.schema.scientific_data (
  experiment_id VARCHAR(50),
  measurement NUMBER
);
```

## Technical characteristics and limitations

While NUMBER provides high precision, it's important to understand its
characteristics:

### Precision and scale

Trino's NUMBER type characteristics:

* **Supported precision**: currently 200 decimal digits.
  While we consider this an implementation detail that may change in future releases,
  it is unlikely that maximum precision will be decreased.
* **Scale range**: -16,384 to 16,383
* **Variable scale**: each value can have a different scale, similar to
  PostgreSQL NUMERIC and Oracle NUMBER
* **Special values**: supports `NaN`, `Infinity`, and `-Infinity`

Comparison of decimal numeric types across database systems:

| Database                          | Max Precision | Scale Range               | Variable Scale |
|-----------------------------------|---------------|---------------------------|----------------|
| Oracle NUMBER(p, s)               | 38            | -84 to 127                | No             |
| Oracle NUMBER                     | 40            | Approximately -130 to 126 | Yes            |
| PostgreSQL NUMERIC(p, s)          | 38            | -1000 to 1000             | No             |
| PostgreSQL NUMERIC                | 131,072       | -1000 to 1000             | Yes            |
| MySQL/MariaDB/SingleStore DECIMAL | 65            | 0 to 30                   | No             |
| Trino DECIMAL                     | 38            | 0 to 38                   | No             |
| **Trino NUMBER**                  | **200**       | **-16,384 to 16,383**     | **Yes**        |

### Storage and representation

NUMBER uses a variable-width binary format optimized for flexibility:
* 2-byte header encoding sign and scale
* Variable-length magnitude in big-endian format
* The binary format is considered unstable and may evolve in future releases to
  enable optimizations and performance improvements

This flexibility allows Trino to improve NUMBER's internal representation over
time without breaking connector compatibility.
Trino SPI provides a stable API for connectors to read and write NUMBER values,
abstracting away the internal format.

### Performance considerations

NUMBER uses Java's BigDecimal for arithmetic operations, which provides exact
precision at the cost of being slower than fixed-precision types like BIGINT,
DOUBLE or DECIMAL. For this reason, NUMBER is designed for scenarios where
precision is more important than computational speed:

* **Best for**: reading and storing high-precision data from source systems,
  data federation, reporting, data warehousing
* **Not optimal for**: computational heavy-lifting, complex mathematical
  operations, high-performance analytics on numeric columns

If your workload involves extensive numeric computation, consider whether DECIMAL
(for up to 38 digits), DOUBLE (for approximate arithmetic), or BIGINT (for
integer arithmetic) might be more appropriate.

### Function support

NUMBER supports essential operations:
* Arithmetic: `+`, `-`, `*`, `/`
* Aggregations: `sum()`, `avg()`, `min()`, `max()`
* Rounding functions: `abs()`, `sign()`, `ceiling()`, `floor()`, `truncate()`,
  `round()`
* Special value checks: `is_nan()`, `is_finite()`, `is_infinite()`

Many advanced mathematical functions (trigonometric, logarithmic, etc.)
do not work with NUMBER directly and require explicit type conversions to DOUBLE or DECIMAL.

## What's next

The NUMBER type support will continue to evolve. Additional connectors are
planned for future releases:

* **ClickHouse**: for Decimal256 type mapping
* **Apache Ignite**: for high-precision numeric support

We're also exploring performance optimizations and expanding function support
based on community feedback.

## Getting started

NUMBER support is available now in Trino 480. To start using it:

1. **Upgrade to Trino 480** - NUMBER is available out of the box
2. **Remove deprecated configs** - If you used `decimal-mapping` configurations,
   consider removing them to enable automatic NUMBER mapping
3. **Query your data** - High-precision columns are now accessible without
   configuration

For detailed documentation, refer to:
* [NUMBER type reference]({{site.baseurl}}/docs/current/language/types.html)
* [Oracle connector documentation]({{site.baseurl}}/docs/current/connector/oracle.html)
* [PostgreSQL connector documentation]({{site.baseurl}}/docs/current/connector/postgresql.html)
* [MySQL connector documentation]({{site.baseurl}}/docs/current/connector/mysql.html)
* [MariaDB connector documentation]({{site.baseurl}}/docs/current/connector/mariadb.html)
* [SingleStore connector documentation]({{site.baseurl}}/docs/current/connector/singlestore.html)

Have questions or feedback? Join the discussion on the [Trino community
Slack]({{site.url}}/slack.html) in the `#dev` channel, or open an issue on
[GitHub](https://github.com/trinodb/trino/issues).

The NUMBER type represents a significant milestone in Trino's evolution,
eliminating precision loss barriers and making high-precision numeric data from
diverse sources readily accessible for analytics and reporting. We're excited to
see how the community uses this powerful new capability!

□
