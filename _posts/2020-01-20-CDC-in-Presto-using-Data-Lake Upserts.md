---
layout: post
title:  "CDC in Presto using Data Lake Upserts"
author: Eran Levy, Director Of Marketing, Upsolver
excerpt_separator: <!--more-->
---

Change data capture (CDC) is a design pattern for database replication based on a set of changes instead of a full table copy. CDC enables organizations to act in near real-time based on data in their operational databases. . 

In a CDC log, each event is an insert, update or delete command to the database. Analyzing a CDC log in Presto is technically challenging since Presto is a SQL engine and not a database with DML API. Hence, we need to rely on the ETL layer to perform these operations on the underlying data.

In this article we will present the challenge of data lake CDC, and explain how we solved this challenge in Upsolver and how it works under the hood using a View in the Hive Metastore and continuous compaction of the table data. 

<!--more-->

## What is change data capture (CDC)?

Change data capture is a design pattern used to identify and track changes to databases. In a CDC architecture, we need to be able to identify changes to source data, and these would trigger an action in our target database based on the changed data.

By implementing CDC, we are able to treat relational databases as streaming applications, which enables faster response to real-world events. Examples could include a payment processor removing a fraudulent transaction from a customer's payment history, or user information being removed due to a GDPR request. 

In the context of Presto, we might want to implement CDC in order to reflect changes to operational databases in reports built on Presto, or to ensure the consistency and reliability of the underlying data. However, this can be a bit tricky to achieve in the context of a data lake, as we will proceed to show.

## The challenge: CDC on append-only object storage

While CDC is typically available as built-in functionality in databases, this is not the case in data lake architectures. In a data lake, we are storing data in unstructured object storage such as Amazon S3, Azure Blob Storage or HDFS. 

These storage systems are append-only and do not offer an easy way to pinpoint a specific historical record in order to upsert or delete data. Essentially we are dealing with log files sitting in a folder in the order they arrive in. without indexes or consistent schemas that can help us find the physical location of a particular event, or even whether it already exists in our database. Making the change itself is also challenging since for analytic querying you would periodically transform the raw event data into a columnar format such as Apache Parquet, which would then need to be rewritten. 

Due to these built-in limitations, capturing data changes requires us to perform full table scans. Essentially we would track each change to the database as an event log; when we identify a key-value pair that triggers our CDC, we would then need to scan the entire historical database to identify all previous instances that need to be updated. This is a resource-intensive, time-consuming operation - which is why at Upsolver we found a different system built on compaction.

## About Upsolver 

Upsolver is a data lake ETL product that simplifies data preparation for Apache Presto using a visual interface and SQL. Upsolver users can be DBAs, engineers, analysts or any other user who understands SQL, as opposed to Spark / Hadoop eco-systems that requires an expertise in Big Data and a dedicated team. Operations like conversion to Parquet and compaction of small files are performed automatically by Upsolver so they could be abstracted from the user.

## How do users configure Upserts in Upsolver?

Upsolver enables users to update and delete data in Presto as part of its data ingestion and storage optimization process. Generally this process would include:

1. Connecting to a data source such as Apache Kafka, Amazon Kinesis or HDFS - this is done by selecting the data source in the Upsolver UI

2. The user can then create transformations and enrichments using SQL or a visual interface

3. Upsolver continuously writes the data to S3 while automatically partitioning the data and [merging small files (compaction)](https://www.upsolver.com/blog/small-file-problem-hdfs-s3) in order to reduce disk reads

Upserts and [change-data-capture in Upsolver](https://www.upsolver.com/solutions/implement-change-data-capture-your-aws-data-lake) is handled in the 2nd stage through a simple SQL with a GROUP BY clause, that transforms the raw data source into an aggregated table. For example, the following transformation SQL creates a table with user\_id as the primary key and the number of historic user records as a column. 
```sql
SELECT user_id, COUNT(*) as user_events_count    
FROM user_events      
GROUP BY user_id      
```

This query runs on ANSI-SQL syntax with streaming extensions. Based on the query, Upsolver will set an Upsert Key which will be user\_id. As events stream in, Upsolver will update user\_events\_count according to the most up-to-date data, and store this result in a Hive metastore (or the Glue Data Catalog on AWS). The Presto table that reads this data from Hive will always contain the most recent result, even as the underlying data is updated.  

## How it Works

As we've mentioned, the challenge with CDC on object storage is the difficulty of updating and deleting records. Upsolver performs upserts and deletes on S3 as part of the compaction process, while leveraging the fact that data is indexed upon ingestion to provide very fast performance and thus enabling CDC in Presto / Athena in near real-time. 

For data lake CDC, the Upsolver solution is built on:

1. A view in Presto that always returns consistent results (1 row per key).

2. A compaction process that re-writes historical data according to updates and deletes, which enables the Presto view to return data at low-latency.

![CDC in Presto](https://www.upsolver.com/hubfs/website2018/Presto%20CDC%20(1).png)

As raw data is being ingested, it is stored in append-only partitions. The user can define an Upsert or Delete key based on the GROUP BY columns. During the compaction process, Upsolver would keep only the last events per each Upsert key and delete events marked for deletion based on Delete keys, and those would be stored in the compacted partitions.

Upsolver actually creates a table and a view in Presto. The user should only query the view in order to get consistent data by key.  The view joins between the compacted partition and the append-only partition to reflect changes in the historical data. Since Upsolver runs a periodic compaction process on the append-only partition, it is very small and contains only recent data. This helps us avoid full table scans and ensures very low latency when performing the join.

## Summary

In this article we discussed the challenge of handling CDC using Presto when data is stored on append-only object storage, and presented Upsolver's solution for updating and deleting data on S3 using data compaction and a view in Presto that returns consistent results in low-latency. By using this approach, we've made tables in Presto updateable in near real-time, without the resource and time overhead of performing full table scans.