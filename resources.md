---
layout: page
menu_id: resources
title: Resources
---

<div markdown="1" class="leftcol widecol faq">

## Presto ODBC {#odbc}

<div markdown="1" class="item">

#### Prestogres

Project
: [GitHub](https://github.com/treasure-data/prestogres)

Maintained by
: [Furuhashi Sadayuki](https://github.com/frsyuki)

Description
: Prestogres is a gateway server that allows clients to use PostgreSQL
  protocol and thus the PostgreSQL ODBC driver to run queries on Presto.

</div>

<div markdown="1" class="item">

#### Starburst ODBC Driver

Project
: [Starburst Enterprise ODBC/JDBC Presto Drivers](https://www.starburstdata.com/our-offerings/#drivers-block)

Maintained by
: [Starburst, The Presto company](https://www.starburstdata.com/)

Description
: The Starburst Enterprise Client Drivers for Presto include
  enterprise grade ODBC and JDBC drivers enabling you to use your
  preferred Business Intelligence tools with Presto. The drivers fully
  implement the ODBC and JDBC specifications and are compatible with the
  [Enterprise Starburst Presto release](https://www.starburstdata.com/our-offerings/)
  which is available for download. There are ODBC drivers for Windows, Mac,
  and Linux platforms. Starburst additionally provides
  [enterprise Presto support and services](https://www.starburstdata.com/presto-enterprise/).

</div>

## Presto Libraries {#libraries}

The following client libraries can be used to run queries from several
programming languages:
[C](#library-c),
[Go](#library-go),
[Java](#library-java),
[Node.js](#library-node),
[Python](#library-python),
[R](#library-r),
[Ruby](#library-ruby).

### Language: C {#library-c}

<div markdown="1" class="item">

#### PrestoClient C

Project
: [GitHub](https://github.com/easydatawarehousing/prestoclient/tree/master/C)

Maintained by
: [Ivo Herweijer](https://github.com/easydatawarehousing)

: Description
  C client for Presto.

</div>

### Language: Go {#library-go}

<div markdown="1" class="item">

#### presto-go-client

Project
: [GitHub](https://github.com/prestodb/presto-go-client)

Maintained by
: [Presto Go Client Team](https://github.com/prestodb/presto-go-client)

Description
: Go client for Presto.

</div>

### Language: Java {#library-java}

<div markdown="1" class="item">

#### Presto JDBC Driver

Project
: [Presto](docs/current/installation/jdbc.html)

Maintained by
: [Presto Team](https://github.com/prestosql/presto)

Description
: JDBC driver for Presto.

Example
: ```java
  String sql = "SELECT name FROM example";
  String url = "jdbc:presto://localhost:8080/catalog/schema";
  try (Connection c = DriverManager.getConnection(url, "abc", null)) {
      try (Statement s = c.createStatement()) {
          try (ResultSet rs = s.executeQuery(sql)) {
              while (rs.next()) {
                  System.out.println(rs.getString("name"));
              }
          }
      }
  }
```

</div>

### Language: Node.js {#library-node}

<div markdown="1" class="item">

#### presto-client-node

Project
: [GitHub](https://github.com/tagomoris/presto-client-node)

Maintained by
: [Satoshi Tagomori](https://github.com/tagomoris)

Description
: Node.js client for Presto.

</div>

<div markdown="1" class="item">

#### lento

Project
: [GitHub](https://github.com/vweevers/lento)

Maintained by
: [Vincent Weevers](https://github.com/vweevers)

Description
: Streaming Node.js client for Presto.

</div>

### Language: Python {#library-python}

<div markdown="1" class="item">

#### presto-python-client

Project
: [GitHub](https://github.com/prestodb/presto-python-client)

Maintained by
: [Presto Python Client Team](https://github.com/prestodb/presto-python-client)

Description
: Python client for Presto.

</div>

<div markdown="1" class="item">

#### PyHive

Project
: [GitHub](https://github.com/dropbox/PyHive)

Maintained by
: [Dropbox](https://github.com/dropbox)

Description
: PyHive is a collection of Python DB-API and SQLAlchemy interfaces for Presto and Hive.

</div>

<div markdown="1" class="item">

#### PrestoClient Python

Project
: [GitHub](https://github.com/easydatawarehousing/prestoclient/tree/master/python)

Maintained by
: [Ivo Herweijer](https://github.com/easydatawarehousing)

Description
: Python client for Presto.

</div>

### Language: R {#library-r}

<div markdown="1" class="item">

#### RPresto

Project
: [GitHub](https://github.com/prestodb/RPresto)

Maintained by
: [RPresto Team](https://github.com/prestodb/RPresto)

Description
: DBI-based adapter for Presto for R.

</div>

### Language: Ruby {#library-ruby}

<div markdown="1" class="item">

#### presto-client-ruby

Project
: [GitHub](https://github.com/treasure-data/presto-client-ruby)

Maintained by
: [Furuhashi Sadayuki](https://github.com/frsyuki)

Description
: Ruby client for Presto.

</div>

## Presto GUIs {#guis}

<div markdown="1" class="item">

#### Airpal

Project
: [Airpal](https://airbnb.github.io/airpal/)

Maintained by
: [Airbnb](https://github.com/airbnb)

Description
: Airpal is a web-based, query execution tool which leverages Presto
  to make authoring queries and retrieving results simple for users.
  Airpal provides the ability to find tables, see metadata, browse
  sample rows, write and edit queries, then submit queries all in a
  web interface.

</div>

<div markdown="1" class="item">

#### Redash

Project
: [Redash](https://redash.io/)

Maintained by
: [Arik Fraimovich](https://github.com/getredash/)

Description
: Redash is a take on freeing the data within our company in a way
  that will better fit our culture and usage patterns. It has Presto
  support as well as other backends, and offers a query editor with
  syntax highlighting and completion, and creating visualizations and
  dashboards from query results.

</div>

<div markdown="1" class="item">

#### Quix

Project
: [Quix](https://wix.github.io/quix/)

Maintained by
: [Wix](https://github.com/wix/quix/)

Description
: Quix is a multi-user, easy-to-use notebook manager. 
By utilizing Presto it provides unified access to 
multiple data sources and effectively acts as a shared 
space for your company's BI insights and know-how.

</div>

<div markdown="1" class="item">

#### Shib

Project
: [GitHub](https://github.com/tagomoris/shib)

Maintained by
: [Tagomori Satoshi](https://github.com/tagomoris)

Description
: Shib is a web-client written in Node.js designed to query Presto and
  Hive. To run Shib install node.js, alter your config.js, and follow
  the instructions on the shib project page. Shib can also be used as
  an proxy server for query engines.

</div>

<div markdown="1" class="item">

#### Superset

Project
: [Apache Superset](https://superset.incubator.apache.org/)

Maintained by
: [Apache Superset](https://github.com/apache/incubator-superset)

Description
: Superset enables users to consume data in many different ways:
  writing SQL queries, creating new tables, creating a visualization
  (slice), adding that visualization to one or many dashboards and
  downloading a CSV. SQL Lab is a a part of Superset and provides rich
  SQL editor that enables users to both query and visualize data. You
  can explore and preview tables in Presto, effortlessly compose SQL
  queries to access data. From there, you can either export a CSV file
  or immediately visualize your data in the Superset "Explore" view.

</div>

<div markdown="1" class="item">

#### yanagishima

Project
: [GitHub](https://github.com/wyukawa/yanagishima)

Maintained by
:  [wyukawa](https://github.com/wyukawa),
   [okazou](https://github.com/okazou)

Description
: yanagishima is a web application for Presto. yanagishima provides
  the ability to execute query, show query, kill query, bookmark
  query, search table, share query/query result, format query,
  download as CSV/TSV file, insert chart, substitute query parameter,
  and so on.

</div>

## Presto Management Tools {#tools}

<div markdown="1" class="item">

#### Presto-Admin

Project
: [Presto-Admin](https://github.com/prestosql/presto-admin)

Maintained by
: [Starburst, The Presto company](https://www.starburstdata.com/)

Description
: Presto-Admin is a tool for installing and managing the Presto query
  engine on a cluster. It provides easy-to-use commands:

  * Install and uninstall Presto across your cluster
  * Configure your Presto cluster
  * Start and stop the Presto servers
  * Gather status and log information from your Presto cluster

  If you need any assistance with your Presto cluster management reach out
  to [Starburst](https://www.starburstdata.com) for their
  [Presto enterprise support](https://www.starburstdata.com/presto-enterprise/)
  offering and other Presto related services.

Examples
: ```
  presto-admin server start|stop|restart|status
  presto-admin server install path-to-presto-rpm
  presto-admin connector add connector-name
  ```

</div>

<div markdown="1" class="item">

#### Presto-Gateway

Project
: [Presto-Gateway](https://github.com/lyft/presto-gateway)

Maintained by
: [Lyft](https://www.lyft.com/)

Description
: Presto-Gateway is a gateway/proxy/load-balancer for multiple presto clusters.
Users can register/de-register presto clusters behind the gateway and connect to 
it using standard presto-clients.

</div>

## Enterprise Support for Presto {#support}

<div markdown="1" class="item">

#### Starburst Data

Website
: [Starburst, The Presto company](https://www.starburstdata.com/)

Scope
: Enterprise 24/7 Support, Installation, Configuration, Training,
  Custom Development, Tuning

Description
: At Starburst, our team is a major contributor to the open source
  Presto project. We consist of many of the **experts and committers**
  who have been contributing to and advancing the Presto product over
  the last few years. Starburst provides an [enterprise ready Presto
  distribution](https://www.starburstdata.com/our-offerings/) and
  [Presto support](https://www.starburstdata.com/presto-enterprise/).
  Starburst's distribution of Presto consists of additional tooling
  and configurations to make it work well in the enterprise. Further,
  it is rigorously tested at scale and patched as needed. And with our
  wide range of services, support, and training we will help you be
  successful in this new world of open source technologies in the
  enterprise.

  In addition to implementing Presto internals to make it the most
  reliable, robust, and performant open source distributed query
  engine, our team at Starburst is dedicated to continually improve
  and add the needed features for the enterprise. Our major enterprise
  focus areas are ease-of-use, security, robustness, wide range of
  integrations, and reliable support SLAs.

</div>
<div markdown="1" class="item">

#### Qubole

Website
: [Presto on Qubole](https://www.qubole.com/developers/presto-on-qubole/)

Scope
: Enterprise 24/7 Support, HotFixes, Multiple Presto Versions, Backporting of critical 
  open source fixes and enhancements, Configuration, Tuning

Description
: Qubole has been offering a managed Presto service since 2014.
  Qubole offers multiple Presto versions across multiple clouds
  (AWS, Azure and GCP) and maintains a regular upgrade process.
  Qubole offers 24/7 support through its support and engineering
  teams spread across the globe. Qubole hotfixes critical production
  issues or major issues addressed in open source community. Qubole
  also backports critical fixes and major enhancements from recent
  versions of Presto to older versions. Qubole helps its users configure
  their clusters, fine tune their workloads and get the best out of Presto.   

</div>

## Managed Presto Service {#managed}

<div markdown="1" class="item">

#### Qubole

Product
: [Managed Presto
  Service](https://www.qubole.com/developers/presto-on-qubole/)

Description
: Qubole has been offering a managed Presto service since 2014.
  Qubole has optimized Presto for the cloud. Qubole’s enhancements
  allow for cluster autoscaling based on workload and termination
  of idle clusters — ensuring high reliability while reducing compute
  costs. 

  Qubole offers multiple Presto versions across multiple clouds 
  (AWS, Azure and GCP) and maintains a regular upgrade process. 
  Qubole blends the latest features from the open source community 
  with Qubole’s proprietary solutions that boost performance, 
  lower cost, improve user experience, and provide smooth 
  administration of Presto clusters. 

</div>

<div markdown="1" class="item">

#### Amazon Athena

Website
: [Amazon Athena](https://aws.amazon.com/athena/)

Maintainer
: [Amazon Web Services](https://aws.amazon.com/)

Description
: Amazon Athena is an interactive query service based on Presto that
  makes it easy to analyze data in Amazon S3 using standard SQL.
  Athena is serverless, so there is no infrastructure to manage, and
  you pay only for the queries that you run.
  Amazon Athena uses Presto with full standard SQL support and works
  with a variety of standard data formats. Athena is out-of-the-box
  integrated with AWS Glue Data Catalog, allowing you to create a
  unified metadata repository across various services, crawl data
  sources to discover schemas and populate your Catalog with new and
  modified table and partition definitions, and maintain schema
  versioning.

</div>

## Presto Cloud {#cloud}

Presto is also readily available in [AWS](#aws) and [Azure](#azure)
cloud environments.

### AWS {#aws}

<div markdown="1" class="item">

#### Starburst Presto {#starburst-presto}

Website
: [Presto on AWS](https://www.starburstdata.com/presto-aws-cloud/)

Maintainer
: [Starburst, The Presto company](https://www.starburstdata.com/)

Description
: Starburst Presto on AWS combines the reliable, scalable, and
  cost-effective cloud computing services provided by Amazon Web
  Services (AWS) with the power of Presto, the fastest growing
  distributed SQL query engine within the industry.

  Through the use of Starburst’s CloudFormation template and Starburst
  Presto AMI, Starburst Presto on AWS enables you to run analytic SQL
  queries across a wide variety of data sources with elastic scaling
  and usage-based pricing. Read more how to use Presto on AWS on our
  [AWS Documentation site](https://docs.starburstdata.com/latest/aws.html).

</div>

<div markdown="1" class="item">


#### Presto on Qubole 


Website
: [Presto on Qubole on AWS](https://us.qubole.com/)


Maintainer
: [Qubole](https://www.qubole.com/developers/presto-on-qubole/)

Description
: Qubole offers a managed Presto service on AWS that is optimized
  for the cloud. Qubole supports cluster autoscaling based on
  workload and termination of idle clusters — ensuring high
  reliability while reducing compute costs. Qubole supports usage
  of spot nodes on AWS with built in failure resilience around spot
  termination notification handling and query retries. With Presto
  on Qubole, users can create heterogenous clusters with spot nodes
  from similar instance families that can further help reduce
  compute costs.

</div>

<div markdown="1" class="item">


#### Amazon EMR

Website
: [Amazon EMR](https://aws.amazon.com/emr/)

Maintainer
: [Amazon Web Services](https://aws.amazon.com/)

Description
: Amazon EMR provides a managed Hadoop framework that makes it easy,
  fast, and cost-effective to process vast amounts of data across
  dynamically scalable Amazon EC2 instances. With EMR, you can launch
  a large Presto cluster in minutes. You don't need to worry about
  node provisioning, cluster setup or tuning.

  Using Presto on EMR provides these benefits to customers:
  * Elasticity: With Amazon EMR, you can provision one, hundreds, or
    thousands of compute instances to process data at any scale. You
    can easily increase or decrease the number of instances manually
    or with Auto Scaling, and you only pay for what you use.
  * Simple and predictable pricing: You pay a per-second rate for
    every second used, with a one-minute minimum charge.

</div>

### Azure {#azure}

<div markdown="1" class="item">

#### Starburst Presto

Website
: [Presto on Azure](https://www.starburstdata.com/presto-azure/)

Maintainer
: [Starburst, The Presto company](https://www.starburstdata.com/)

Description
: Starburst Presto for HDInsight is a distributed SQL query engine that is
  integrated into Azure HDInsight Platform and available via the Azure
  Marketplace.

  Azure HDInsight is a fully-managed cloud service that makes it easy,
  fast, and cost-effective to process massive amounts of data. Presto and
  HDInsight were both designed for the separation of storage and compute
  which allows for flexible performance and cost. You pay only for what
  you use by creating clusters on demand scaling them up and down. Read
  more how to use Presto on Azure on our
  [Azure Documentation site](https://docs.starburstdata.com/latest/azure.html).

  Integrating Presto with HDInsight provides Azure users with two new
  capabilities:

  * A fast, scalable, interactive SQL interface to data in Azure Blob and
    Azure Data Lake Storage.
  * An easy way to integrate data with HDInsight by leveraging Presto’s
    vast portfolio of data connectors.

</div>

<div markdown="1" class="item">


#### Presto on Qubole 


Website
: [Presto on Qubole on Azure](https://azure.qubole.com/)


Maintainer
: [Qubole](https://www.qubole.com/developers/presto-on-qubole/)

Description
: Qubole offers a managed Presto service on Azure that is optimized
  for the cloud. Qubole supports cluster autoscaling based on 
  workload and termination of idle clusters — ensuring high 
  reliability while reducing compute costs. Qubole supports 
  both Gen1 and Gen2 of Azure Data Lake Storage (ADLS) as well as 
  Azure Blob Storage.
</div>


### GCP {#gcp}

<div markdown="1" class="item">


#### Presto on Qubole 


Website
: [Presto on Qubole on GCP](https://console.cloud.google.com/marketplace/details/qubole-public/qubole-data-service)


Maintainer
: [Qubole](https://www.qubole.com/developers/presto-on-qubole/)

Description
: Qubole offers a managed Presto service on GCP that is optimized
  for cloud and is integrated with 
  [GCP marketplace](https://console.cloud.google.com/marketplace/details/qubole-public/qubole-data-service). 
  Qubole supports cluster autoscaling based on workload and 
  termination of idle clusters — ensuring high reliability while
  reducing compute costs. Qubole supports use of preemptible VMs in 
  its autoscaling to reduce costs. Qubole has also added support for 
  faster detection of query failures in Presto caused by preemptible 
  VM interruption. 

</div>

</div>

<div markdown="1" class="rightcol">

### Presto Resources

* [ODBC](#odbc)
* [Libraries](#libraries)
  * [C](#library-c)
  * [Go](#library-go)
  * [Java](#library-java)
  * [Node.js](#library-node)
  * [Python](#library-python)
  * [R](#library-r)
  * [Ruby](#library-ruby)
* [GUIs](#guis)
* [Management Tools](#tools)
* [Enterprise Support](#support)
* [Managed Presto Service](#managed)
* [Cloud](#cloud)
  * [AWS](#aws)
  * [Azure](#azure)
  * [GCP](#gcp)

</div>
