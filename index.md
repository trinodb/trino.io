---
layout: default
title: Distributed SQL query engine for big data
---

<div class="homepage-gradient">
  <div class="jumbotron card card-image homepage-gradient homepage-bg">
    <div class="text-white row justify-content-end">
        <div class="col-md-7">
        <h1 class="card-title h1-responsive pt-3 mb-5 font-bold">
            <strong>
                Trino, a query engine that runs at ludicrous speed
            </strong>
        </h1>
        <p class="mr-5 mb-5 lead">Fast distributed SQL query engine
        for big data analytics that helps you explore your data universe.</p>
        <a class="btn btn-pink" href="./download.html">Download Trino</a>
        <a class="btn btn-orange" href="./slack.html">Join the community</a>
        </div>
    </div>
  </div>
</div>

<div class="trino-summit-banner">
  <div class="trino-summit-content">
    <img src="/assets/images/trino-summit-logo.png" class="trino-summit-logo" />
    <h3>November 10th, 2022</h3>
    <div class="card-deck spacer-30">
        <a class="btn trino-summit-button" href="https://www.starburst.io/info/trinosummit/" target="_blank">Register</a>
        <a class="btn btn-pink" href="{% post_url 2022-09-22-trino-summit-2022-teaser %}">Learn More</a>
    </div>
    <img src="/assets/images/trino-summit-banner-peek.png" class="trino-summit-peek">
  </div>
</div>

<div class="container">
  <div class="col-md-12 text-center spacer-60">
    <h2><strong>Join the fastest growing open-source analytics project</strong></h2>
  </div>
  <div style="display:flex;">
    {%- include users.html -%}
  </div>
  <div class="col-md-12 text-center spacer-30">
    <a class="btn btn-orange" href="/users.html">Find out more how they all use Trino!</a>
  </div>
  <hr class="spacer-30"/>
  <div class="col-md-12 text-center spacer-60">
    <h2><strong>Why Trino?</strong></h2>
  </div>
  <div class="row spacer-60">
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-speed.svg" alt="speed" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Speed</strong></h3>
        <p>Trino is a highly parallel and distributed query engine, that is built
        from the ground up for efficient, low latency analytics.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-scale.svg" alt="scale" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Scale</strong></h3>
        <p>The largest organizations in the world use Trino to query exabyte scale data lakes and massive data warehouses alike.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-simplicity.svg" alt="simple" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Simplicity</strong></h3>
        <p>Trino is an ANSI SQL compliant query engine, that works with BI tools such as R, Tableau, Power BI, Superset and many others.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-versatile.svg" alt="versatile" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Versatile</strong></h3>
        <p>Supports diverse use cases: ad-hoc analytics at interactive speeds, massive multi-hour batch queries, and high volume apps that perform sub-second queries.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-analytics.svg" alt="analysis" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>In-place analysis</strong></h3>
        <p>You can natively query data in Hadoop, S3, Cassandra, MySQL, and many others, without the need for complex, slow, and error-prone processes for copying the data.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-query.svg" alt="federation" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Query federation</strong></h3>
        <p>Access data from multiple systems within a single query. For example, join historic log data stored in an S3 object storage with customer data stored in a MySQL relational database.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-everywhere.svg" alt="everywhere" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Runs everywhere</strong></h3>
        <p>Trino is optimized for both on-premise and cloud environments such as Amazon, Azure, Google Cloud, and others.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-trusted.svg" alt="trusted" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Trusted</strong></h3>
        <p>Trino is used for critical business operations, including financial results for public markets, by some of the largest organizations in the world.</p>
      </div>
    </div>
    <div class="col-md-4 space-30 why-trino-block">
      <img src="/assets/images/icons/icon-open.svg" alt="open" class="why-trino-icon">
      <div>
        <h3 class="orange-text"><strong>Open</strong></h3>
        <p>The Trino project is community driven project under the non-profit
          <a href="{{site.url}}/foundation.html">Trino Software Foundation.</a></p>
      </div>
    </div>
  </div>
   <hr class="spacer-60"/>
   <div class="col-md-12 text-center spacer-60">
    <h2><strong>Use cases</strong></h2>
   </div>
   <div class="row spacer-60">
    <div class="col-md-6">
      <div class="outline-card">
        <h3>Interactive data analytics</h3>
        <p>
        A primary driver for Trino usage is interactive analytics. A user
        enters the query either directly using SQL or generated through a user
        interface, and is waiting for the results to come back as quickly as
        possible. Trino returns results to the user as soon as they are
        available. This offers data analysts and data scientists the ability to
        query large amounts of data, test hypotheses, run A/B testing, and build
        visualizations or dashboards.
        </p>
      </div>
    </div>
    <div class="col-md-6">
      <div class="outline-card">
        <h3>High performance analytics of object storage with SQL</h3>
        <p>
        The original use case for the development of Trino, is enabling
        SQL-based analytics of HDFS/Hive object storage systems. Trino is so
        performant that it enables analytics that used to be impossible or take
        hours. Migrating from Hive-based systems and querying cloud object
        storage systems is still a major use case for Trino.
        </p>
      </div>
    </div>
    <div class="col-md-6">
      <div class="outline-card">
        <h3>Centralized data access and analytics with query federation</h3>
        <p>
        The ability to query many disparate datasource in the same system with
        the same SQL greatly simplifies analytics that require understanding the
        large picture of all your data. Federated queries in Trino can access
        your object storage, your main relational databases, and your new
        streaming or NoSQL system, all in the same query. Trino completely
        changes what is possible in this central data consumption layer.
        </p>
      </div>
    </div>
    <div class="col-md-6">
      <div class="outline-card">
        <h3>Batch ETL processing across disparate systems</h3>
        <p>
          Large Extract, Transform, Load (ETL) processes running in batches are
          generally very resource intensive. Routinely run by engineers, they are
          low priority to return as long as they eventually finish. Trino is
          able to tremendously speed up ETL processes, allow them all to use
          standard SQL statement, and work with numerous data sources and targets
          all in the same system.
        </p>
      </div>
    </div>
   </div>
  <hr class="spacer-30"/>
   <div class="col-md-12 text-center spacer-60">
    <h2><strong>Resources</strong></h2>
   </div>
   <div class="card-deck spacer-60">
    <div class="card mb-4">
      <div class="card-body text-center">
        <h3 class="card-header-title mb-3">Reading material</h3>
        <p>Get a digital copy of <a href="{{ site.url }}{% post_url 2020-04-11-the-definitive-guide %}">the definitive guide about the Trino
        distributed query engine</a>. Useful for beginners and existing users.</p>
        <p>For technical background, read our paper: <a href="paper.html">Presto: SQL on Everything</a></p>
      </div>
    </div>
    <div class="card mb-4">
      <div class="card-body text-center">
        <h3 class="card-header-title mb-3">Community chat</h3>
        <p>
          The community is very active and helpful on Slack,
          with users and developers from all around the world.
          If you need help using or running Trino, this is the place to ask.
        </p>
        <a class="btn btn-orange" href="/slack.html"><i class="fab fa-slack"></i>&nbsp;&nbsp;Join us on Slack</a>
      </div>
    </div>
    <div class="card mb-4">
      <div class="card-body text-center">
        <h3 class="card-header-title mb-3">Subscribe to our blog</h3>
        <p>Curious to learn new insights into the community behind this
        incredible query engine? Subscribe to our blog where the project
        maintainers, contributors, and users share updates, stories,
        knowledge, and lessons learned.
        </p>
        <a class="btn btn-orange" href="/blog/">Subscribe</a>
      </div>
     </div>
   </div>
</div>
