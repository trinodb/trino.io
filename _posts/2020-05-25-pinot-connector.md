---
layout: post
title:  "Apache Pinot Connector"
author: Elon Azoulay
excerpt_separator: <!--more-->
---

Presto 334 introduces the new Apache Pinot™ Connector which allows Presto to query data stored in
[Apache Pinot™](https://pinot.apache.org/).
Not only does this allow access to Pinot tables but gives users the ability to do things they could not do with Pinot
alone such as join Pinot tables to other tables and use Presto's scalar functions, window functions and complex aggregations.

<!--more-->

# Coming In Release 334 of Presto

Introducing the new Apache Pinot™ Connector which allows Presto to query data stored in 
[Apache Pinot™](https://pinot.apache.org/).
Not only does this allow access to Pinot tables but gives users the ability to do things they could not do with Pinot
alone such as join Pinot tables to other tables and use Presto's scalar functions, window functions and complex aggregations.

Pinot udf's can be directly used by including the Pinot sql query in quotes, explained below in the "Pinot SQL Passthrough" section.
This enables aggregations and other complex query types to be done directly in Pinot.

This connector supports pinot-0.3.0 and newer.

# Setup

Create a properties file in the catalog directory, such as `etc/catalog/pinot.properties` which includes at least the
following to get started:

```
connector.name=pinot
pinot.controller-urls=host1:9000,host2:9000
```

The `pinot.controller-urls` is a comma separated list of controller hosts. If Pinot is deployed via [Kubernetes](https://kubernetes.io/) and you expose the 
the `pinot.controller-urls` needs to point to the controller Service endpoint. The Pinot broker and server must be accessible
via DNS as Pinot will return hostnames and not ip addresses.

If you have a smaller number of Pinot servers than Presto workers or a relatively small number of rows per Pinot segment,
you can minimize the requests to pinot by increasing the number of Pinot segments per split (default is 1 segment per split):

```
pinot.segments-per-split=15
```

If DNS resolution is slow or you get `Request timed out` errors, you can increase the request timeout as follows:

```
pinot.request-timeout=3m
```
 
# Schema

Pinot supports the following data types. Currently null values are not supported. The corresponding Presto datatypes are:

| Pinot Datatype | Presto Datatype |
| -------------- | --------------- |
| boolean | boolean |
| integer | integer |
| float, double | double |
| string, bytes* | varchar |
| integer_array | array(integer) |
| float_array, double_array | array(double) |
| long_array | array(bigint) |
| string_array | array(varchar) |

* The Pinot `bytes` type is converted to a hex-encoded varchar. See the [Pinot docs](https://pinot.apache.org/) for more information.  

# Pinot SQL Passthrough

If you would like to leverage Pinot's fast aggregations you can use a "dynamic" table where you specify the Pinot SQL 
query as the table name and it is passed directly to Pinot:

```sql
SELECT * 
FROM pinot.default."SELECT col3, col4, MAX(col1), COUNT(col2) FROM pinot_table GROUP BY col3, col4"
WHERE col3 IN ('FOO', 'BAR') AND col4 > 50
LIMIT 30000
``` 

The filter in the outer presto query will be pushed down into the Pinot query via Presto's [applyFilter()](https://github.com/prestosql/presto/blob/master/presto-spi/src/main/java/io/prestosql/spi/connector/ConnectorMetadata.java#L746). These queries are routed to the broker and
should not return huge amounts of data as broker queries currently return a single response with all the results. This
is more suited to aggregate queries.

Limits are pushed into the "dynamic" Pinot query via Presto's [applyLimit()](https://github.com/prestosql/presto/blob/master/presto-spi/src/main/java/io/prestosql/spi/connector/ConnectorMetadata.java#L727). The above query would yield the following Pinot PQL query:

Pinot functions such as `PERCENTILEEST` can be used in the quoted sql.

```sql
SELECT MAX(col1), COUNT(col2)
FROM pinot_table
WHERE col3 IN('FOO', 'BAR') and col4 > 50
LIMIT 30000
``` 

If you are returning a larger dataset you can issue a normal Presto query which will get routed to the Pinot servers which
store the Pinot segments. Filters and Limits are pushed down to Pinot for regular queries as well.

# Future Work

As Presto and Pinot continue to evolve the Pinot connector will leverage new features such as aggregation pushdown and more.

