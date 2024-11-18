---
layout: post
title: "Trino and Javascript?! YES!"
author: "Manfred Moser"
excerpt_separator: <!--more-->
image: /assets/images/logos/javascript-small.png
---

Trino is written in Java. Trino contributors and maintainers are often veterans
in the Java ecosystem and community, and Trino is very modern when it comes to
Java. For example, Trino now requires the latest Java version and actively uses
new features. 

When it comes to JavaScript however, the story is a bit more complicated. Of
course, JavaScript is commonly used in the Trino ecosystem and codebase. Let's
look at some of the specifics.

<!--more-->

## Client driver and applications

Client applications that allow users to submit queries to Trino, and then
receive the results are written in numerous languages. Trino has good support
for [many of them]({{site.baseurl}}/ecosystem/index.html#clients).

Thanks to the collaboration with [Filipe Regadas](https://github.com/regadas)
and the contribution of his JavaScript client driver to the Trino community, we
now have an official
[trino-js-client](https://github.com/trinodb/trino-js-client) project. After his
initial donation we have applied numerous improvements and recently cut our
first release. 

The client is already used in the [VisualCode
support]({{site.baseurl}}/ecosystem/client#vscode), the [Emacs
support]({{site.baseurl}}/ecosystem/client#emacs), the example project discussed
in [Trino Community Broadcast episode 63]({{site.baseurl}}/episodes/63.html),
and numerous other applications.

And we have big plans as well:

* Add support for more authentication methods supported in Trino
* Improve documentation and example projects
* Add support for the new spooling client protocol from Trino
* Test with Trino Gateway and adjust as needed

While this project is a great addition for many users of Trino and their custom
web applications, there are numerous other usages of JavaScript in the project.

## User interfaces

Web-based user interfaces are one important use of JavaScript. Trino includes
the [Trino Web UI]({{site.baseurl}}/docs/current/admin/web-interface.html) and
the ongoing effort to replace it with a more modern and feature rich UI -
currently called the [Preview
UI]({{site.baseurl}}/docs/current/admin/preview-web-interface.html). It was
inspired by the replacement of the legacy UI for [Trino
Gateway](https://trinodb.github.io/trino-gateway/) with a new UI based on
current tools and libraries.

All three user interfaces require constant work in terms of upkeep to current
libraries, bug fixes, and addition of new features.

## Other projects

Beyond the user interfaces we also provide a [plugin for
Grafana](https://github.com/trinodb/grafana-trino) that is mostly written in
Javascript, and there might be more projects on the way.

## What's next?

The skills and experience needed for all these JavaScript-based efforts are
different enough to ensure that there are developers out there who can help in
these efforts without knowing much about Trino and Java.

If that is you, we want to hear from you. And if you are also knowledgable in
Trino, Java, and many other things, and also interested to help on the
JavaScript stuff, we also want to hear from you. There is always more stuff we
want to get done and we need your help.

So have a look at the codebase that interests you the most, chat with us on
[Trino Slack]({{site.baseurl}}/slack.html), join an [upcoming Trino contributor
call]({{site.baseurl}}/community.html#events) and [Trino Summit]({% post_url
2024-10-17-trino-summit-2024-tease %}), and let me know if you would be
interested in a regular Trino JavaScript call - for example monthly?

And if you don't want to code in Java or JavaScript? Well, you can help us write
[documentation in Markdown](https://github.com/trinodb/trino/tree/master/docs),
work on the [Python client](https://github.com/trinodb/trino-python-client), the
[Go client](https://github.com/trinodb/trino-go-client), or maybe even
contribute a client we don't even have yet.

In all cases, we look forward to your help.
