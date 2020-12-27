---
layout: post
title:  "Apache Phoenix Connector"
author: Vincent Poon
---

[Presto 312]({{site.url}}/docs/current/release/release-312.html)
introduces a new [Apache Phoenix Connector]({{site.url}}/docs/current/connector/phoenix.html), 
which allows Presto to query data stored in [HBase](https://hbase.apache.org/)
using [Apache Phoenix](https://phoenix.apache.org/).  This unlocks new capabilities that previously
weren't possible with Phoenix alone, such as federation (querying of multiple Phoenix clusters) and
joining Phoenix data with data from other Presto data sources.

# Setup
To get started, simply drop in a new catalog properties file, such as `etc/catalog/phoenix.properties`,
which defines the following:

```
connector.name=phoenix
phoenix.connection-url=jdbc:phoenix:host1,host2,host3:2181:/hbase
phoenix.config.resources=/path/to/hbase-site.xml
```

The `phoenix.connection-url` is the standard Phoenix connection string, which contains the zookeeper
quorum host information and root zookeeper node.

The `phoenix.config.resources` is a comma separated list of configuration files, used to specify any
[custom connection properties](https://phoenix.apache.org/tuning.html).

# Schema
For the most part, data types in Phoenix match up with those in Presto, with a few
[minor exceptions]({{site.url}}/docs/current/connector/phoenix.html#data-types).  One thing
to note, however, is that tables in Phoenix require a primary key, whereas Presto has no concept of
primary keys.  To handle this, the Phoenix connector uses a table property to specify the primary key. 
For example, consider the following statement in Phoenix:

```sql
CREATE TABLE example (
  pk_part_1 varchar,
  pk_part_2 varchar,
  val bigint
  CONSTRAINT pk PRIMARY KEY (pk_part_1, pk_part_2)
)
```
The equivalent statement in Presto would look something like:

```sql
CREATE TABLE phoenix.default.example (
  pk_part_1 varchar,
  pk_part_2 varchar,
  val bigint
)
WITH (
  rowkeys = 'pk_part_1,pk_part2'
)
```

Additional Phoenix and HBase table properties can be specified in a 
[similar way]({{site.url}}/docs/current/connector/phoenix.html#table-properties-phoenix). 
Note also that the default (empty) schema in Phoenix will always map to a Presto schema named "default".

# Beyond MapReduce
When Phoenix users want to run long-running queries that scan over all/most of the data in a table,
they typically have used the Phoenix [MapReduce integration](https://phoenix.apache.org/phoenix_mr.html). 
However, this has limitations, as the document states:

>Note: The SELECT query must not perform any aggregation or use DISTINCT as these are not supported by our map-reduce integration.

This is because the framework only constructs simple Mappers which scan over each region.  To
do more complex operations like aggregations, the framework would need Reducers as well.
Someone could implement that, but then they would essentially be on the path towards rewriting
Hive from scratch.

Presto now provides the ability to do these more complex operations.  The Phoenix connector
performs the same filtered scans as the MapReduce framework, but now the Presto engine does
the aggregations, joins, etc.

# Federation
With the Phoenix connector, querying multiple Phoenix clusters is as easy as querying the
respective catalogs.  As a simple example, suppose we have one cluster in region `us-west` and
another cluster in `us-east`.  If we create two catalog files, `phoenix_west.properties` and
`phoenix_east.properties`, then we can query both:

```sql
SELECT 'us-west' as region, * FROM phoenix_west.default.example
UNION
SELECT 'us-east' as region, * FROM phoenix_east.default.example
```

# Joining with other data sources
Another nice feature of Presto is the ability to join data in Phoenix with other data sources.
Suppose we have the following tables:

```
customer (
  custkey bigint,
  comment varchar,
  ...
)
```
```
orders (
  orderkey bigint,
  custkey bigint,
  totalprice double,
  ...
)
```
Suppose further that:

* Either table can hold large amounts of data
* The customer `comment` field can change frequently
* We want to be able to query for orders with a certain `totalprice` range, and join with the
customer table to get the `comment` for these orders

Phoenix/HBase is a row-oriented storage solution with very fast lookup by primary key.  On the
other hand, ORC is a column-oriented file format that can filter results by column value very
efficiently.  So in this use case, it might make sense to store the `customer` table in Phoenix
with `custkey` as the primary key, and the `orders` table in ORC, perhaps in an object store like
S3.  We can then use Presto to leverage the strengths of each of our data stores and combine OLTP
with OLAP:

```sql
SELECT c.custkey, c.comment, o.totalprice
FROM phoenix.tpch.customer AS c
INNER JOIN
(
  SELECT custkey, totalprice FROM hive.tpch.orders WHERE totalprice < 100
) o
ON c.custkey = o.custkey
```

# Inserting/Updating data
In the prior example, since our `customer` data is coming from Phoenix, our OLTP store, we can
easily insert new data:

```sql
INSERT INTO phoenix.tpch.customer VALUES (101, 'some comment')
```
Since Presto's `INSERT` translates to Phoenix's `UPSERT`, inserting is the same as updating - i.e.
if there's already a `custkey` of 101, then the `comment` will get updated instead.

# Future work
With upcoming improvements to Presto, there will be opportunities to further optimize the performance
of the Phoenix connector.

One of the biggest ways Phoenix optimizes performance is through the use of 
[HBase coprocessors](https://www.3pillarglobal.com/insights/hbase-coprocessors), which allow custom
code to be run on each regionserver.  For example, to do aggregations, Phoenix runs a partial
aggregation in the coprocessor of each table region, and the result for each region is then passed
back to the client for a final aggregation.  That way, the table data itself doesn't need to be
sent from each region to the client - just the partial aggregation result.  However, currently only
filters are pushed down to the Phoenix connector.  With the ongoing work in Presto to support more
[complex pushdown]({{site.github_repo_url}}/issues/18) to connectors, we will be able to
pushdown operations like aggregations to the Phoenix connector, which in turn can push them further
down to the HBase coprocessors.

Another area of potential improvement is integration with Presto's 
[cost-based optimizer](https://www.starburstdata.com/technical-blog/introduction-to-presto-cost-based-optimizer/),
which can analyze table statistics to do things like join reordering. Phoenix already supports
[statistics collection](https://phoenix.apache.org/update_statistics.html), with more improvements
underway, so this is just a matter of integrating with the Presto statistics framework.

# Questions?
If you have any questions about the connector, or Phoenix in general, feel free to ask on the
Phoenix dev mailing list: [dev@phoenix.apache.org](mailto:dev@phoenix.apache.org).
