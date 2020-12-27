---
layout: post
title:  "Faster S3 Reads"
author: David Phillips
---

Presto is known for working well with Amazon S3. We recently made an
improvement that greatly reduces network utilization and latency when
reading ORC or Parquet data.

# The problem

The improvement started with a question
from [Brenton Zillins](https://github.com/bzillins)
at [Stackpath](https://www.stackpath.com/)
on our [Slack]({{site.url}}/slack.html) workspace. He noticed
that the network traffic to Presto workers was many times larger than the
amount of input data reported by Presto for the query.

After a lively discussion on the Slack channel, we found the cause. Parquet
would perform a positioned read against the S3 file system to ask for an
exact byte range (start and end). However, the file system only implemented
the streaming API, so it would tell S3 about the starting location, but
not the end location. The file system would stop reading from the stream once
it reached the requested end location, but substantial additional data could
be read from S3 due to various buffers in different parts of the system.

The streaming API has an additional problem. Establishing a new connection
to S3 incurs latency, especially when using secure connections over TLS.
There is no way to abort a streaming request to S3, other than by closing
the connection, so the file system is forced to close connections after
every request, thus preventing the connection from being reused.

# The fix

We solved this by implementing positioned reads in the S3 file system.
Position reads, which are the only types used by ORC and Parquet, work by
asking S3 for the exact byte range required. These reads use the minimal
amount of network traffic and allow the connection to be reused.

Brenton tested out the change and reported success:

> This PR brought us from >1 GB/s object read rate to under 10 MB/s
> the same query. Thank you.

While this issue is obvious in retrospect, we are surprised that it took
so long to find it, given that S3 is one of the most popular storage systems.
This is a great example of how the community makes everything better.
Being observant and reporting an issue can have a huge win for everyone.

# How to get it

This improvement is in [Presto 302+]({{site.url}}/download.html),
so you will need to upgrade if you are using an earlier version.
