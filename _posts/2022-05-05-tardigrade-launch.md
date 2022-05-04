---
layout: post
title:  "Project Tardigrade delivers ETL at Trino speeds to early users"
author: Andrii Rosa, Brian Olsen, Brian Zhan, Lukasz Osipiuk, Martin Traverso, Zebing Lin
excerpt_separator: <!--more-->
---

After six months of challenging work on Project Tardigrade, we are ready to
launch. With the project we improved the user experience of running resource
intensive queries that are common in the Extract, Transform, Load (ETL) and
batch processing space. It required some significant and fascinating
engineering to get us to the current status. The latest Trino release includes
all the work from Project Tardigrade. Read on to learn how it all works, and
how to enable the fault-tolerant execution in Trino.

<p align="center" width="100%">
    <img width="50%" src="/assets/blog/tardigrade-launch/tardigrade-logo.png">
</p>

<!--more-->

## What is Project Tardigrade?

What we love most about Trino is that you get fast query speeds, and you can
iterate fast with intuitive error messages, interactive experience, and query
federation.

One of the big problems that persisted a long time is that configuring, tuning,
and managing Trino for long-running ETL workloads is very difficult. Following
are just some of the problems you have to deal with:

* _Reliable landing times:_ Queries that run for hours can fail. Restarting
  them from scratch wastes resources and makes it hard for you to meet
  your completion time requirements.
* _Cost-efficient clusters:_ Trino queries that need terabytes of distributed
  memory require extremely large clusters due to the lack of iterative
  execution.
* _Concurrency:_ Multiple independent clients may submit their queries
  concurrently. Due to the lack of available resources at a certain moment some
  of these queries may need to be killed and restarted from zero after a
  while. This makes the landing time even more unpredictable.

