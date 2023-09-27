---
layout: post
title:  "Trino Gateway has arrived"
author: Manfred Moser, Martin Traverso
image: /assets/images/logos/trino-gateway-small.png
excerpt_separator: <!--more-->
show_pagenav: false
---

You started with one Trino cluster, and your users like the power for SQL and
[querying all sorts of data sources]({{site_url}}/ecosystem/index.html#data-sources).
Then you needed to upgrade and got a cluster for testing going. That was a while
ago, and now you run a separate cluster configured for ETL workloads with
fault-tolerant execution, and some others with different configurations.

With Trino Gateway we now have an answer to your users request to provide on URL
for all the clusters. Trino Gateway has arrived!

<!--more-->

Today, we are happy to announce our [first release of Trino
Gateway](https://github.com/trinodb/trino-gateway/blob/main/docs/release-notes.md#trino-gateway-3-26-sep-2023).
The release is the result of many, many months of effort to move the legacy
Presto Gateway to Trino, start a refactor of the project, and add numerous new
features.

Many larger deployments across the Trino community rely on the gateway as a load
balancer, proxy server, and configurable routing gateway for multiple Trino
clusters. Users don't need to worry about what catalog and data source is
available in what Trino cluster. Trino Gateway exposes one URL for them all.
Administrators can ensure routing is correct and use the REST API to configure
the necessary rules. This also allows seamless upgrades of clusters behind Trino
Gateway in a blue/green deployment mode.

Up to now, many users had to maintain separate forks of the legacy Presto
Gateway. Some of these users created numerous improvements in isolation of each
other, sometimes even implementing the same feature multiple times. This first
release of Trino Gateway starts a strong collaboration of some of these users.
Bloomberg contributed the main bulk of the new features, including the
much-requested support for authentication and authorization on Trino Gateway
itself. Maintainers and contributors from Starburst pulled together the
stakeholders and managed the project, and collaborators from Naver, LinkedIn,
Dune, and others are already helping out and ready to move the project forward.

There are exciting times ahead for the project, and we have big plans for
documentation, installation, and general modernizations of the app, so go and
have a look at the project, read the documentation and release notes, file an
issue, or submit a pull request:

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="https://github.com/trinodb/trino-gateway">
        Trino Gateway
    </a>
</div>
<div class="spacer-30"></div>

Interested to find out more? Find us and others users and contributors on the
[`trino-gateway`](https://trinodb.slack.com/app_redirect?channel=trino-gateway)
and
[`trino-gateway-dev`](https://trinodb.slack.com/app_redirect?channel=trino-gateway-dev)
channels in [the Trino community Slack]({{site.baseurl}}/slack.html).

Also, don't forget to tell us about your usage of Trino Gateway or Trino and
[submit a talk for Trino Summit
2023](https://sessionize.com/trino-summit-2023/). And if you just want to learn
and listen to others, [register as
attendee](https://www.starburst.io/info/trinosummit2023/?utm_source=trino&utm_medium=website&utm_campaign=NORAM-FY24-Q4-EV-Trino-Summit-2023&utm_content=blog-1).

*Manfred, Martin, and all the other Trino Gateway contributors*
