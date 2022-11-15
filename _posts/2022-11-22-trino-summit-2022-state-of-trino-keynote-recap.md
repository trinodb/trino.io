---
layout: post
title: "Trino Summit 2022 recap: The state of Trino"
author: "Martin Traverso, Dain Sundstrom, David Phillips, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/keynote-header.jpeg
---

To kick off the [Trino Summit 2022]({% post_url 2022-11-21-trino-summit-2022-recap %}),
we heard from Trino co-creators Martin Traverso, Dain Sundstrom, and David
Phillips. Martin gave a talk on the state of Trino and project plans for 2023,
then opened the floor to questions from the community. You can watch a recording
of the talk, or read on if you're only interested in the highlights.

<!--more-->

{% youtube mUq_h3oArp4 %}


<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/State-of-Trino-Nov-2022.pdf">
  Check out the slides here!
</a>

## Recapping

So what *has* happened in Trino over the last year?

* [We celebrated Trino's 10th birthday!](https://trino.io/blog/2022/08/08/trino-tenth-birthday.html)
* It was the busiest year in project history, with 600+ contributors, 4000+
  commits, and near-weekly releases.
* Tons of new features were added, including `MERGE`, JSON functions, table
  functions, fault-tolerant execution (look forward to a lot of talking about it
  in later recaps!), upgrading to Java 17, and a slide so dense with other
  goodies that it needed two columns.

And what's coming down the pipeline?

* [Project Hummingbird](https://github.com/trinodb/trino/issues/14237), a large
  set of core engine improvements.
* Expanded table function support, including accepting tables as arguments.
* Extra community support, so that contributors have an easier and better time
  getting code merged into Trino.
* New connectors, `CREATE/DROP CATALOG`, query tracing, and more!

There were also tons of great questions asked by live and online attendees
answered by Dain, David, and Martin, so if you want to hear more, take a listen
to the full talk!

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social card and
link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/keynote-social.png"/>