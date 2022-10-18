---
layout: post
title: "Trino Summit 2022 will be legendary"
author: "Brian Olsen, Dain Sundstrom"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/summit-logo.png
---

Commander Bun Bun is back and this year we have an exciting lineup of speakers.
Topics range from architectures like data mesh and data lakehouse, to running
Trino at scale with fault-tolerant execution, and query federation. This 
conference is free and takes place on November 10th. The summit is a hybrid
event for in-person and virtual attendance. Find out more details below!

<!--more-->

## Register for the summit

This year's Trino Summit will be hosted at the Commonwealth Club in San 
Francisco, CA. In-person registration is limited to 250 seats so make sure you
register quickly before spots run out!

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="https://www.starburst.io/info/trinosummit/">
        Register now
    </a>
</div>
<div class="spacer-30"></div>

### Trino Summit 2022 teaser

Get ready to federate them all this year! Many times when folks think of Trino,
their first instinct is to consider the data lake use case where it replaces
Hive or other data lakehouse query engines. However, this summit will also drill
into the lesser discussed query federation use case. Federate 'em all!

<iframe src="https://www.youtube.com/embed/o2MJvRKG14M" width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px;
margin-bottom:5px; max-width: 100%;" allowfullscreen="">
</iframe>


## Announcing the first sessions and speakers

We have a full roster planned but here is a glance at a few full confirmed
sessions. Stay tuned for future blog posts as we announce more session as they
are confirmed!

### State of Trino keynote

Hear the latest on the state of the open source Trino project. Trino
is the award-winning MPP SQL query engine. In this session, Trino creators
discuss the latest features that have landed in the last year, the roadmap for
the year ahead, and community growth highlights.

* *Martin Traverso, Co-Creator of Trino and CTO, Starburst*
        
* *Dain Sundstrom, Co-Creator of Trino and CTO, Starburst*
        
* *David Phillips, Co-Creator of Trino and CTO, Starburst*

### Trino for large scale ETL at Lyft

At Lyft, we are processing petabytes of data daily through Trino
for various use cases. A single query can execute as long as 4 hours with
terabytes of memory reserved. There are quite many challenges to operate Trino
ETL at such a scale: how to make all queries as performant as possible with low
failures rates; how should we define clusters, routing groups and resource
groups for changing volume across a day; how to keep commitment to user SLOs
during unexpected spikes, etc.
              
We'll share what we've done with our config tunings, large query/user
identifications, autoscaling and fault tolerant features to execute Trino at
such a scale. We'll also share our upcoming challenges and plans to move steps
further with Trino adoption across the company.

* *Charles Song, Senior Software Engineer at Lyft*
    
### Rewriting history: Migrating petabytes of data to Apache Iceberg using Trino

Dataset interoperability between data platform components continues to
be a difficult hurdle to overcome. This short coming often results in siloed
data and frustrated users. Although open table formats like Apache Iceberg aim
to break down these silos by providing a consistent and scalable table
abstraction, migrating your pre-existing data archive to a new format can still
be daunting. This talk will outline challenges we faced when rewriting petabytes
of Shopify’s data into Iceberg table format using the Trino engine. A rapidly
evolving landscape, I will highlight recent contributions to Trino’s Iceberg
integration that made our work possible while also illustrating how we designed
our system to scale. Topics will include: what to consider when designing your
migration strategy, how we optimized Trino’s write performance and how to
recover from corrupt table states. Finally, I will compare the query performance
of old and migrated datasets using Shopify’s datasets as benchmarks.

* *Marc Laforet, Senior Data Engineer at Shopify*

### Federating them all on Starburst Galaxy!

You've federated them all on Trino, but to beat the elite four at
Indigo Plateau, every data trainer needs help. In this talk, I will cover how
Starburst Galaxy is the fastest path to query federation and cover a demo that
trainers can follow later. We'll also cover cool features like schema discovery
and fault-tolerance execution. The queries we'll run will be with Pokémon data
so that you don't have to witness yet another taxi cab or iris data set.

* Monica Miller, Developer Advocate at Starburst* 
        
### Using Trino with Apache Airflow for (almost) all your data problems

Trino is incredibly effective at enabling users to extract insights
quickly and effectively from large amount of data located in dispersed and
heterogeneous federated data systems. However, some business data problems are
more complex than interactive analytics use cases, and are best broken down into
a sequence of interdependent steps, a.k.a. a workflow. For these use cases,
dedicated software is often required in order to schedule and manage these
processes with a principled approach. In this session, we will look at how we
can leverage Apache Airflow to orchestrate Trino queries into complex workflows
that solve practical batch processing problems, all the while avoiding the use
of repetitive, redundant data movement.

* *Philippe Gagnon, Solutions Architect at Astronomer* 

## Conclusion

Stay tuned for new developments in upcoming blog posts, don't forget to
[register](https://www.starburst.io/info/trinosummit/), and always, federate them
all!
