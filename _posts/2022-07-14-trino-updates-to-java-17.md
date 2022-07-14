---
layout: post
title:  "Trino updates to Java 17"
author: "Cole Bowden"
excerpt_separator: <!--more-->
---

You've already read the title, and it's exciting news - as of Trino version 390,
which releases today, Trino has officially been updated from Java 11 to Java 17.
This has a few implications, the most important of which is that if you aren't
running the Docker image (which automatically comes with the correct version of
Java) and you've been running Trino on Java 16 or older, you'll need to update
Java to run Trino versions 390 and later. It's also worth mentioning that newer
versions of Java, such as Java 18 or 19, are not supported - they might work,
but they haven't been tested or benchmarked - Java 17 is the new, recommended
version for Trino.

<!--more-->

The reason this change is exciting is that using a new and better version of
Java will make Trino better, too! This initial change is an update to the
runtime version, or what the Trino engine uses while it runs. Because the Java
language performs slightly better on the whole with this update, you may see
some small, across-the-board performance improvements when switching from Java
11 to Java 17. So when you've got the time, we strongly recommend making the
upgrade!

The plan is to update the build to Java 17 a few weeks from now, which will also
allow us to use Java 17 APIs and the changes to the language in Trino code. With
new language features, there are more tools in the development toolkit, and
it'll allow us to write cleaner and better code moving forwards.

This upgrade has been in the works for a while and been a long time coming, so
if you want to learn more about the specifics, one of the best places to check
that out is the Trino Community Broadcast. Updating to Java 17 was the focus of
[episode 36](https://trino.io/episodes/36.html), and we also talked about it
previously in [episode 35](https://trino.io/episodes/35.html). If you want to
check out the code changes that made this happen, you can view
[the tracking issue on Github](https://github.com/trinodb/trino/issues/9876) for
more information.

And finally, we want to give a shoutout to [Mateusz Gajewski](https://github.com/wendigo)
for all the hard work in driving this change.