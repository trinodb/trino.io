---
layout: post
title:  "Improved Hive Bucketing"
author: David Phillips
---

[Presto 312]({{site.url}}/docs/current/release/release-312.html)
adds support for the more flexible bucketing introduced in recent
versions of Hive. Specifically, it allows any number of files per bucket,
including zero. This allows inserting data into an existing partition without
having to rewrite the entire partition, and improves the performance of
writes by not requiring the creation of files for empty buckets.

# Hive bucketing overview

Hive bucketing is a simple form of hash partitioning. A table is bucketed
on one or more columns with a fixed number of hash buckets. For example,
a table definition in Presto syntax looks like this:

```sql
CREATE TABLE page_views (
  user_id bigint,
  page_url varchar,
  dt date
)
WITH (
  partitioned_by = ARRAY['dt'],
  bucketed_by = ARRAY['user_id'],
  bucket_count = 50
)
```

The bucketing happens within each partition of the table (or across the entire
table if it is not partitioned). In the above example, the table is partitioned
by date and is declared to have `50` buckets using the user ID column. This
means that the table will have `50` buckets for each date. The assigned bucket
for each row is determined by hashing the user ID value. This means that all
user IDs with the same value will go into the same bucket.

# Original Hive bucketing

Originally, Hive required exactly one file per bucket. The files were named
such that the bucket number was implicit based on the file's position within
the lexicographic ordering of the file names. For example, the following list
of files represent buckets `0` to `2`, respectively:

```
00000_0
00001_0
00002_0
```

```
file0
file3
file5
```

```
bucketA
bucketB
bucketD
```

The file names are meaningless aside from their ordering with respect to the
other file names.

# What's the problem?

The original Hive bucketing scheme has a couple of problems:

- Inserting data into the table by adding additional files is not possible.
  Instead, an insert operation requires rewriting all of the existing files,
  which can be quite expensive.

- If the data is sparse, some of the buckets might be empty, but because there
  must be a file for every bucket, the writer must create an empty file for
  each bucket. Some file formats, such as ORC, support zero-byte files as empty
  files. Other formats require writing a file with a valid header and footer.
  Creating these files adds latency to the write operation, and storing these
  tiny files is inefficient for file systems like HDFS which are designed for
  large files.

# Improved Hive bucketing

Newer versions of Hive support a bucketing scheme where the bucket number is
included in the file name. This is the same naming scheme that Hive has always
used, thus it is backwards compatible with existing data. The naming convention
has the bucket number as the start of the file name, and requires that the
number starts with a `0`.

The following list of files shows what data written by Hive might look like for
a table with a bucket count of `4`:

```
000000_0            # bucket 0
000000_0_copy_1     # bucket 0
000000_0_copy_2     # bucket 0
000001_0            # bucket 1
000001_0_copy_1     # bucket 1
000003_0            # bucket 3
```

We can see that there are multiple files for buckets `0` and `1`, one file for
bucket `3`, and no files for bucket `2`.

Unfortunately, Presto used a different naming convention that was valid
according to the lexicographical ordering requirement, but not the newer
explicit numbering convention. File names written by Presto used to look
like this:

```
20180102_030405_00641_x1y2z_bucket-00234
```

The `20180102_030405_00641_x1y2z` value at the start of the file name
is the Presto query ID for the query that wrote the data. This is followed
by `bucket-` plus the padded bucket number. Presto now writes file names
that match the new Hive naming convention, with the bucket number at the
the start and the query ID at the end:

```
000234_0_20180102_030405_00641_x1y2z
```

When reading bucketed tables, Presto supports both the new Hive convention
and the old Presto convention. Additionally, it still supports the original
Hive scheme when the files do not match either of the naming conventions,
keeping the requirement that there must be exactly one file per bucket.

# Skipping empty buckets for faster writes

Now that Hive and Presto no longer require files for empty buckets, Presto
does not need to create them. They are still created by default for
compatibility with earlier versions of Hive, Presto, and other tools, but
we expect to disable it in a future release, making writes faster by default.
Or you may choose to disable them now if that works for your environment.
This is controlled by the `hive.create-empty-bucket-files` configuration
property or the `create_empty_bucket_files` session property.
