---
layout: post
title:  "Log4Shell does not affect Trino"
author: Brian Olsen
excerpt_separator: <!--more-->
---

In the last few days we had a surge of folks in our community reaching out with
concerns over the [Log4Shell exploit](https://www.lunasec.io/docs/blog/log4j-zero-day/)
([CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)),
and we want to inform you that **Trino is not affected**. Trino does not use log4j
in the core engine or runtime classes. There are some connectors that include 
the log4j dependency from client dependencies, but are either not used or are 
not versions affected by the Log4Shell vulnerability. Regular security reviews, 
including code and dependency analysis, are part of the regular development 
process. As we learn more we will update the code to keep vulnerabilities out of
the code.

<p align="center">
 <img align="center" width="50%" src="/assets/blog/log4shell/log4shell.jpeg"/>
</p>

<!--more-->

## Trino connectors with the Log4j dependency

If you do a search in the Trino repository, you'll notice two direct 
dependencies of the log4j dependency shows up in two of the connectors, Accumulo
and Elasticsearch.

### Accumulo

The Accumulo connector depends on log4j 1.2.17, which although isn't vulnerable
to Log4Shell, has other vulnerabilities. These vulnerabilities do not apply to 
how we've used the loggers in the connector code. To be clear, despite the small
use of this logger in the Accumulo connector, there is still no threat even if 
you are using it. We are [working on removing](https://github.com/trinodb/trino/issues/8781)
the uses of this log4j library to avoid any confusion in an upcoming release.

### Elasticsearch

The Elasticsearch connector did have an affected dependency 
[that was recently removed](https://github.com/trinodb/trino/commit/2018a94253d48cfdce283538855ee65950f9be3d).
Log4j was not being used in the connector. So despite the existence of the 
dependency in the Elasticsearch connector, there is no direct use of the 
vulnerable library.

## Avoiding future introduction of Log4Shell

We take security seriously on the Trino project, as it provides a single point 
of access to your data sources. We're taking precautionary measures to protect 
against the vulnerability from creeping its way into future versions. In version
366, we're removing that dependency and [adding a dedicated rule](https://github.com/trinodb/trino/commit/10ba96c63ed3875d9dcca335e49bc73f5c0a6a8c)
to the build process to ban log4j as a direct dependency.

## What should you do?

1. Rest assured that there is no vulnerability in your Trino cluster. 

2. If you've created your own plugin with one of the affected log4j libraries, 
you should upgrade as quickly as possible to 2.15.0 or higher. 

3. In the coming weeks, upgrade to the 366 release at your convenience.

We know there can be a lot of concern when vulnerabilities come up. We wish you
all the best of luck while you work hard to mitigate the risk of exploits in 
your systems. If you have any questions, reach out on the [Trino Slack](https://trino.io/slack.html).