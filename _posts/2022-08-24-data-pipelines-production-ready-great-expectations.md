---
layout: post
title: "Make your Trino data pipelines production ready with Great Expectations"
author: "Brian Olsen, Brian Zhan"
excerpt_separator: <!--more-->
image: /assets/blog/data-pipelines-production-ready-great-expectations/trino-ge.png
---

An important aspect of a good data pipeline is ensuring data quality. 
You need to verify that the data is what you're expecting it to be at any given
state. [Great Expectations](https://greatexpectations.io/) is an open source
tool created in Python that allows you to write detailed tests called
[expectations](https://docs.greatexpectations.io/docs/terms/expectation/)
against your data. Users write these expectations to run validations against the
data as it enters your system. These expectations are expressed as methods in
Python, and stored in JSON and YAML files. One great advantage of expectations 
is the human readable documentation that results from these tests. As you roll
out different versions of the code, you get alerted to any unexpected changes
and have version-specific generated documentation for what changed. Let's learn
how to write expectations on tables in Trino!

<!--more-->

## The need for data quality

Managing data pipelines is not for the faint of heart. Nodes fail, you run
out of memory, bursty traffic causes abnormal behavior, and that’s just the tip
of the iceberg. Lots of Trino community members build sophisticated
data pipelines and data applications using Trino. Building data pipelines in
Trino became more common with the addition of a
[fault-tolerant execution mode]({% post_url 2022-05-05-tardigrade-launch %}) to
safeguard against failures when executing long-running and 
resource-intensive queries. 

Aside from all the infrastructure problems that concern data teams, another
category of problems that have been the silent problem for quite some time is
data quality. Faulty data comes in, which can either cause data pipelines to
fail, or it can possibly go unnoticed and cause inaccurate downstream reporting. 
Knowledge is scattered among domain experts, technical experts, and the code and
data itself. Maintenance becomes time-consuming and expensive. Documentation
gets out of date and unreliable. This is why using data quality checks using
libraries like Great Expectations is so important when writing ETL applications.

## Improve data quality in Trino with Great Expectations

As data quality moves to the forefront of the Trino community, the Great
Expectations and Trino communities have partnered to do some events together:
* [Trino meetup to discuss Great Expectations](https://www.youtube.com/watch?v=pcqAOq3O3Ts&list=PLFnr63che7wZij92ynF_egatbsrH7by7T&index=3)
* [Great Expectations meetup to discuss Trino](https://www.youtube.com/watch?v=4SieRmibb0U).
* [Superconductive](https://superconductive.ai/) joined this year’s mini Trino 
Summit event 
[Cinco de Trino](https://www.youtube.com/watch?v=kfJ63DNbAuI&list=PLFnr63che7wYDHjUsmp43THLmAlqPDHlM)
to showcase using 
[managed solutions for Great Expectations and Trino](https://www.youtube.com/watch?v=9HE6LawCHP8&list=PLFnr63che7wYDHjUsmp43THLmAlqPDHlM&index=7).

Today, we’re walking through a demo that showcases a scenario with Trino running
as the datalake query engine with multiple phases of data transformations on 
some Pokemon data sets. At each phase, we need to validate that the data is in
the correct schema, counts, and various other factors to validate. We use Trino
with Hive table with CSV for ingest and then move to Iceberg table for the
structure and consume tables. This is one of the great uses of Trino in that you
can operate using any of the popular table formats.

## Trino and Great Expectations demo

In this scenario, we’re going to ingest Pokemon pokedex data and Pokemon Go 
spawn location data which lands as raw CSV files in our data lake. We then use
Trino’s Hive catalog to read the data from the landing files, clean up, and 
optimize that raw data into more performant ORC files in the structure tables. 

![](/assets/blog/data-pipelines-production-ready-great-expectations/trino-ge-lakehouse.svg)

The last step is to join and transform the spawn data and pokedex data into a
single table that is cleaned and ready to be utilized by a data analyst, data
scientist, or other data consumer. Every area of the pipeline where the data is
transformed opens up a liability. The state can go from good to bad when
infrastructure fails or is updated as newer versions of the pipeline roll out.
This is where adding Great Expectations is crucial.

Now that you have a better understanding of the scenario, feel free to watch the
video, and try running it yourself!

<iframe src="https://www.youtube.com/embed/h6UYOilESfQ" width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; 
margin-bottom:5px; max-width: 100%;" allowfullscreen=""> 
</iframe>

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://github.com/bitsondatadev/trino-datalake/blob/main/tutorials/expecting-greatness-from-trino.md">Try this Trino demo yourself >></a>

## Conclusion

While data quality has always been a requirement, the standards for it increase
as the complexity of data lakes increase. It is a necessity that improves the
trust that data consumers have in the data. Dive into the 
[Great Expectations documentation](https://docs.greatexpectations.io/docs/guides/connecting_to_your_data/database/trino/ )
to learn more about the existing Trino support. If you run into any issues while
running the demo, reach out on [Slack]({{site.base}}/slack.html) and let us 
know!
