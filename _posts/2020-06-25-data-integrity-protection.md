---
layout: post
title:  "Data Integrity Protection in Presto"
author: Piotr Findeisen, Starburst Data
excerpt_separator: <!--more-->
---

It all started on an Thursday afternoon in March, when [Karol Sobczak](https://github.com/sopel39)
was grilling Presto with heavy rounds of benchmarks, as we were ramping up to Starburst Enterprise
Presto 332-e release. Karol discovered what seemed to be a serious regression, and turned out to be even more
serious Cloud environment issue.

<!--more-->

# Presto Benchmarks

At the Presto project, we take serious care of stability and efficiency, so releases undergo
rigorous performance benchmarks. The intention is to safe guard against any performance regressions
or stability problems. Usually, the performance improvements are benchmarked separately when they
are being added to the codebase. At Starburst, those benchmarks are even more important, especially
for the Starburst Enterprise Presto LTS releases.

On a side note, we use [Benchto](https://github.com/prestosql/benchto/) for organizing
[Presto benchmark suites](https://github.com/prestosql/presto/tree/master/presto-benchto-benchmarks),
executing them and collecting the results. We use managed [Kubernetes](https://kubernetes.io/) in a public
cloud for provisioning Presto clusters, along with [Starburst Enterprise Presto Kubernetes](https://www.starburstdata.com/presto-on-kubernetes/).
We use [Jupyter](https://jupyter.org/) for producing result reports in HTML and PDF formats.

# Alleged Regression

It all started in March, when [Karol Sobczak](https://github.com/sopel39)
was grilling Presto with heavy rounds of benchmarks for the Starburst Enterprise Presto 332-e release.
On one Thursday afternoon he reported stability problems, with few benchmark runs failing with
exceptions similar to:

```
Query failed (#20200326_150852_00338_dj225): Unknown block encoding:
LONG_ARRAY� � �� � @@@���� �@  @ � �@@@ @@� @�@D�� @@��@ `� @@� @#�@ � 0�
... (9550 more bytes)
```

In Presto, a block encoding is a way of encoding a particular Block type (here, a ``LongArrayBlock``).
They are used when exchanging blocks of data between Presto nodes, or in spill to disk.
Blocks form a polymorphic class hierarchy, so every time a block is encoded, we need
to also store the encoding identifier. The encoding identifier (here, the ``LONG_ARRAY`` string)
is written as ``<string length>`` (4-byte, signed integer in little-endian) followed by
``<string bytes>`` containing the UTF-8 representation of the encoding id. Clearly, in the case above,
the receiver read the ``<encoding id length>`` as 9623 instead of 10! How could that be ever possible?

Presto 332 brought a lot of good changes and upgrade to Java 11 was one of them.
Therefore, Starburst Enterprise Presto 332-e was the first Starburst release using Java 11 by default.
For earlier releases, we ran benchmarks using AWS EC2 machines orchestrated with [Starburst's Presto
CloudFormation Template (CFT)](https://www.starburstdata.com/presto-aws-cloud/). This was also the first time we did
Presto release benchmarks running on Kubernetes clusters, with AWS EKS. We could suspect many different factors
as being the cause. We started to sift through the code, search team's "collective brain" and
the Internet for any ideas. One of the important sources was Vijay Pandurangan's writeup on [data
corruption bug discovered by Twitter in 2015](https://tech.vijayp.ca/linux-kernel-bug-delivers-corrupt-tcp-ip-data-to-mesos-kubernetes-docker-containers-4986f88f7a19). Of course, we also repeated benchmark runs. Seeing is believing.

# Production issues

On the next day, a customer reported similar problems with their Presto cluster. Of course, they
were not running a yet-to-be-released version that we were still benchmarking. They run into what seemed to
be a very serious regression in a Starburst Enterprise Presto 323-e release line. The customer was also using
the AWS cloud, but not the Kubernetes deployment. They were using [CFT-based deployment](https://www.starburstdata.com/presto-aws-cloud/)
-- the same stack we were using for all our release benchmarks so far -- and we had never run into issues like this before.
As the customer was using a fresh-off-press latest minor release, we decided (in spirit of global health care trend)
to "quarantine" that release and roll back the customer installation to the previous version.

However, the fact that a small bug fix release triggered data problems was unnerving. The fact that we
did not discover any of these problems before, was even more unnerving.

# More testing -- the data corruption

As we were running more and more, and even more test runs, we discovered new failure modes.
For example:
```
Query failed (#20200327_001931_00020_8di4r): Cannot cast DECIMAL(7, 2) '18734974449861284.67' to DECIMAL(12, 2)
```
Well, this message is not *wrong*. It's not possible to cast ``18734974449861284.67`` to ``DECIMAL(12, 2)``.
Except that it is *also* not possible to have a ``DECIMAL(7, 2)`` with such value. Something wrong happened to the
data. At that moment, we realized the problem was very serious, because data could become corrupted.
This corrupted data could lead to a failure (like above), but it could also lead to incorrect query results,
or incorrect data being persisted (in case of ``INSERT`` or ``CREATE TABLE AS`` queries). We created
a virtual War Room (that is, a Slack channel), got together all Presto experts and our experienced field team
to discuss potential causes, further diagnostics and mitigation strategies.

Since the problem was affecting data exchanges between Presto nodes, we listed the following strategies
to try to dissect the problem:

- determining which query (queries) is (are) causing failures,
- running with HTTP/2,
- reverting to running on Java 8,
- enabling exchange compression (as decompression is very sensitive to data corruption),
- trying to upgrade Jetty,
- determining whether failures correlate with JVM GC activity,
- inspecting the source code.

# Different configuration

We were able to quickly prototype and verify some of the ideas. Switching to HTTP/2 or
upgrading Jetty to the latest version did not help. Nor did downgrading to Jetty version
that had been using for a long time. We also verified that problem was reproducible with Java 8,
so we concluded Java 11 was not the cause of it.

# Checksums

We identified the problem occurs somewhere within exchanges, between one Presto worker
node serializing a ``Page`` object (basic unit of data processing in Presto) and another node
deserializing it.

While decimal cast failure didn't directly point at the data corruption problem (there could
be many other reasons for it), there was no other explanation for the ``Unknown block encoding`` exceptions.
The serialization is done in ``PagesSerde.serialize`` (used by ``TaskOutputOperator``, the data sender) and
deserialization is done in ``PagesSerde.deserialize`` (used by ``ExchangeOperator``, the
receiver of the data). As the logic is nicely encapsulated in ``PagesSerde`` class, we
added checksums to the serialized data: ``<checksum> <serialized page>``.
This felt like a smart move -- except that it gave us nothing more than a confirmation that
there is a problem ("checksum failure").
This we already knew.

We considered adding logging to capture data going out from one node and going in on
another node, but that would be huge amount of logs. One run of benchmarks transfers
hundreds of terabytes of data between the nodes.

We went ahead and created a Presto build that added data redundancy to be able to reconstruct
the data on the receiving side.
There are many [well-known error-correction codes](https://en.wikipedia.org/wiki/Erasure_code)
(e.g. [Reed–Solomon error correction](https://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction)
available in Hadoop 3). In our case, speed of _implementation_ (a.k.a. simplicity) was a deciding factor,
so we added data mirroring: ``<checksum> <serialized page> <serialized page>``.
In order to avoid logging of all the data exchanges, we added the deserialized pages (both copies)
to the exceptions being raised.

```
java.sql.SQLException: Query failed (#20200401_113622_00676_p7qp7): Hash mismatch, read: 1251072184702746109, calculated: 7591448164918409110
	Suppressed: java.lang.RuntimeException: Slice, first half: 040000000A0000004C4F4E475F415252.... (945 kilobytes)
    Suppressed: java.lang.RuntimeException: Slice, secnd half: 040000000A0000004C4F4E475F415252.... (945 kilobytes)
```

The exception told us the first part was changed, since read checksum did not match the calculated
checksum (it was calculated based on the first copy of the data and was different than the checksum
calculated on the sending side).
Having the encoded data in the exception like that, it was easy to extract the actual data and compare,
so now we could see _how_ the data was changed.

```
cat failure.txt | grep 'Slice, first half' | cut -d: -f4- | sed 's/^ *//' | xxd -r -p > changed
cat failure.txt | grep 'Slice, secnd half' | cut -d: -f4- | sed 's/^ *//' | xxd -r -p > original
```

Comparing binary files is fun, but in practice it can be more convenient to compare ``hexdump`` output.
The output below was created with ``vimdiff <(hexdump -Cv original) <(hexdump -Cv changed)``.
```
++--6064 lines: 00000000  04 00 00 00 0a 00 00 00  4c 4f 4...|+ +--6064 lines: 00000000  04 00 00 00 0a 00 00...
 00017b00  00 cb 6a 25 00 00 00 00  00 cb 6a 25 00 00 00 00  |  00 cb 6a 25 00 00 00 00  00 cb 6a 25 00 00 00 00
 00017b10  00 cb 6a 25 00 00 00 00  00 cb 6a 25 00 00 00 00  |  00 cb 6a 25 00 00 00 00  00 cb 6a 25 00 00 00 00
 00017b20  00 cb 6a 25 00 00 00 00  00 e1 67 25 00 00 00 00  |  00 cb 6a 25 00 00 00 00  00 e1 67 25 00 00 00 00
 00017b30  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00  |  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00
 00017b40  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00  |  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00
 00017b50  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00  |  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00
 00017b60  00 e1 67 25 00 00 00 00  00 e1 67 25 00 00 00 00  |  00 e1 67 25 00 00 00 00  e1 67 25 00 00 00 00 00
 00017b70  00 e1 67 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  e1 67 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017b80  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017b90  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017ba0  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017bb0  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017bc0  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017bd0  00 fb 69 25 00 00 00 00  00 fb 69 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  fb 69 25 00 00 00 00 00
 00017be0  00 fb 69 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  fb 69 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017bf0  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c00  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c10  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c20  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c30  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c40  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c50  00 5e 6a 25 00 00 00 00  00 5e 6a 25 00 00 00 00  |  5e 6a 25 00 00 00 00 00  5e 6a 25 00 00 00 00 00
 00017c60  00 34 68 25 00 00 00 00  00 34 68 25 00 00 00 00  |  34 68 25 00 00 00 00 00  34 68 25 00 00 00 00 00
 00017c70  00 34 68 25 00 00 00 00  00 34 68 25 00 00 00 00  |  34 68 25 00 00 00 00 00  34 68 25 00 00 00 00 00
 00017c80  00 34 68 25 00 00 00 00  00 34 68 25 00 00 00 00  |  34 68 25 00 00 00 00 00  34 68 25 00 00 00 00 00
 00017c90  00 34 68 25 00 00 00 00  00 34 68 25 00 00 00 00  |  34 68 25 00 00 00 00 00  34 68 25 00 00 00 00 00
 00017ca0  00 34 68 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  34 68 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017cb0  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017cc0  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017cd0  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017ce0  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017cf0  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017d00  00 2e 6b 25 00 00 00 00  00 2e 6b 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  2e 6b 25 00 00 00 00 00
 00017d10  00 2e 6b 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  2e 6b 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d20  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d30  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d40  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d50  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d60  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d70  00 cf 68 25 00 00 00 00  00 cf 68 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  cf 68 25 00 00 00 00 00
 00017d80  00 cf 68 25 00 00 00 00  00 6b 69 25 00 00 00 00  |  cf 68 25 00 00 00 00 00  6b 69 25 00 00 00 00 00
 00017d90  00 6b 69 25 00 00 00 00  00 6b 69 25 00 00 00 00  |  6b 69 25 00 00 00 00 00  6b 69 25 00 00 00 00 00
 00017da0  00 6b 69 25 00 00 00 00  00 6b 69 25 00 00 00 00  |  6b 69 25 00 00 00 00 00  6b 69 25 00 00 00 00 00
 00017db0  00 6b 69 25 00 00 00 00  00 6b 69 25 00 00 00 00  |  6b 69 25 00 00 00 00 00  6b 69 25 00 00 00 00 00
 00017dc0  00 6b 69 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  6b 69 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017dd0  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017de0  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017df0  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017e00  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017e10  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017e20  00 7e 66 25 00 00 00 00  00 7e 66 25 00 00 00 00  |  7e 66 25 00 00 00 00 00  7e 66 25 00 00 00 00 00
 00017e30  00 a9 66 25 00 00 00 00  00 a9 66 25 00 00 00 00  |  a9 66 25 00 00 00 00 00  a9 66 25 00 00 00 00 00
 00017e40  00 a9 66 25 00 00 00 00  00 a9 66 25 00 00 00 00  |  a9 66 25 00 00 00 00 00  a9 66 25 00 00 00 00 00
 00017e50  00 a9 66 25 00 00 00 00  00 a9 66 25 00 00 00 00  |  a9 66 25 00 00 00 00 00  a9 66 25 00 00 00 00 00
 00017e60  00 a9 66 25 00 00 00 00  00 a9 66 25 00 00 00 00  |  a9 66 25 00 00 00 00 00  a9 66 25 00 00 00 00 00
 00017e70  00 a9 66 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  a9 66 25 00 00 00 00 00  fb 67 25 00 00 00 00 00
 00017e80  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  fb 67 25 00 00 00 00 00  fb 67 25 00 00 00 00 00
 00017e90  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  fb 67 25 00 00 00 00 00  fb 67 25 00 00 00 00 00
 00017ea0  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00
 00017eb0  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00
 00017ec0  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00
 00017ed0  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00
 00017ee0  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 fb 67 25 00 00 00 00
 00017ef0  00 fb 67 25 00 00 00 00  00 5e 6b 25 00 00 00 00  |  00 fb 67 25 00 00 00 00  00 5e 6b 25 00 00 00 00
++--23429 lines: 00017f00  00 5e 6b 25 00 00 00 00  00 5e ...|+ +--23429 lines: 00017f00  00 5e 6b 25 00 00 0...
```

It is perhaps no surprise that 0 bytes occupied a lot of the data transfer. For performance reasons,
Presto uses fixed-length representation for fixed-length data types, such as integers or decimals.
Compressing data for the sake of network exchanges makes sense, if your network is saturated and
CPU is not, and is off by default. If we replace 0 bytes with ``__``, we see that the difference
between original (left) and changed (right) is pretty interesting: it looks like one 0 byte was
shifted from offset ``0x00017b60+5`` (approximately) to ``00017e90+12`` (approximately).
This is very unusual data change. We got other failure samples showing similar data changes,
with varying offset numbers.

```
++--6064 lines: 00000000  04 00 00 00 0a 00 00 00  4c 4f 4...|+ +--6064 lines: 00000000  04 00 00 00 0a 00 00...
 00017b00  __ cb 6a 25 __ __ __ __  __ cb 6a 25 __ __ __ __  |  __ cb 6a 25 __ __ __ __  __ cb 6a 25 __ __ __ __
 00017b10  __ cb 6a 25 __ __ __ __  __ cb 6a 25 __ __ __ __  |  __ cb 6a 25 __ __ __ __  __ cb 6a 25 __ __ __ __
 00017b20  __ cb 6a 25 __ __ __ __  __ e1 67 25 __ __ __ __  |  __ cb 6a 25 __ __ __ __  __ e1 67 25 __ __ __ __
 00017b30  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __  |  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __
 00017b40  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __  |  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __
 00017b50  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __  |  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __
 00017b60  __ e1 67 25 __ __ __ __  __ e1 67 25 __ __ __ __  |  __ e1 67 25 __ __ __ __  e1 67 25 __ __ __ __ __
 00017b70  __ e1 67 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  e1 67 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017b80  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017b90  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017ba0  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017bb0  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017bc0  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017bd0  __ fb 69 25 __ __ __ __  __ fb 69 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  fb 69 25 __ __ __ __ __
 00017be0  __ fb 69 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  fb 69 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017bf0  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c00  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c10  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c20  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c30  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c40  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c50  __ 5e 6a 25 __ __ __ __  __ 5e 6a 25 __ __ __ __  |  5e 6a 25 __ __ __ __ __  5e 6a 25 __ __ __ __ __
 00017c60  __ 34 68 25 __ __ __ __  __ 34 68 25 __ __ __ __  |  34 68 25 __ __ __ __ __  34 68 25 __ __ __ __ __
 00017c70  __ 34 68 25 __ __ __ __  __ 34 68 25 __ __ __ __  |  34 68 25 __ __ __ __ __  34 68 25 __ __ __ __ __
 00017c80  __ 34 68 25 __ __ __ __  __ 34 68 25 __ __ __ __  |  34 68 25 __ __ __ __ __  34 68 25 __ __ __ __ __
 00017c90  __ 34 68 25 __ __ __ __  __ 34 68 25 __ __ __ __  |  34 68 25 __ __ __ __ __  34 68 25 __ __ __ __ __
 00017ca0  __ 34 68 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  34 68 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017cb0  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017cc0  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017cd0  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017ce0  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017cf0  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017d00  __ 2e 6b 25 __ __ __ __  __ 2e 6b 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  2e 6b 25 __ __ __ __ __
 00017d10  __ 2e 6b 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  2e 6b 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d20  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d30  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d40  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d50  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d60  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d70  __ cf 68 25 __ __ __ __  __ cf 68 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  cf 68 25 __ __ __ __ __
 00017d80  __ cf 68 25 __ __ __ __  __ 6b 69 25 __ __ __ __  |  cf 68 25 __ __ __ __ __  6b 69 25 __ __ __ __ __
 00017d90  __ 6b 69 25 __ __ __ __  __ 6b 69 25 __ __ __ __  |  6b 69 25 __ __ __ __ __  6b 69 25 __ __ __ __ __
 00017da0  __ 6b 69 25 __ __ __ __  __ 6b 69 25 __ __ __ __  |  6b 69 25 __ __ __ __ __  6b 69 25 __ __ __ __ __
 00017db0  __ 6b 69 25 __ __ __ __  __ 6b 69 25 __ __ __ __  |  6b 69 25 __ __ __ __ __  6b 69 25 __ __ __ __ __
 00017dc0  __ 6b 69 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  6b 69 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017dd0  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017de0  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017df0  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017e00  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017e10  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017e20  __ 7e 66 25 __ __ __ __  __ 7e 66 25 __ __ __ __  |  7e 66 25 __ __ __ __ __  7e 66 25 __ __ __ __ __
 00017e30  __ a9 66 25 __ __ __ __  __ a9 66 25 __ __ __ __  |  a9 66 25 __ __ __ __ __  a9 66 25 __ __ __ __ __
 00017e40  __ a9 66 25 __ __ __ __  __ a9 66 25 __ __ __ __  |  a9 66 25 __ __ __ __ __  a9 66 25 __ __ __ __ __
 00017e50  __ a9 66 25 __ __ __ __  __ a9 66 25 __ __ __ __  |  a9 66 25 __ __ __ __ __  a9 66 25 __ __ __ __ __
 00017e60  __ a9 66 25 __ __ __ __  __ a9 66 25 __ __ __ __  |  a9 66 25 __ __ __ __ __  a9 66 25 __ __ __ __ __
 00017e70  __ a9 66 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  a9 66 25 __ __ __ __ __  fb 67 25 __ __ __ __ __
 00017e80  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  fb 67 25 __ __ __ __ __  fb 67 25 __ __ __ __ __
 00017e90  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  fb 67 25 __ __ __ __ __  fb 67 25 __ __ __ __ __
 00017ea0  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __
 00017eb0  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __
 00017ec0  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __
 00017ed0  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __
 00017ee0  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ fb 67 25 __ __ __ __
 00017ef0  __ fb 67 25 __ __ __ __  __ 5e 6b 25 __ __ __ __  |  __ fb 67 25 __ __ __ __  __ 5e 6b 25 __ __ __ __
++--23429 lines: 00017f00  00 5e 6b 25 00 00 00 00  00 5e ...|+ +--23429 lines: 00017f00  00 5e 6b 25 00 00 00...
```

# Outside of Presto

We captured a cluster of 10 nodes manifesting the problem and hold on to it in further investigation.
Our testing showed that TPC-DS query 72 is significantly more likely to fail than other queries.
On the isolated cluster, a loop running TPC-DS query 72 would reproduce a failure within 2 hours.
We added additional information in the exception reporting checksum failure, to identify on which
node the failure happens and which node is the sender of the data. For all the failures on the isolated
10-node cluster, the failure would always happen with one worker node (``10.83.28.124``, the Receiver) reading data
from certain other worker node (``10.142.0.84``, the Sender). We stopped all other workers and attempted to
reproduce the problem outside of Presto.

One of the things we tried was checking the network reliability with netcat.
On the Sender node, we ran the following:

```
dd if=/dev/urandom of=/tmp/small-data bs=$[1024*1024] count=1
ncat -l 20165 --keep-open --max-conns 100 --sh-exec "cat /tmp/small-data" -v
```

On the Receiver node we run the following in a loop:
```
ncat --recv-only 10.142.0.84 20165 > "/tmp/received"
sha1sum "/tmp/received"
```

Running this in a loop for just a few dozens of seconds resulted in ``/tmp/received`` different
than ``/tmp/small-data``. Sometimes the ``/tmp/received`` would be "just" a prefix of the original data
and sometimes there would be data displacements within the ``/tmp/received`` file. We cross-checked these
observations on a different pair of nodes and also on a different public cloud, using same netcat version.
We observed the same behavior everywhere we checked it, with varying, but high error rate, over 1%. This high
error rate was what led us to discard this evidence -- there was either something wrong with the way we
used netcat, we violated netcat's assumptions or netcat was not the right tool for this task.

We searched for other tools that we could use. ``iperf`` is a well-known tool for stressing out the network.
Sadly, ``iperf`` [does not have an ability to verify exchanged data integrity yet](https://github.com/esnet/iperf/issues/157).
We deployed a [home-made, Java-based tool](https://github.com/findepi/netsum) instead. using this tool
we were able to reproduce the data corruption problem between Sender and Receiver nodes. The error rate
was very low. To reproduce the problem we had to saturate the network and use multiple concurrent TCP connections
(which is very similar to how Presto uses the network). This validated our
observations that the data corruption problem was happening outside of Presto. Interestingly, we were unable
to reproduce the problem when stressing the network with a single TCP connection.

# Mystery unsolved

Obviously, with such a strong evidence gathered so far, we opened a support ticket with AWS.
The support team was great and did a lot of investigation on their own. Unfortunately, the problem went
away before the support team was able to get to the bottom of it. It was April already.
Perhaps, one day someone will find the smoking gun and write the rest of this story.

# Conclusions

We implemented data integrity protection measure in Presto. We used [Martin Traverso's](https://github.com/martint)
Java implementation of the [XXHash64](https://github.com/Cyan4973/xxHash) algorithm. Thanks to its
speed, we could enable it by default, with negligible impact on overall query performance.
By default, data integrity violation results in query failure, but Presto can be configured to retry as well,
by setting the ``exchange.data-integrity-verification`` configuration property.

This chapter of the Presto history should remain closed and we should be able to forget about all this.
However, a couple days ago, a customer running Presto on Azure Kubernetes Service (AKS) reported an exception like
the one below. On the next day, we bumped into this as well. We were doing ``CREATE TABLE AS SELECT``
to prepare a new benchmark dataset on Azure Storage.

```
Query failed (#20200622_124803_00000_abcde): Checksum verification failure on 10.12.3.47
    when reading from http://10.12.3.53:8080/v1/task/20200622_124803_00000_abcde.2.6/results/5/8:
    Data corruption, read checksum: 0xe17e6eaeb665dc6e, calculated checksum: 0xb3540697373195f1
```

It is no fun when a query fails like this. However -- what a joy and pride that it did not silently
return incorrect query results. Rest assured, Presto will not return incorrect results, wherever you
run it.

# Credits

Special thanks go to our customers, for your understanding and the trust you have in us.
Without you, Starburst wouldn't be as fun place as it is!
Thanks to [Łukasz Walkiewicz](https://github.com/lukasz-walkiewicz) and [Karol Sobczak](https://github.com/sopel39)
for fantastic benchmark and experimentation automation and your help with running the experiments!
Thanks to [Will Morrison](https://github.com/willmostly) for finding the Sender and Receiver machines
that reproduced the problem so nicely!
Thanks to [Martin Traverso](https://github.com/martint), [Dain Sundstrom](https://github.com/dain)
and [David Phillips](https://github.com/electrum) for guidance, ideas, clever tips and code pointers!
Thanks to [Łukasz Osipiuk](https://github.com/losipiuk) for running experiments, cross-checking
the results and helping keep sanity. Shout out to the whole Starburst team -- it was truly a team's work!

□
