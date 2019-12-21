---
layout: post
title: Running Presto with Graviton Processor
author: Kai Sasaki, Arm Treasure Data
excerpt_separator: <!--more-->
---

This December, AWS announced new instance types powered by [Arm-based AWS Graviton2 Processor](https://aws.amazon.com/about-aws/whats-new/2019/12/announcing-new-amazon-ec2-m6g-c6g-and-r6g-instances-powered-by-next-generation-arm-based-aws-graviton2-processors/). M6g, C6g and R6g are designed to deliver up to 40% improved price/performance compared with the current generation instance types. We can achieve cost-effectiveness by using these instance type series.

Presto is just a Java application so that we should be able to run the workload with this type of cost-effective instance type without any modification. But really?
So this is the report to clarify what we need to do to run Presto on the Arm based platform and see how much benefit we can potentially obtain with Graviton Processor.

As the Graviton 2 based instance types are preview state, I tried to run Presto on A1 instance that has the first generation of Graviton processor inside.

<!-- more -->

# How to make Presto compatible with Arm

There is not so many things to do to support Arm architecture in Presto. But Presto 