[Structuring your workload](https://engineering.salesforce.com/how-to-etl-at-petabyte-scale-with-trino-5fe8ac134e36)
to avoid these problems can be done by a team of experts. But that is not
accessible to most Trino users.

The goal of Project Tardigrade is to provide an "out of the box" solution for the
problems mentioned above. We’ve designed a new
[fault-tolerant execution architecture](https://github.com/trinodb/trino/wiki/Fault-Tolerant-Execution)
that allows us to implement an advanced resource-aware scheduling with granular
retries.

Following are some of the benefits and results:

* When your long-running queries experience a failure, they don’t have to start
  from scratch.
* When queries require more memory than currently available in the cluster
  they are still able to succeed.
* When multiple queries are submitted concurrently they are able to share
  resources in a fair way, and make steady progress.

Trino does all the hard work of allocating, configuring, and maintaining query
processing behind the scenes. Instead of spending time tuning Trino clusters to
match your workload requirements, or reorganizing your workload to match your
Trino cluster capabilities, you can spend your time on analytics and delivering
business value. And most importantly, your heart won’t skip a beat when you
wake up in the morning wondering whether that query landed on time.

## What did we test so far?

Since there's no publicly available testing query set for ETL use cases, we
handcrafted more than a hundred ETL-like queries based on the
[TPC-H](https://github.com/trinodb/trino-verifier-queries/tree/main/src/main/resources/queries/tpch/etl)
and
[TPC-DS](https://github.com/trinodb/trino-verifier-queries/tree/main/src/main/resources/queries/tpcds/etl)
datasets.

To simulate real world settings, we deployed a cluster
[configured for fault-tolerant execution](https://trino.io/docs/current/admin/fault-tolerant-execution.html)
of 15 `m5.8xlarge` nodes and repeatedly executed thousands of queries over
datasets of different sizes (`10GB` / `1TB` / `10TB`). The queries were
executed sequentially as well as with concurrency factors of 5, 10, and 20.
Failure recovery capabilities were tested by crashing a random node in a
cluster every couple of minutes while streaming a live workload.

To validate new resource management capabilities we submitted all 22
[TPC-H](https://github.com/trinodb/trino-verifier-queries/tree/main/src/main/resources/queries/tpch/etl)
based queries simultaneously with fault-tolerant execution enabled and disabled.
With fault-tolerant execution disabled only two of them succeeded, while the 
remaining twenty queries failed with resource-related issues, such as
running out of memory. With fault tolerant execution enabled all of the
queries succeeded with no issues.

## How do I enable fault-tolerant execution?

Fault-tolerant execution can only be enabled for an entire cluster.

In general, we recommend splitting your long-running ETL queries and
short-running interactive workloads and use cases to run on different cluster.
This ensures that long running ETL queries do not impact interactive workloads
and cause a bad user experience. Also note that any short-running,
interactive queries on a fault-tolerant cluster may experience higher latencies
due to the checkpoint mechanism.

### 1. Add an S3 bucket for checkpointing

First you need to create an S3 bucket for spooling. We recommend configuring a
bucket lifecycle rule to automatically expire abandoned objects in the event of
a node crash. You can configure these rules using the 
[s3api](https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-lifecycle-configuration.html) 
which is included in the tutorial below.


```
{
    "Rules": [
        {
            "Expiration": {
                "Days": 1
            },
            "ID": "Expire",
            "Filter": {},
            "Status": "Enabled",
            "NoncurrentVersionExpiration": {
                "NoncurrentDays": 1
            },
            "AbortIncompleteMultipartUpload": {
                "DaysAfterInitiation": 1
            }
        }
    ]
}
```

### 2. Configure the Trino exchange manager

Second you need to configure exchange manager. Add a the file 
`exchange-manager.properties` in the `etc` folder of your Trino installation on
the coordinator and all workers with the following content:

```
exchange-manager.name=filesystem
exchange.base-directories=s3://<bucket-name>
exchange.s3.region=us-east-1
exchange.s3.aws-access-key=<access-key>
exchange.s3.aws-secret-key=<secret-key>
```

### 3. Enable task level retries

Lastly, you need to configure and enable task level retries by adding the
following properties to `config.properties`:

```
retry-policy=TASK
query.hash-partition-count=50
```

Note: more than 50 partitions is currently not supported by the filesystem
exchange implementation.

### 4. Optional recommended settings

It is also recommended to enable compression to reduce the amount of data spooled
on S3 (`exchange.compression-enabled=true`) as well as reduce the low memory
killer delay to allow the resource manager to unblock nodes running short on memory
faster (`query.low-memory-killer.delay=0s`). Additionally, we recommend enabling
automatic writer scaling to optimize output file size for tables created with
Trino (`scale-writers=true`).

To increase overall throughput and reduce resource-related task retries, we
recommend adjusting the concurrency settings based on the hardware
configuration you have chosen. 

Following are the settings for the hardware used in our testing (`32` vCPUs,
`128GB` memory and `10Gbit/s` network):

```
task.concurrency=8
task.writer-count=4
fault-tolerant-execution-target-task-input-size=4GB
fault-tolerant-execution-target-task-split-count=64
fault-tolerant-execution-task-memory=5GB
```

By default Trino is configured to wait up to five minutes for task to recover
before considering it lost and rescheduling. This timeout
can be increased or reduced as necessary by adjusting the
`query.remote-task.max-error-duration` configuration property. For example:
`query.remote-task.max-error-duration=1m`

## Deploying on AWS with Helm and Kubernetes

To test out Tardigrade features, you need at least a cluster with a dedicated
coordinator and two workers for a minimal level of parallelism and performance.
The quickest and easiest way to provide all of these specifications we mentioned
above is by using the
[Trino helm chart](https://artifacthub.io/packages/helm/trino/trino) with a
provided `values.yml` below and deploying a cluster to the AWS EKS cloud
service. If you are not familiar with deploying Trino on Kubernetes, we
recommend you take a look at the Trino Community Broadcast episodes covering
[local Trino on Kubernetes](https://trino.io/episodes/24.html) and
[deploying Trino on EKS](https://trino.io/episodes/31.html).

<iframe width="720" height="405" src="https://www.youtube.com/embed/4isawxYjDnE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://github.com/bitsondatadev/trino-getting-started/tree/main/kubernetes/tardigrade-eks">Try Project Tardigrade Yourself >></a>

## Closing notes

Project Tardigrade has been a great success for us already. We learned a lot
and significantly improved Trino. Now we are really ready to share this with
you all, and look forward to fix anything you find. We really want you to push
the limits, and let us know what you find. 

If running fast batch jobs on the fastest state-of-the-art query engine 
interests you, consider playing around with the tutorial above and giving us 
your feedback. You can reach us on the `#project-tardigrade` channel in our 
[Slack](https://trino.io/slack.html). Maybe you even want to write about your 
experience and results, or become a contributor. 

Thanks for reading and learning with us today. Happy Querying!
