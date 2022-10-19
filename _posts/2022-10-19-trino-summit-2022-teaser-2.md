---
layout: post
title: "Trino Summit 2022: Federating humans and data"
author: "Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/summit-logo.png
---

Trino has long been the de facto standard to querying large data sets over your
cloud or on-prem storage, also known as data lakes. This Trino Summit's theme 
instead will showcase Trino's other claim to fame: query federation. Trino is a
query engine providing an access point that exposes ANSI SQL across 
[multiple data sources]({{site.url}}/docs/current/connector.html).

I urge you to join us either in-person or virtually if you are a fan of Trino,
big data, open source, data engineering, Java, or all the above! This conference
is free and takes place in San Francisco, California on November 10th.

<!--more-->

## Register for the summit

I can't help but bring up the analogy of how Trino federates heterogeneous data
while this Trino Summit will federate many of us in the community form all
corners of the world. It really brings an appreciation to the international
reach of Trino and makes me look forward to more in-person events!

Trino Summit will be held at the Commonwealth Club in San Francisco, California.
Make sure you register quickly for in-person registration, as it is limited to
250 seats. Virtual registration is also picking up quickly so register today!

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="https://www.starburst.io/info/trinosummit/">
        Register now
    </a>
</div>
<div class="spacer-30"></div>

### Get an autographed copy of Trino: The Definitive Guide, 2nd ed.

Want to meet the authors who literally wrote the book on Trino? Visit 
[Manfred Moser](https://twitter.com/simpligility),
[Matt Fuller](https://twitter.com/mfullertweets), and
[Martin Traverso](https://twitter.com/mtraverso) at the Trino booth during the
conference. Bring your hard copy of [__Trino: The Definitive Guide__](
{% post_url 2022-10-03-the-definitive-guide-2 %}) to get it signed by the authors!

<p align="center">
<img align="center" width="50%" height="100%" src="/assets/ttdg2-cover.png"/><br/>
</p>

Don't have a book? We'll be giving away autographed copied of the book
throughout the conference!

### Trino Summit 2022 teaser

Check out the teaser for this year's Trino Summit and get ready to ***Federate 'em
all***!

<iframe src="https://www.youtube.com/embed/o2MJvRKG14M" width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px;
margin-bottom:5px; max-width: 100%;" allowfullscreen="">
</iframe>

## Announcing the second round of sessions and speakers

As mentioned in the [previous summit teaser]({% post_url
2022-09-22-trino-summit-2022-teaser %}), we announced some of our exciting
lineup of speakers! The topics range from architectures like data mesh and data
lakehouse, to running Trino at scale with fault-tolerant execution, and of
course, query federation. 

We have a full roster planned, but check out the next round of fully confirmed
sessions. Stay tuned for one more blog post as we announce the final sessions in
our agenda as they are confirmed!

### SK Telecom's journey to Iceberg

SK Group is one South Korea's largest conglomerates in the nation covering
industries from manufacturing to telecommunications. SK Telecom uses an
on-premise data platform at petabyte scale using Trino as a query engine. We
chose Trino for its ability to connect to heterogeneous data sources and ensures
fast performance that plays a key role in our data platform.

As data along with user demands to analyze long-term data increased, the Trino
Hive connector faced several challenges. Queries with an input data size 
exceeding a terabyte put a great burden on the cluster. This caused many jobs to
fail which can be problematic as Trino's resource sharing architecture affects
multiple users when a heavy query occurs.

To address this situation, we optimized the data structure, tuned queries, and
used the resource group to isolate queries, but none of this fixed the problem.
We investigated Apache Iceberg and realized it could address some of these
scaling issues we were facing. In this talk, we will share our journey.

* *JaeChang Song, Data Engineer at SKTelecom and Trino/Iceberg Contributor*

* *Jennifer OH, Data Engineer at SKTelecom*

### Elevating Data Fabric to Data Mesh: solving data needs in hybrid data lakes

At Comcast, we have long had a complex hybrid data lakes that consists of
data lakes in on-prem and multiple cloud environments. Comcast uses Trino to
bridge the data in these environments using an architecture we call Data Fabric.
Data Fabric is an abstraction layer that uses an internally built connector that
connects to multiple instances of Trino. This enables us to query across all
of these environments from a single Trino instance.

In recent years, emerging architectures like Data Mesh have nicely complemented
the goals we have been building to for years. While we have effectively 
implemented some aspects of a Data Mesh, there are still core tenants that
cannot be addressed by Trino alone. This is the journey we are on at Comcast,
and we like to share our experience so far, challenges we overcame, and
the ones yet to be resolved. Data abstraction, availability, movement, and
governance are the various topics we will touch upon in this session.

* *Sajumon Joseph, Sr Principal Architect*

* *Pavan Madhineni, Sr. Manager; Product Development Engineering*

### Trino at Quora: Speed, Cost, Reliability Challenges and Tips

Trino has become an essential part of Quora’s tech stack and a major component
of our A/B testing framework that powers our decision-making on the product.
Trino has brought a lot of advantages to us. However, at Quora’s scale, we face
cost, speed, and reliability challenges when operating Trino.

In this session, we will talk about how we resolve the challenges. Some
approaches are: auto-scale Trino clusters, experiment with different cluster and
JVM configurations, and instance types, build checkers to detect slow workers
and inefficient queries, and set up extensive monitoring.

* *Yifan Pan, Software Engineer of Data Infrastructure Team at Quora; 
  Administrator/Primary Owner of Trino infrastructure at Quora*

### How we use Trino to analyze our Product-led Growth (PLG) user activation funnel

Being a PLG company, we must track and analyze every action our users perform
within the product to remove friction and maximize usage and satisfaction. To
understand how effectively and quickly users become educated and then active in
the product, we had to instrument the user journey from signup to the Aha moment
and beyond.

There are many tools on the market that can be used to analyze user behavior,
but none met our needs. In this session you will learn how we built a data
architecture to collect, model, and enrich user behavior events to optimize
Trino query performance that accelerated our ability to understand and improve
user conversion rates.

* *Roy Hasson, Head of Product at Upsolver*

## Conclusion

I hope you all are as excited as we are to finally federate the Trino community
face-to-face! This conference is shaping up to be educational, fun, and filled
with Trino experts and aficionados.

Stay tuned for new developments in upcoming blog posts, don't forget to
[register](https://www.starburst.io/info/trinosummit/), and always, ***Federate them
all***!
