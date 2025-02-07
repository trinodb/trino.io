---
layout: post
title: Out with the old file system
author: Manfred Moser, David Phillips, Mateusz Gajewski
excerpt_separator: <!--more-->
image: /assets/blog/hadoop-trashcan.png
---

What a long journey it has been! From the start Trino supported querying Hive
data and used libraries from the Hive and Hadoop ecosystem. With the release of
[Trino 470]({{site.baseurl}}/docs/current/release/release-470.html) we mark
another milestone to more features and better performance for data lake and
lakehouse querying with Trino. We deprecated the legacy file system support, and
will permanently remove them in an upcoming release.

<!--more-->

## Background

Trino always had a focus on performance and security. As a result we implemented
custom readers for file formats like Apache ORC and Apache Parquet many years
ago. We also have improved libraries for compression and decompression of files
from object storage and and implemented our own support for other table formats
with the Apache Iceberg, Delta Lake and Apache Hudi connectors. 

For the underlying object storage solutions and file systems, we originally
extended the libraries around the Hive system and added implementations for
Amazon S3, Azure Storage, Google Cloud Storage and others. Over time the
mismatch of the HDFS libraries and the cloud-centric usage with modern file
systems became more and more of a maintenance headache. It also represented an
unnecessary complexity overhead, resulted in performance problems, and forced us
to carry the Hadoop dependencies with all their baggage of old Java code and
security issues. 

In the end David Philips, as our file system lead, decided in 2022 that it was
time to write our own file system support as needed for Trino. By summer of 2023
and with Trino 419 a [first support for
S3](https://github.com/trinodb/trino/pull/17498) became available for the
Iceberg and Delta Lake connectors. Over a year later in September 2024 and with
[Trino 458]({{site.baseurl}}/docs/current/release/release-458.html), we declared
the old file system support on top of the Hadoop libraries legacy and advised
users to migrate.

Since then you are required to declare what file system you want to enable in
each catalog with `fs.native-azure.enabled=true`,`fs.native-gcs.enabled=true` or
`fs.native-s3.enabled=true`. If you are truly using HDFS, or if you insist on
using the old legacy support you can also use `fs.hadoop.enabled=true`.

## Trino 470

With the recent [Trino 470
release]({{site.baseurl}}/docs/current/release/release-470.html) from February
2025, we took the next step. All catalog configuration properties for using the
old, legacy support for accessing Azure Storage, Google Cloud Storage, S3, and
S3-compatible file systems are now **deprecated**.

These properties include all names starting with `hive.azure`, `hive.cos`,
`hive.gcs`, and `hive.s3`. The result of this deprecation is that Trino emits
warnings during the startup for each of these properties in the server log.

We also removed all documentation for the old properties, leaving only relevant
migration guides in place.

## Next steps

Within the next weeks or months we will completely remove all these properties
and the underlying code. We therefore renew our call out from numerous
contributor calls, Trino Community Broadcast episodes, and our Trino Fest and
Trino Summit events:

> Stop using the old legacy file systems today.

If you need help, have a look at the documentation for your connector, the file
system you use, and the migration guide for each file system:

* [Delta Lake connector]({{site.baseurl}}/docs/current/connector/hive.html)
* [Hive connector]({{site.baseurl}}/docs/current/connector/hive.html)
* [Hudi connector]({{site.baseurl}}/docs/current/connector/hive.html)
* [Iceberg connector]({{site.baseurl}}/docs/current/connector/hive.html)
* [Azure Storage file system support]({{site.baseurl}}/docs/current/object-storage/file-system-azure.html)
* [Google Cloud Storage file system support]({{site.baseurl}}/docs/current/object-storage/file-system-gcs.html)
* [S3 file system support]({{site.baseurl}}/docs/current/object-storage/file-system-s3.html)

The new systems are more stable and performant, and save you time and money.
Migrate today, and if you encounter any issues, or find that there are features
missing, ping us on [Slack]({{site.baseurl}}/slack./html) and chime in on the
[roadmap issue for the removal of the legacy file system
support](https://github.com/trinodb/trino/issues/24878).
