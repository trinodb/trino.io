---
layout: post
title:  "A decade of query engine innovation"
author: "Manfred Moser, Martin Traverso, Dain Sundstrom, David Phillips"
excerpt_separator: <!--more-->
---

It's amazing how far we have come! Our massively-parallel processing SQL query
engine, Trino, has really grown up. We have moved beyond just querying object
stores using Hive, beyond just one company using the project, beyond usage in
Silicon Valley, beyond simple SQL `SELECT` statements, and definitely also
beyond our expectations. Let’s have a look at some of the great technical and
architectural changes the project underwent, and how we all benefit from the
[commitment to quality, openness and collaboration]({% post_url
2022-08-02-leaving-facebook-meta-best-for-trino %}).

<!--more-->

## Runtime and deployment

Starting with how you even run Trino and install it, numerous changes came about
in the last decade. We moved from Java 7 to Java 8, then to Java 11, and [only
recently to the latest supported Java LTS release - Java 17]({% post_url
2022-07-14-trino-updates-to-java-17 %}). Each time we
benefited from the innovations in the runtime performance as well as the
improved Java language features. With **Java 17**, we are just about to start a lot
of these improvements.

When it comes to actually [running and deploying
Trino]({{site.url}}/episodes/35.html), the **tarball** is still a good choice
for simple installation and as a base for other packages. Over time we added
**RPM** archive support, which is being replaced more and more by Docker
**containers**. The container images also enable modern deployment on Kubernetes
with [our Helm chart](https://github.com/trinodb/charts).

And let us add one last note about deployments. Trino was always designed to
work on large servers. However the actual growth in a decade in the real world
has amazing to see. Machine sizes keep growing to hundreds of CPU cores and
closer to a terabyte of memory, and these truly large machines are now running
as clusters with many workers of that size. And more and more of these
deployments take advantage of our added support for the **ARM processor
architecture** and the increasing availability of suitable servers from the
cloud providers.

## Security

What is security, authentication, authorization? In the beginning none of this
existed in the first releases of Trino. Two years after launch we added first
simple authentication and authorization support. Today the days when Kerberos
was critical, and you needed to use the Java KeyStore in most deployments are
long gone. The wide adoption of Trino led to improvements such as support for
[automatic certificate creation and TLS for internal
communication](https://trino.io/docs/current/security/internal-communication.html),
[secret injection from environment
variables](https://trino.io/docs/current/security/secrets.html), and the many
[authentication
types](https://trino.io/docs/current/security/authentication-types.html)
starting with LDAP and password file, to the modern OAuth2.0 and SSO systems.
Trino supports fine-grained access control and [security management SQL commands
like `GRANT` and
`REVOKE`](https://trino.io/docs/current/language/sql-support.html#security-operations).
You can secure connections from client tools, and use numerous methods to ensure
secured access to your data sources.

## Client tools and integrations

In the very beginning all you could do is submit a query to the [client REST
API](https://trino.io/docs/current/develop/client-protocol.html). Very quickly
we added the [Trino CLI](https://trino.io/docs/current/installation/cli.html)
and the [JDBC driver](https://trino.io/docs/current/installation/jdbc.html). And
while it has continued to be widely used in the community, and gathered great
features such as command-completion and history, different output formats, and
much more, the Trino CLI is not the only tool anymore. The JDBC driver, the
[Python client](https://github.com/trinodb/trino-python-client), the [Go
client](https://github.com/trinodb/trino-go-client), and the ODBC driver from
[Starburst](https://starburst.io/), all expanded the support for different
client tools. You can query Trino in your Java-based IDE, such as IntelliJ
IDEA, or database tool, such as [DBeaver](https://dbeaver.io/) or
[Metabase](https://www.metabase.com/). You can take advantage of visualizations
in [Apache Superset](https://superset.apache.org/), or automate with [Apache
Airflow](https://airflow.apache.org/), [dbt](https://www.getdbt.com/), or
[Apache Flink](https://flink.apache.org/). And many commercial tools such as
[Tableau](https://www.tableau.com/), [Looker](https://www.looker.com/),
[PowerBI](https://powerbi.microsoft.com/), or
[ThoughtSpot](https://www.thoughtspot.com/) also proudly support Trino users.

## SQL

All the client tools and integrations rely on the rich SQL support of Trino,
which has grown tremendously. Purely analytics-related support for `SELECT` and
all its complexities was not enough. Trino gained support for data management to
create schema and tables, but also views and materialized views. And with that
[write support we needed `INSERT`, `UPDATE`, and
`DELETE`](https://trino.io/docs/current/language/sql-support.html#write-operations).
That’s all done and `MERGE` is next. But the core language features were not
able to satisfy the needs of our users. We added functions for a large variety
of topics ranging from simple string and [date
functions](https://trino.io/docs/current/functions/datetime.html) to [JSON
support](https://trino.io/docs/current/functions/json.html), [geospatial
functions](https://trino.io/docs/current/functions/geospatial.html), and many
others.

From the core language perspective we added newer SQL functionality, such as
[window functions and `MATCH_RECOGNIZE` support]({% post_url
2021-05-19-row_pattern_matching %}). Currently we are on a journey to implement
[support for table functions, including polymorphic table functions]({% post_url
2022-07-22-polymorphic-table-functions %}).

## Connectors and data sources

When it comes to the new SQL language features, there are two categories. There
are generic functions and statements that build on top of commonly used
functionality like `SELECT`. These typically work with any connector and therefore
any data sources. And then there are SQL language features that need support in
a connector. After all, inserting data in PostgreSQL and an object storage
system are very different. Our community has been hard at work however, and
numerous connectors have gone way beyond simple read-only access.

Looking at the number of available connectors, innovation has been tremendous.
The original Hive connector with support for HDFS and a Hive Metastore Service,
became a powerhouse of features. Support for object storage systems including
Amazon S3 and compatible systems, Azure Data Lake Storage, and Google Cloud
Storage, was supplemented by support for Amazon Glue as metastore. We also
constantly added support for different file formats in these systems, and
improved performance for ORC, Parquet, Avro, and others.

The initial idea to support other data sources led to connectors for over a
dozen other databases, including relational systems such
[PostgreSQL](https://www.postgresql.org/),
[Oracle](https://www.oracle.com/database/), [SQL
Server](https://www.microsoft.com/en-us/sql-server), and many others. We also
gained support for [Elasticsearch](https://www.elastic.co/elasticsearch/) and
[OpenSearch](https://www.opensearch.org/), [MongoDB](https://www.mongodb.com/),
[Apache Kafka](https://kafka.apache.org/), and other systems that traditionally
are not available to query with SQL. Trino unlocks completely new use cases for
these systems.

The wide range of supported systems includes traditional data lakes and data
warehouses. With the emerging new table formats and the related Trino
connectors, our project is a powerful tool to run your lakehouse system. [Delta
Lake](https://delta.io/) and [Apache Iceberg](https://iceberg.apache.org/)
connectors are already capable of full read and write operations and include
numerous other features. An [Apache Hudi](https://hudi.apache.org/) connector is
in the works and coming soon.

We also have robust and widely used connectors for real-time analytics systems
like [Apache Pinot](https://pinot.apache.org/), [Apache
Druid](https://druid.apache.org/) and [Clickhouse](https://clickhouse.com/),
that are constantly improved by the community.

## Query processing and performance

Last but not least, these queries also need to be processed. From the start high
efficiency and low latency were a core design goal, and with features like
native compilation the resulting performance surpassed other systems. Over the
years our query analyzer and planner was supplemented by more and more
sophisticated algorithms and features. Connectors learned to retrieve and manage
table statistics, the optimizer was created and morphed into a [cost-based
optimizer]({% post_url 2019-07-04-cbo-introduction %}), and we added further
improvements that benefit query processing performance. We added dynamic
filtering, [dynamic partition pruning]({% post_url
2020-06-14-dynamic-partition-pruning %}), predicate pushdown, join pushdown,
aggregate function pushdown and numerous others. Each of these improvements was
also finely tuned, and runs in production with huge workloads providing us more
data on how to improve next.

One large pivot we recently added was the addition of [fault-tolerant query
execution mode]({% post_url 2022-05-05-tardigrade-launch %}). Queries execution
can survive cluster node failures when this feature is enabled. Parts of the
execution can be retried and query processing can proceed. Trino is moving on
from the best analytics engine to be the best query engine for many more use
case!

## Looking forward

As you can see there is a lot to look back to and celebrate. But while we are
definitely proud of our successes working with the community, we see no time to rest.
There are many more improvements we are working on. Just to tease you a bit, let
us just mention that there will be more polymorphic table functions, new
lakehouse connectors and features, more client tools, and maybe even dynamic
configuration of the cluster.

What would you like to add? Join us to celebrate and innovate towards your
favorite features. And who knows, we might see you in the [Trino Summit]({%
post_url 2022-06-30-trino-summit-call-for-speakers %}) in November, or in a
future episode of the [Trino Community Broadcast](/broadcast/index.html).
