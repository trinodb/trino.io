---
layout: post
title:  "Trino 2021 Wrapped: A Year of Growth"
author: Brian Olsen, Martin Traverso, Manfred Moser
excerpt_separator: <!--more-->
---

As we reflect on Trino’s journey in 2021, one thing stands out. Compared to 
previous years we have seen even further accelerated, tremendous growth. Yes,
this is what all these year-in-retrospect blog posts say, but this has some 
special significance to it. This week marked the one-year anniversary since the 
project [dropped the Presto name and moved to the Trino name]({{site.url}}/blog/2020/12/27/announcing-trino.html).
Immediately after the announcement, the [Trino GitHub repository](https://github.com/trinodb/trino)
started trending in number of stargazers. Up until this point, the PrestoSQL
GitHub repository had only amassed 1,600 stargazers in the two years since it 
had split from the PrestoDB repository. However, within four months after the 
renaming, the number of stargazers had doubled. GitHub stars, issues, pull 
requests and commits started growing at a new trajectory.

<!--more-->

<p align="center">
 <a href="https://twitter.com/bitsondatadev/status/1344028682126565381" target="_blank">
   <img align="center" width="50%" src="/assets/blog/2021-review/trending.png"/>
 </a>
</p>

At the time of writing, we just hit 4,600 stargazers on GitHub. This means, we 
have grown by over 3,000 stargazers in the last year, a 187% increase. While we 
are on the subject, let's talk about the health of the Trino community.

## 2021 by the numbers

Let's take a look at the Trino project growth by the numbers:

* 3679 new commits 💻 in GitHub 
* 3015 new stargazers ⭐ in GitHub
* 2450 new members 👋 in Slack
* 1979 pull requests merged ✅ in GitHub
* 1213 issues 📝 created in GitHub
* 988 new followers 🐦 on Twitter
* 525 average weekly members 💬 in Slack
* 491 new subscribers 📺 in YouTube
* 23 Trino Community Broadcast ▶️ episodes
* 17 Trino 🚀 releases
* 13 blog ✍️ posts
* 10 Trino 🍕 meetups
* 1 Trino ⛰️ Summit

Along with the growth we've seen in GitHub, we have seen a 47% growth of [the Trino Twitter](https://twitter.com/trinodb) 
followers this year. [The Trino Slack community](https://trino.io/slack.html),
where a large amount of troubleshooting and development discussions occur, saw a
75% growth, nearing 6,000 members. Finally, [the Trino YouTube channel](https://www.youtube.com/c/TrinoDB)
has seen an impressive 280% growth in subscribers. 

A lot of the increase on this channel was due to the [Trino Community Broadcast](/broadcast/), 
that brought users and contributors from the community to cover 23 episodes
about the following topics:

* 7 episodes on the Trino ecosystem (dbt, Amundsen, Debezium, Superset) 
* 4 episodes on the Trino project (Renaming Trino, Intro to Trino, Trinewbies) 
* 4 episodes on Trino connectors (Iceberg, Druid, Pinot)
* 4 episodes on Trino internals (Distributed Hash-Joins, Dynamic Filtering, Views)
* 2 episodes on Trino using Kubernetes (Trinetes series)
* 2 episodes on Trino users (LinkedIn, Resurface)

While stargazers, subscribers, episodes, and followers tell the story of the 
growing awareness of the Trino project with the new name, what about the actual
rate of development on the project?

At the start of the year, there were 21,924 commits. This year, we pushed 3,679 
commits to the repository, sitting at over 25,600 now. Looking at the graph, this
keeps us pretty consistent with 2020's throughput.

<p align="center">
 <img align="center" width="75%" src="/assets/blog/2021-review/commits.png"/>
</p>

With the project's trajectory displayed in numbers, let's examine the top 
features that landed in Trino this year.

## Features

Here's a high-level list of the most exciting features that made their way into
Trino in 2021. For details and to keep up you can check out the [release notes]({{site.url}}/docs/current/release.html).

### SQL language improvements

SQL language support is crucial for the increasing complexities of queries and 
usage of Trino. In 2021 we added numerous new language features and 
improvements:

* [`MATCH_RECOGNIZE`]({{site.url}}/blog/2021/05/19/row_pattern_matching.html)
a feature that allows for complex analysis across multiple rows. To learn more 
about this feature watch [the Community Broadcast show](/episodes/23.html).
* [`WINDOW`](https://trino.io/docs/current/sql/select.html#window-clause) clause.
* [`RANGE` and `ROWS`]({{site.url}}/blog/2021/03/10/introducing-new-window-features.html#new%20features)
keyword for usage within a window function.
* Time travel support and syntax, like `FOR VERSION AS OF` and `FOR TIMESTAMP AS OF`.
* [`UPDATE`](https://trino.io/docs/current/sql/update.html) is supported.
* Subquery expressions that return multiple columns. Example: `SELECT x = (VALUES (1, 'a'))`.
* Add support for `ALTER MATERIALIZED VIEW` ... `RENAME TO` ...
* [from_geojson_geometry/to_geojson_geometry](https://trino.io/docs/current/functions/geospatial.html#from_geojson_geometry) functions.
* [contains](https://trino.io/docs/current/functions/ipaddress.html#ip-address-contains) 
function for checking if a CIDR contains an IP address.
* [`listagg`]({{site.url}}/docs/current/functions/aggregate.html#listagg)
function returns concatenated values seperated by a specified separator.
* [soundex](https://trino.io/docs/current/functions/string.html#soundex) function
that checks phonetic similarity of two strings.
* [format_number](https://trino.io/docs/current/functions/conversion.html#format_number) function.
* [`SET TIME ZONE`]({{site.url}}/docs/current/sql/set-time-zone.html) to set the
 current time zone for the session.
* Arbitrary queries in [`SHOW STATS`]({{site.url}}/docs/current/sql/show-stats.html).
* `CURRENT_CATALOG` and `CURRENT_SCHEMA` session functions. 
* `TRUNCATE TABLE` which allows for a more efficient delete.
* `DENY` statement, which enables you to remove a user or groups access via SQL.
* `IN <catalog>` clause to `CREATE ROLE`, `DROP ROLE`, `GRANT ROLE`, 
`REVOKE ROLE`, and `SET ROLE` to specify the target catalog of the statement 
instead of using the current session catalog.

### Query processing improvements

* Added support for automatic query retries (this feature is very experimental
with some limitations for now).
* Transparent query retries.
* Updated the behavior of `ROW` to `JSON` cast to produce `JSON` objects instead
of `JSON` arrays. 
* Column and table lineage tracking in `QueryCompletedEvent`.

## Performance improvements

Improved performance for the following operations:

* Querying Parquet data for files containing column indexes.
* Reading dictionary-encoded Parquet files.
* Queries using [`rank()`]({{site.url}}/docs/current/functions/window.html#rank) window function.
* Queries using [`sum()`]({{site.url}}/docs/current/functions/aggregate.html#sum)
and [`avg()`]({{site.url}}/docs/current/functions/aggregate.html#avg) for 
decimal types.
* Queries using `GROUP BY` with single grouping column.
* Aggregation on decimal values.
* Evaluation of the `WHERE` and `SELECT` clause.
* Computing the product of decimal values with precision larger than 19.
* Queries that process row or array data.
* Queries that contain a `DISTINCT` clause.
* Reduced memory usage and improved performance of joins.
* `ORDER BY LIMIT` performance was improved when data was pre-sorted.
* Node-local Dynamic Filtering

## Security

Added the following improvements and features relevant for authentication, 
authorization and integration with other security systems:

* Automatic configuration of TLS for 
[secure internal communication]({{site.url}}/docs/current/security/internal-communication.html).
* Handling of Server Name Indication (SNI) for multiple TLS certificates.
This removes the need to provision per-worker TLS certificates.
* Access control for materialized views.
* OAuth2/OIDC [opaque access tokens](https://trino.io/docs/current/security/oauth2.html).
* Configuring HTTP proxy for OAuth2 authentication.
* Configuring [multiple password authentication plugins](https://trino.io/docs/current/security/authentication-types.html#multiple-password-authenticators).
* Hiding inaccessible columns from `SELECT *` statement.

## Data Sources

### BigQuery connector

* Added `CREATE TABLE` and `DROP TABLE` support.
* Added support for case insensitive name matching for BigQuery views.
* Support reading `bignumeric` type whose precision is less than or equal to 
38.
* Added support for `CREATE SCHEMA` and `DROP SCHEMA` statements.
* Improved support for BigQuery datetime and timestamp types.

### Cassandra connector

* Mapped Cassandra `uuid` type to Trino `uuid`.
* Added support for Cassandra `tuple` type.
* Changed minimum number of speculative executions from two to one.
* Support for reading user-defined types.

### Clickhouse connector

* Added [ClickHouse connector]({{site.url}}/docs/current/connector/clickhouse.html).
* Improved performance of aggregation queries by computing aggregations within 
ClickHouse. Currently, the following aggregate functions are eligible for
pushdown: `count`, `min`, `max`, `sum` and `avg`.
* Added support for dropping columns.
* Map ClickHouse `UUID` columns as `UUID` type in Trino instead of `VARCHAR`.

### HDFS, S3, Azure and cloud object storage systems

A core use case of Trino uses the Hive and Iceberg connectors to connect to
a data lake. These connectors differ from most as Trino is the sole query engine
as opposed to the client calling another system. Here are some changes that
for these connectors:

* Enabled Glue statistics to support better query planning when using AWS.
* `UPDATE` support for ACID tables
* A lot of Hive view improvements.
* Parquet column indexes.
* `target_max_file_size` configuration to control the file size of data written
by Trino.
* Streaming uploads to S3 by default to improve performance and reduce disk usage.
* Improved performance for tables with small files and partitioned tables.
* Transparent redirection from a Hive catalog to Iceberg catalog if the table is
an Iceberg table.
* Updated to Iceberg 0.11.0 behavior for transforms of dates and timestamps
before 1970.
* Added procedure `system.flush_metadata_cache()` to flush metadata caches.
* Avoid generating splits for empty files.
* Sped up Iceberg query performance when dynamic filtering can be leveraged.
* Increased Iceberg performance when reading timestamps from Parquet files.
* Improved Iceberg performance for queries on nested data through dereference
pushdown.
* Added support for `INSERT OVERWRITE` operations on S3-backed tables.
* Made the Iceberg `uuid` type available.
* Trino views made available in Iceberg.


### Elasticsearch connector

* Added support for reading fields as `json` values.
* Fixed failure when documents contain fields of unsupported types.
* Added support for `scaled_float` type.
* Added support for assuming an IAM role.
* Added retry requests with backoff when Elasticsearch is overloaded.
* Better support for Elastic Cloud.

### MongoDB connector

* Added [`timestamp_objectid()`]({{site.url}}/docs/current/connector/mongodb.html#timestamp_objectid)
function.
* Enabled `mongodb.socket-keep-alive` config property by default.
* Add support for `json` type.
* Support reading MongoDB `DBRef` type.
* Allow skipping creation of an index for the `_schema` collection, if it 
already exists.
* Added support to redact the value of `mongodb.credentials` in the server log.
* Added support for dropping columns.

### MySQL connector

* Added support for reading and writing `timestamp` values with precision higher
than three.
* Added support for predicate pushdown on `timestamp` columns.
* Exclude an internal `sys` schema from schema listings.

### Pinot connector

* Updated Pinot connector to be compatible with versions >= 0.8.0 and drop 
support for older versions.
* Added support for pushdown of filters on `varbinary` columns to Pinot.
* Fixed incorrect results for queries that contain aggregations and `IN` and 
`NOT IN` filters over varchar columns.
* Fixed failure for queries with filters on `real` or `double` columns having 
`+Infinity` or `-Infinity` values.
* Implemented aggregation pushdown.
* Allowed HTTPS URLs in `pinot.controller-urls`. 

### Phoenix connector

* Phoenix 5 support was added.
* Reduced memory usage for some queries.
* Improved performance by adding ability to parallelize queries within Trino.

### Features added to various connectors

In addition to the above some more features were added that apply to connectors
that use common code. These features improve performance using:

* [Statistical aggregate function pushdown ](https://trino.io/docs/current/release/release-352.html#mysql-connector)
* [TopN pushdown and join pushdown](https://trino.io/docs/current/release/release-353.html)
* [Improved planning times by reducing number of connections opened](https://trino.io/docs/current/release/release-353.html)
* [Improved performance by improving metadata caching hit rate](https://trino.io/docs/current/release/release-356.html)
* [Rule based identifier mapping support](https://trino.io/docs/current/release/release-357.html)
* [DELETE, non-transactional inserts and write-batch-size ](https://trino.io/docs/current/release/release-360.html)
* [Metadata cache max size](https://trino.io/docs/current/release/release-361.html)
* [TRUNCATE TABLE](https://trino.io/docs/current/release/release-365.html)
* [Improved handling of Gregorian - Julian switch for date type](https://trino.io/docs/current/release/release-366.html)
* Ensured correctness when pushing down predicates and topN to remote system 
that is case-insensitive or sorts differently from Trino.

## Runtime improvements

There are a lot of performance improvements to list from the [release notes]({{site.url}}/docs/current/release.html).
Here are a few examples:

* Improved coordinator CPU utilization.
* Improved query performance by reducing CPU overhead of repartitioning data 
across worker nodes.
* Reduced graceful shutdown time for worker nodes.

## Everything else

* [HTTP Event listener](https://trino.io/docs/current/admin/event-listeners-http.html)
* Added support for ARM64 in the [Trino Docker image](https://hub.docker.com/r/trinodb/trino).
* Added `clear` command to the Trino CLI to clear the screen.
* Improved tab completion for the Trino CLI.
* Custom connector metrics.
* Fixed many, many, many bugs!

## Trino Summit

In 2021 we also enjoyed a successful inaugural Trino Summit, hosted by 
Starburst, with well over 500 attendees. There were wonderful talks
given at this event from companies like Doordash, EA, LinkedIn, Netflix, 
Robinhood, Stream Native, and Tabular. If you missed this event, we have the 
[recordings and slides available](https://www.starburst.io/resources/trino-summit/).

As a teaser, the event started with Commander Bun Bun playing guitar to AC/DC's,
"Back In Black".

<iframe src="https://www.youtube.com/embed/c_qUp0SGeKE"  
width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" 
scrolling="no" style="border:1px solid #CCC; border-width:1px; 
margin-bottom:5px; max-width: 100%;" allowfullscreen> 
</iframe>

## Renaming from PrestoSQL to Trino

As mentioned above, we renamed the project this year. What followed, was an 
outpouring of support and shock from the larger tech community. Community 
members immediately got to work. The project had to change the namespace 
practically overnight from the `io.prestosql` namespace to `io.trino` and a 
[migration blog post]({{site.url}}/blog/2021/01/04/migrating-from-prestosql-to-trino.html)
was published. Due to the hasty nature of the Linux Foundation to enforce the
Presto trademark, users had to adapt quickly. 

<p align="center">
 <a href="https://twitter.com/trinodb/status/1343330429684703232?s=20" target="_blank">
   <img align="center" width="100%" src="/assets/blog/2021-review/tweets.png"/>
 </a>
</p>

This [confused many in the community](https://stackoverflow.com/questions/67414714),
especially once the ownership of old PrestoSQL accounts were taken down by the
Linux Foundation. The <https://prestosql.io> site had broken documentation links,
JDBC urls had to change from `jdbc:presto` to `jdbc:trino`, header protocol
names had to be changed from prefix `X-Presto-` to `X-Trino-`, and various other
user impacting changes had to be made in the matter of weeks. Even the legacy 
Docker images were removed from the [prestosql/presto Docker repository](https://hub.docker.com/r/prestosql/presto),
causing disruptions for many users who immediately had to upgrade to the 
[trinodb/trino Docker repository](https://hub.docker.com/r/trinodb/trino).

We reached out to multiple projects to update compatibility to
Trino.

* [DBeaver](https://github.com/dbeaver/dbeaver/pull/10925)
* [QueryBook](https://github.com/pinterest/querybook/issues/509)
* [Homebrew](https://github.com/Homebrew/homebrew-core/pull/83185)
* [dbt](https://github.com/dbt-labs/dbt-presto/issues/39)
* [sqlalchemy](https://github.com/dungdm93/sqlalchemy-trino/issues/20)
* [sqlpad](https://github.com/sqlpad/sqlpad/pull/974)
* [Apache Superset](https://github.com/apache/superset/pull/13105)
* [Redash](https://github.com/getredash/redash/pull/5411)
* [Awesome Java](https://github.com/akullpp/awesome-java/pull/917)
* [Awesome For Beginners](https://github.com/MunGell/awesome-for-beginners/pull/933)
* [Airflow](https://github.com/apache/airflow/pull/15187)
* [trino-gateway](https://github.com/lyft/presto-gateway/issues/134)
* [Metabase](https://github.com/metabase/metabase/issues/17532)
* and so much more...

Despite the breaking changes, once the immediate hurdles fell behind, not only 
was the community excited and supportive about the brand change, but
particularly they were all loving the new mascot. Our adorable bunny was soon 
after [named Commander Bun Bun by the community](/episodes/10.html).

<p align="center">
 <a href="https://twitter.com/jtannady/status/1346888143459545092" target="_blank">
   <img align="center" width="50%" src="/assets/blog/2021-review/cbb.png"/>
 </a>
</p>

## 2022 Roadmap: Project Tardigrade

One of the interesting developments that came out of Trino Summit was a feature
Trino co-creator, Martin, talked about in [the State of Trino presentation](https://www.starburst.io/resources/trino-summit/?wchannelid=2ug6mgs5ao&wmediaid=o264qw85dj).
He proposed adding granular fault-tolerance and features to improve performance 
in the core engine. While Trino has been proven to run batch analytics workloads
at scale, many have avoided long-running batch jobs in fear of a query failure. 
The fault-tolerance feature introduces a first step for the Trino project to 
gain first-class support for long-running batch queries at massive scale.

The granular fault-tolerance is being thoughtfully crafted to maintain the 
speed advantage that Trino has over other query engines, while increasing the 
resiliency of queries. In other words, rather than when a query runs out of
resources or fails for any other reason, a subset of the query is
retried. To support this intermediate stage data is persisted to replicated RAM 
or SSD.

<a title="Schokraie E, Warnken U, Hotz-Wagenblatt A, Grohme MA, Hengherr S, et al. (2012), CC BY 2.5 &lt;https://creativecommons.org/licenses/by/2.5&gt;, via Wikimedia Commons" 
 href="https://commons.wikimedia.org/wiki/File:SEM_image_of_Milnesium_tardigradum_in_active_state_-_journal.pone.0045682.g001-2.png"><img width="512" 
 alt="SEM image of Milnesium tardigradum in active state - journal.pone.0045682.g001-2" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/SEM_image_of_Milnesium_tardigradum_in_active_state_-_journal.pone.0045682.g001-2.png/512px-SEM_image_of_Milnesium_tardigradum_in_active_state_-_journal.pone.0045682.g001-2.png">
</a>

The project to introduce granular fault-tolerance into Trino is called
Project Tardigrade. It is a focus for many contributors now, and we will 
introduce you to details in the coming months. The project is named after the 
microscopic Tardigrades that are the worlds most indestructible creatures, akin
to the resiliency we are adding to Trino's queries. We look forward to telling 
you more as features unfold.

Along with Project Tardigrade will be a series of changes focused around faster
performance in the query engine using columnar evaluation, adaptive planning,
and better scheduling for SIMD and GPU processors. We also will be working on
dynamically resolved functions, MERGE support, Time Travel queries in data lake
connectors, Java 17, improved caching mechanisms, and much much more!

## Conclusion

In summary, living this first year under the banner of Trino was nothing short
of a wild endeavor. Any engineer knows that naming things is hard, and renaming
things is all the more difficult. 

As we head into 2022, we can be certain of one thing. Trino will be reaching 
into newer areas of development and breaking norms just as it did as Presto in 
previous eras. The adoption of native fault-tolerance to a lightning fast query
engine will bring Trino to a new level of adoption. Keep your eyes peeled for 
more about Project Tardigrade.

Along with Project Tardigrade, we are looking forward to another year filled
with features, issues, and suggestions from our amazing and passionate community.
Thank you all for an incredible year. We can't wait to see what you all bring in
2022!