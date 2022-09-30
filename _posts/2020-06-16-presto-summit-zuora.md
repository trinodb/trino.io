---
layout: post
title:  "Presto at Zuora"
author: Manfred Moser
excerpt_separator: <!--more-->
---

The Presto Summit is morphing into a series of virtual events, and we already
started with the [State of Presto webinar]({% post_url
2020-05-15-state-of-presto %}) recently. Next up is a talk about Presto with
lots of practical insights at [Zuora](https://zuora.com/) presented by Henning
Schmiedehausen:

**Using Presto as Query Layer in a Distributed Microservices Architecture**

Update:

We had a great event with lots of questions from the audience, taking us beyond
the planned time frame. Check out the recording to learn more:

{% youtube ICAPZksjP0k %}

<!--more-->

Presto has found its place as a SQL-based query engine for big data in the new
stack, but it does not have to be limited to big data and large scale analytics
applications.

In this presentation, Henning highlights how Presto helped Zuora to transform
its monolithic data architecture for an online transactional system into a
loosely coupled, services-based architecture. In doing so it helped to solve the
most pressing problem when splitting up data, providing direct to access
production data across many services and enabling complex data queries across
live data. Zuora Data Query was an instant success when it was launched.

In this webinar you discover:

* The technical architecture that embedded Presto in the Zuora service stack
* The pieces of Presto that could be used directly off the shelf
* How we productized it into a system that now serves huge numbers of small
  queries against live data

Our speaker, Henning Schmiedehausen, Chief Architect at Zuora, is a thought
leader in the open source Java community with more than 25 years of experience
contributing to successful open source projects. At Zuora he serves as the chief
architect and is responsible for the technical aspects of transforming the Zuora
system to a new, scalable, and flexible Microservices Architecture. Prior to
Zuora he worked at Facebook and Groupon as a principal engineer. Henning also
served as a board member at the Apache Software Foundation

Date: Tuesday, 30 June 2020

Time: 10am PDT (San Francisco), 1pm EDT (New York), 6pm BST (London), 5pm UTC

> ## [Register now!](https://bit.ly/2YfPNne)

We look forward to many Presto users joining us.


