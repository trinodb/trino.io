---
layout: post
title:  "Project Tardigrade delivers ETL at Trino speeds to early users"
author: Andrii Rosa, Brian Zhan, Lukasz Osipiuk, Zebing Lin
excerpt_separator: <!--more-->
---

After six months of challenging work on Project Tardigrade, we are ready to
launch. With the project we improved the user experience of running resource
intensive queries that are common in the Extract, Transform, Load (ETL) and
batch processing space. It required some significant and fascinating
engineering to get us to the current status. The latest Trino release includes
all the work from Project Tardigrade. Read on to learn how it all works, and
how to enable the fault-tolerant execution in Trino.

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
a node crash:

<img src="/assets/blog/tardigrade-launch/bucket-lifecycle.png"/>

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

### Requirements

* [eksctl](https://eksctl.io/)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)
* [helm](https://helm.sh/)

### Deployment

1. Install the [Trino Helm charts](https://github.com/trinodb/charts/blob/main/README.md).
2. Create a `values.yaml` file with:

   ```yaml
    image:
      tag: "<trino-version>"
    server:
      workers: <number-of-workers>
      config:
        memory:
          heapHeadroomPerNode: "30GB"
        query:
          maxMemory: "1TB"
          maxMemoryPerNode: "70GB"
      exchangeManager:
        baseDir: "s3://<spool-bucket-name>"
    coordinator:
      jvm:
        maxHeapSize: "100G"
        gcMethod:
          type: "UseG1GC"
          g1:
            heapRegionSize: "32M"
      resources:
        requests:
          memory: "120Gi"
          cpu: 31
        limits:
          memory: "120Gi"
          cpu: 31
    worker:
      jvm:
        maxHeapSize: "100G"
        gcMethod:
          type: "UseG1GC"
          g1:
            heapRegionSize: "32M"
      resources:
        requests:
          memory: "120Gi"
          cpu: 31
        limits:
          memory: "120Gi"
          cpu: 31
    additionalConfigProperties:
      - "retry-policy=TASK"
      - "query.hash-partition-count=50"
      - "fault-tolerant-execution-target-task-input-size=4GB"
      - "fault-tolerant-execution-target-task-split-count=64"
      - "fault-tolerant-execution-task-memory=5GB"
      - "task.writer-count=4"
      - "task.concurrency=8"
      - "scale-writers=true"
      - "exchange.compression-enabled=true"
      - "query.low-memory-killer.delay=0s"
    additionalExchangeManagerProperties:
      - "exchange.s3.region=<aws-region>"
      - "exchange.s3.aws-access-key=<access-key>"
      - "exchange.s3.aws-secret-key=<secret-key>"
    additionalCatalogs:
      hive: |-
        connector.name=hive-hadoop2
        hive.metastore=glue
        hive.metastore.glue.region=<aws-region>
        hive.metastore.glue.aws-access-key=<access-key>
        hive.metastore.glue.aws-secret-key=<secret-key>
        hive.s3.aws-access-key=<access-key>
        hive.s3.aws-secret-key=<secret-key>
        hive.metastore.glue.default-warehouse-dir=s3://<permanent-data-bucket>/
   ```
3. Update the placeholders in your `values.yaml`:
   * `<trino-version>` - latest release of Trino, e.g.: `378`
   * `<number-of-workers>` - desired number of workers, e.g.: `5`
   * `<spool-bucket-name>` - name of a bucket to be used for spooling.
     Multiple buckets can be specified using comma,
     e.g.: `s3://bucket-1,s3://bucket-2`
   * `<aws-region>` - aws region where the cluster is being deployed,
     e.g.: `us-east-1`
   * `<permanent-data-bucket>` - name of a bucket to be used for storing tables
     created by Trino
   * `<access-key>`, `<secret-key>` - AWS access credentials. The key must have
     full access to S3 buckets specified for spooling and for permanent storage
     as well as access to `Glue`
4. Create a Kubernetes cluster based on the recommended hardware configuration
   with `eksctl`:
   ```bash
    eksctl create cluster \
      --name <cluster-name> \
      --region <aws-region> \
      --node-type m5.8xlarge \
      --nodes <desired-number-of-workers + 1>
   ```
   For example:
   ```bash
    eksctl create cluster \
      --name tardigrade-cluster \
      --region us-east-1 \
      --node-type m5.8xlarge \
      --nodes 6
   ```
5. Deploy a Trino cluster:
   ```bash
   helm upgrade --install \
     --values values.yaml \
     tardigrade-kubernetes-cluster \
     trino/trino \
     --version 0.7.0

   kubectl rollout restart deployment \
     tardigrade-testing-batch-trino-coordinator \
     tardigrade-testing-batch-trino-worker
   ```
6. Forward the Trino endpoint to your local machine:
   ```bash
   kubectl port-forward \
   $(kubectl get pods --namespace default -l "app=trino,release=tardigrade-testing-batch,component=coordinator" -o jsonpath="{.items[0].metadata.name}") \
   8080:8080
   ```
7. Run some queries with the [Trino CLI](https://trino.io/docs/current/installation/cli.html)
   or any other client connected on `127.0.0.1:8080`.
8. Terminate the Kubernetes cluster:
   ```bash
   eksctl delete cluster \
     --name <cluster-name> \
     --region <aws-region>
   ```
   For example:
   ```bash
   eksctl delete cluster \
     --name tardigrade-cluster \
     --region us-east-1
   ```

## Potential issues

* Queries may start failing with
  `software.amazon.awssdk.services.s3.model.S3Exception: Please reduce your request rate`:
  * If your workload is I/O intensive it is possible that S3 starts throttling
    some requests. The request limits are enforced per bucket. It is
    recommended to create an another bucket for spooling to allow
    Trino to balance the load
    `exchange.base-directories=s3://<first-bucket>,s3://<second-bucket>`
* Queries may fail with `Task descriptor storage capacity has been exceeded`:
  * Trino has to maintain descriptors for each task in case it has to be
    restarted in an event of a failure. This information is currently stored
    in memory on the coordinator. We are planning to implement
    adaptive spilling for task descriptors, but at the moment there is a
    chance that queries may hit this limit. If this happens we recommend that
    you run less queries concurrently or use a coordinator with more memory.

## Closing notes

Project Tardigrade has been a great success for us already. We learned a lot
and significantly improved Trino. Now we are really ready to share this with
you all, and look forward to fix anything you find. We really want you to push
the limits, and let us know what you find.

Maybe you even want to write about your experience and results, or become a
contributor. 

Reach us on `#project-tardigrade` channel in our [Slack](https://trino.io/slack.html).
