---
layout: post
title: "Time travel in Delta Lake connector"
author: Yuya Ebihara
excerpt_separator: <!--more-->
image: /assets/images/logos/trino-delta.png
show_pagenav: true
---

Exciting news - time travel capability has finally arrived in the Delta Lake
connector! After introducing support for time travel in the Iceberg connector
back in 2022, we're thrilled to announce that the Delta Lake connector now joins
the ranks as the second connector offering this feature.

<!--more-->

## Background and motivation

Time travel as a feature has a number of practical use cases:

* **Data recovery and rollback**: In the event of data corruption or erroneous
   updates, time travel allows users to roll back to a previous version of the
   data, restoring it to a known good state.
* **Auditing and compliance**: Time travel enables auditors and compliance
   teams to analyze data changes over time, ensuring regulatory compliance and
   providing transparency into data operations.
* **Historical analysis**: Data analysts and data scientists can perform
   historical analysis by querying data at different points in time, uncovering
   trends, patterns, and anomalies that may not be apparent in current data.


## Time travel SQL example

Start by creating a catalog `example` with the [Delta Lake
connector]({{site.url}}/docs/current/connector/delta-lake.html), create a `demo`
schema, and make it the current catalog with the
[USE]({{site.url}}/docs/current/sql/use.html) statement.

```sql
USE example.demo;
```

Let's create a Delta Lake table, add some data, modify the table and add some
more data using the following SQL statement:

```sql
CREATE TABLE users(id int, name varchar) WITH (column_mapping_mode = 'name');
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Mallory');
ALTER TABLE users DROP COLUMN name;
INSERT INTO users VALUES 4;
```

Use the following statement to look at all data in the table:

```sql
SELECT * FROM users ORDER BY id;
```

```text
 id
----
  1
  2
  3
  4
```

The `$history` metadata table offers a record of past operations:

```sql
SELECT version, timestamp, operation
FROM "users$history";
```

```text
 version |             timestamp              |  operation
---------+------------------------------------+--------------
       0 | 2024-04-10 17:49:18.528 Asia/Tokyo | CREATE TABLE
       1 | 2024-04-10 17:49:18.755 Asia/Tokyo | WRITE
       2 | 2024-04-10 17:49:18.929 Asia/Tokyo | DROP COLUMNS
       3 | 2024-04-10 17:49:19.137 Asia/Tokyo | WRITE
```

You can specify the version using `FOR VERSION AS OF`. For example, to time
travel to version 1, which includes a `WRITE` operation, the query would look
like this:

```sql
SELECT *
FROM users FOR VERSION AS OF 1;
```

As you can see, time travel not only rolls back the data but also the table definition:

```sql
 id |  name
----+---------
  1 | Alice
  2 | Bob
  3 | Mallory
```

## Technical details

Delta Lake manages transaction logs in the `_delta_log` directory located under
the table's specified location.

* **Last checkpoint**: The optional file that manages the last checkpoint
version is named `_last_checkpoint`.
* **Delta log entries**: The JSON file contains an atomic set of actions, for
  example `00000000000000000000.json`
* **Checkpoints**: The Parquet file contains the complete replay of all actions,
up to and including the checkpointed table version, for example
`00000000000000000010.checkpoint.parquet`

More details are available in the [Delta Lake protocol
documentation](https://github.com/delta-io/delta/blob/master/PROTOCOL.md).


Following is an example of the `_delta_log` directory:

```text
00000000000000000000.json
00000000000000000001.json
00000000000000000002.json
00000000000000000003.json
00000000000000000003.checkpoint.parquet
00000000000000000004.json
00000000000000000005.json
...
_last_checkpoint
```

When the specified version is older than the last checkpoint, such as version 2,
the connector reads the transaction log files starting from the initial
checkpoint file (`00000000000000000000.json`) up to the specified version
(`00000000000000000002.json`).

When the specified version is equal to the last checkpoint, in our example
version 3, the connector reads only the checkpoint file for that version
(`00000000000000000003.checkpoint.parquet`).

When the specified version is newer than the last checkpoint, so version 4, the
connector reads the checkpoint file for the last checkpoint version
(`00000000000000000003.checkpoint.parquet`) and the transaction log file for the
specified version (`00000000000000000004.json`).

The actual logic without the last checkpoint is more complex because the
connector cannot determine the checkpoints without listing file names in the
`_delta_log` directory.

## Conclusion

Time travel in the Trino [Delta Lake
connector]({{site.url}}/docs/current/connector/delta-lake.html) opens up new
possibilities for data exploration and analysis, empowering users to delve into
the past and derive insights from historical data. By seamlessly integrating
with Delta Lake's versioning and transaction logs, Trino provides a powerful
tool for querying data as it appeared at different points in time. Whether it's
auditing, historical analysis, or data recovery, time travel adds a valuable
dimension to data-driven decision-making, making it an indispensable feature for
modern data platforms.

## Bonus

Join us for [Trino Fest 2024]({% post_url 2024-02-20-announcing-trino-fest-2024
%}) where [Marius Grama](https://github.com/findinpath) presents *"The open
source journey of the Trino Delta Lake connector"* and shares more tips and
tricks.