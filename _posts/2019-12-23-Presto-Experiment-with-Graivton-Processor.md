---
layout: post
title: Presto Experiment with Graviton Processor
author: Kai Sasaki, Arm Treasure Data
excerpt_separator: <!--more-->
---

This December, AWS announced new instance types powered by [Arm-based AWS Graviton2 Processor](https://aws.amazon.com/about-aws/whats-new/2019/12/announcing-new-amazon-ec2-m6g-c6g-and-r6g-instances-powered-by-next-generation-arm-based-aws-graviton2-processors/). M6g, C6g, and R6g are designed to deliver up to 40% improved price/performance compared with the current generation instance types. We can achieve cost-effectiveness by using these instance type series. Presto is just a Java application, so that we should be able to run the workload with this type of cost-effective instance type without any modification.

But is it true? Initially, we do not have a clear answer to how much effort we need to bring Presto into the world of the different processors. No care about the underlying platform is generally beneficial for development. But if using different processors enables us to accelerate the performance and stability of Presto, we must care about it. We must prove anything unclear by the experiment.

This article is the report to clarify what we need to do to run Presto on the Arm-based platform and see how much benefit we can potentially obtain with Graviton Processor.

As the Graviton 2 based instance types are preview state, we tried to run Presto on A1 instance that has the first generation of Graviton processor inside. It still would be a helpful anchor to understand the potential benefit of the Graviton 2 processor.

<!--more-->

# How to make Presto compatible with Arm

We are going to build the binary of Presto supporting Arm platform first. From the results, there are not so many things to do so. As long as JVM supports the Arm platform, it should work without any modification in the application code. But Presto has some restrictions on the platform where it runs to protect the functionality, including plugins. For instance, the latest Presto supports only [x86 and PowerPC architectures]({{site.github_repo_url}}/blob/ee05ee5221690d66598039c6e397f7c7cb4c202b/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java#L69). This limitation prevents us from using Presto on the Arm platform.

To make Presto runnable on Arm machine, we need to modify [PrestoSystemRequirements]({{site.github_repo_url}}/blob/master/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java) class to allow `aarch64` architecture and more. For experimental purposes, we can apply such a patch to remove the restriction altogether.

```
diff --git a/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java b/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java
index 07b7d12c64..b6a1249681 100644
--- a/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java
+++ b/presto-main/src/main/java/io/prestosql/server/PrestoSystemRequirements.java
@@ -71,9 +71,9 @@ final class PrestoSystemRequirements
 String osName = StandardSystemProperty.OS_NAME.value();
 String osArch = StandardSystemProperty.OS_ARCH.value();
 if ("Linux".equals(osName)) {
- if (!"amd64".equals(osArch) && !"ppc64le".equals(osArch)) {
- failRequirement("Presto requires amd64 or ppc64le on Linux (found %s)", osArch);
- }
 if ("ppc64le".equals(osArch)) {
 warnRequirement("Support for the POWER architecture is experimental");
 }
```

This patch is all we have to do to run Presto on the Arm platform. It should work for most cases except for the usage with [Hive connector]({{site.url}}/docs/current/connector/hive.html) because it has a native code not yet available for Arm platform.

# Prepare Docker Images

Docker container is a desirable option to run Presto experimentally due to its availability and easiness of use. But there is one thing to do to build Docker image supporting cross-platform.

[Docker buildx](https://docs.docker.com/buildx/working-with-buildx/) is an experimental feature for the full support of [Moby BuildKit toolkit](https://github.com/moby/buildkit). It enables us to build a Docker image supporting multiple platforms, including Arm. The feature is so useful that we can quickly make the cross-platform Docker image with a one-line command. But the feature is not generally available in the typical installation of Docker. Enabling the experimental flag is necessary as follows in the case of macOS.

![Docker Daemon Experimental Feature](/assets/blog/presto-experiment-with-graviton-processor/docker-daemon.png)

And make sure to restart the Docker daemon. We can build the Docker image for Presto supporting `aarch64` architecture with `buildx` command. We have used the source code of [`317-SNAPSHOT`]({{site.github_repo_url}}/commit/b0c07249de5c70a70b3037875df4fd0477dec9fc) with the earlier patch in the `PrestoSystemRequirements`.

```
$ docker buildx build \
 --build-arg VERSION=317-SNAPSHOT \
 --platform linux/arm64 \
 -f presto-base/Dockerfile-aarch64 \
 -t lewuathe/presto-base:317-SNAPSHOT-aarch64 \
 presto-base --push

$ docker buildx build \
 --build-arg VERSION=317-SNAPSHOT-aarch64 \
 --platform linux/arm64 \
 -t lewuathe/presto-coordinator:317-SNAPSHOT-aarch64 \
 presto-coordinator --push

$ docker buildx build \
 --build-arg VERSION=317-SNAPSHOT-aarch64 \
 --platform linux/arm64 \
 -t lewuathe/presto-worker:317-SNAPSHOT-aarch64 \
 presto-worker --push
```

We should be able to specify multiple platform names for `--platform` option. But unfortunately, the Docker image of OpenJDK for Arm is distributed under [the separated organization](https://hub.docker.com/r/arm64v8/openjdk/), `arm64v8/openjdk`. Building an image supporting Arm requires us another [`Dockerfile`](https://github.com/Lewuathe/docker-presto-cluster/blob/master/presto-base/Dockerfile-aarch64). Anyway, Docker images containing Presto supporting Arm are now available.

# Setup A1 Instance

The following setup prepares the environment enough to run docker-compose on the A1 instance. [As no docker-compose binary for Arm](https://github.com/docker/compose/issues/5342) is distributed officially, we need to install and build docker-compose with `pip`. Make sure to run them after the instance initialization completes.

```
# Install Docker
$ sudo yum update -y
$ sudo amazon-linux-extras install docker -y
$ sudo service docker start
$ sudo usermod -a -G docker ec2-user

# Install docker-compose
$ sudo yum install python2-pip gcc libffi-devel openssl-devel -y
$ sudo pip install -U docker-compose
```

# Performance Comparison

Let's briefly take a look into how the performance provided by the Graviton processor looks like. We are going to use [a1.4xlarge](https://aws.amazon.com/ec2/instance-types/a1/) as a benchmark instance of Graviton processor.

Here is our specification of the benchmark conditions.

- We use the commit [`b0c07249de5c70a70b3037875df4fd0477dec9fc`]({{site.github_repo_url}}/commit/b0c07249de5c70a70b3037875df4fd0477dec9fc) + the patch previously described.
- 1 coordinator + 2 worker processes run by [docker-compose](https://docs.docker.com/compose/) on a single instance.
- We use a1.4xlarge and c5.4xlarge, whose CPU core and memory are the same as a1.4xlarge. And we also compared with m5.2xlarge, whose on-demand instance cost is close to a1.4xlarge.
- We use [q01, q10, q18, and q20]({{site.github_repo_url}}/tree/master/presto-benchto-benchmarks/src/main/resources/sql/presto/tpch) run on the TPCH connector. Since the Presto TPCH connector does not access external storage, we can measure pure CPU performance without worrying about network variance.
- We choose `tiny` and `sf1` as the scaling factor of TPCH connector
- Our experiment measures the average time of 5 query runtime after 5 times warmup for every query.

#### OpenJDK 8
Here is the result of our experiment. The vertical axis represents the running time in milliseconds.

![OpenJDK 8 Performance](/assets/blog/presto-experiment-with-graviton-processor/openjdk8-performance.png)

It shows c5.4xlarge achieves the best performance consistently in every case. Compared with m5.2xlarge, the result was switched by the query type. a1.4xlarge and m5.2xlarge are probably competing with each other.

Although we use OpenJDK 8 for this case, it might not be able to generate the code fully optimized for Arm architecture. In general, the later versions, such as [OpenJDK 9 or 11, give us better performance](https://medium.com/@carlosedp/java-benchmarks-on-arm64-17edd8b9ff79).

#### OpenJDK 11
Let's try to run Presto with OpenJDK 11 again.  There is one thing to do. From JDK 9, the [Attach API](https://bugs.java.com/bugdatabase/view_bug.do?bug_id=8180425) was disabled as default. We have found that we needed to allow the usage of attach API by adding the following option in `jvm.config` file, otherwise we will see an error message at the bootstrap phase.

```
-Djdk.attach.allowAttachSelf=true
```

Here is the performance comparison with OpenJDK 11.

![OpenJDK 11 Performance](/assets/blog/presto-experiment-with-graviton-processor/openjdk11-performance.png)

a1.4xlarge and c5.4xlarge achieve even higher performance than OpenJDK 8 for every case. On the contrary, m5.2xlarge shows a slower result in some cases.
While this result still demonstrates c5.4xlarge is the best instance in terms of the performance, the performance gaps between instances are smaller compared with the OpenJDK 8 cases. Especially, a1.4xlarge shows relatively competitive performance with the smaller dataset (`tiny`). How does the scaling factor influence performance? We'll see.

![Scaling Factor Comparison](/assets/blog/presto-experiment-with-graviton-processor/sf-comparison.png)

The above chart shows how performance is affected by the scaling factor. c5.4xlarge demonstrates the most stable running time, regardless of the scaling factor. If we want to achieve stable performance as much as possible, c5.4xlarge is a good option in the list. a1.4xlarge and m5.2xlarge show similar volatility against the scaling factor this time.

Considering the cost of a1.4xlarge instance is 40% cheaper than c5.4xlarge, it may make sense to use a1.4xlarge for the specific case. The on-demand cost of [a1.4xlarge is $9.8/day and c5.4xlarge is $16.3/day for on-demand instance type](https://aws.amazon.com/ec2/pricing/on-demand/). The public announcement says [Graviton 2 delivers 7x performance compared to the Graviton processor](https://aws.amazon.com/ec2/graviton/). We may expect an even better performance by using a new generation processor. We cannot wait for the general availability of Graviton 2.

#### Amazon Corretto
How about other JVM distributions? Now we have found Amazon Corretto also supports Arm architecture, and it distributes [the Docker image built for Arm](https://hub.docker.com/layers/amazoncorretto/library/amazoncorretto/11/images/sha256-8f06c4a09e6a0784d6da3fb580bd57c4881df3fc8f56de1f3c0fd66dde20e43c). Let's try Amazon Corretto similarly.

![A1 Performance](/assets/blog/presto-experiment-with-graviton-processor/a1-instance-performance.png)

This chart illustrates the performance result by different JDK implementations, OpenJDK 8, OpenJDK 11, and Amazon Corretto 11. Overall, OpenJDK 11 seems to be the best. But Amazon Corretto achieves the even better performance in some of the sf1 cases interestingly. It indicates that Presto with Amazon Corretto may provide better performance in some query types.

# Wrap Up

As Presto is just a Java application, there are not so many things to do to support the Arm platform. Only applying one patch and one JVM option brings us Presto binary supporting the latest platform. It is always exciting to see a new technology used for complicated distributed systems such as Presto. The combination of cutting-edge technologies surely takes us a journey to the new horizon of technological innovation.

Last but not least, we have used docker-compose and TPCH connectors to execute queries for the Presto cluster quickly in the Arm platform. Note that the performance of a distributed system such as Presto depends on various kinds of factors. Please be sure to run your benchmark carefully when you try to use a new instance type in your production environment.

We have uploaded the Docker image used for this experiment publicly. Feel free to use them if you are interested in running Presto on the Arm platform.

```
# Image for Armv8 using OpenJDK 11
$ docker pull lewuathe/presto-coordinator:327-SNAPSHOT-aarch64
$ docker pull lewuathe/presto-worker:327-SNAPSHOT-aarch64


# Image for Armv8 using Amazon Corretto 11
$ docker pull lewuathe/presto-coordinator:327-SNAPSHOT-corretto
$ docker pull lewuathe/presto-worker:327-SNAPSHOT-corretto
```

And also, I have raised [an issue]({{site.github_repo_url}}/issues/2262) to start the discussion of supporting Arm architecture in the community. It would be great if we could get any feedback from those who are interested in it.

Thanks!