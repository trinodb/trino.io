---
layout: post
title:  "Integrating Trino and Snowflake: An open source success story"
author: Brian Olsen
excerpt_separator: <!--more-->
image: /assets/blog/snowflake-connector/bunny-snowflake.jpeg
canonical_url: https://bitsondata.dev/trino-snowflake-bloomberg-oss-win
---

Adapted from on [bits on data blog](https://bitsondata.dev/trino-snowflake-bloomberg-oss-win).

This post highlights the extraordinary contributions of 
[Erik Anderson](https://www.linkedin.com/in/erikanderson/), 
[Teng Yu](https://www.linkedin.com/in/tyu-fr/), 
[Yuya Ebihara](https://www.linkedin.com/in/ebyhr/), and the broader 
[Trino community](https://github.com/trinodb/trino) to finally contribute the 
long-coveted 
[Trino Snowflake connector](https://trino.io/docs/current/connector/snowflake.html).
It is a success story paired with a blueprint for individuals and corporations 
wanting to contribute to open source projects they use. These stories are valuable in
that they demonstrate how to be most effective in collaborating with 
strangers-soon-to-be-friends and common pitfalls to avoid.

<!--more-->
 
## A common challenge in open source

Much like any open source project, maintainers on the Trino project struggle with 
communicating the lack of proper resources to build and test new features built
for various proprietary software. Trino tests integrations with open data 
sources by running small local instances of the connecting system. Snowflake is
a proprietary, cloud-native data warehouse, also known as cloud data platform.
This provided no viable and free way to support testing this integration that was 
[eagerly](https://github.com/trinodb/trino/pull/2551#issuecomment-873082280)
[sought](https://github.com/trinodb/trino/issues/1863)
[by many](https://github.com/trinodb/trino/issues/7247). After an
[initial attempt](https://github.com/trinodb/trino/pull/2551) by my friend
[Phillipe Gagnon](https://www.linkedin.com/in/pfgagnon), a similar pattern
emerged [with the second pull request](https://github.com/trinodb/trino/pull/10387)
where the development velocity started strong and after some months stagnated.

A common and unfortunate class of issues occur when contributors and
maintainers are so busy with their day jobs, families, and self care, that
they dedicate most of their remaining energy to ensuring they write quality 
code and tests to the best of their ability. Lack of upfront communication
to validate ideas from newer contributors is generally the last thing on
their mind. Follow-through on either side can be difficult as newcomers
don't want to be rude and maintainers accidentally forget or hope someone
else will take the time to address the issues on that pull request. 

![](/assets/blog/snowflake-connector/two-developers.jpg)

Maintainers are in a constant state of pulling triage on all the surplus of
innovation being thrown at them and simultaneously trying to look for more help
reviewing and being the expert at some areas of the code. This is why regular
[contributor meetings](https://github.com/trinodb/trino/wiki/Contributor-meetings)
help solve both of these issues synchronously to cut out the delayed feedback loops.

### History repeats itself, until it doesn't

It became apparent that each time there was 
[a discussion](https://github.com/trinodb/trino/pull/2551#issuecomment-709220790)
for how to do
[integration testing](https://github.com/trinodb/trino/pull/10387#issuecomment-1008430060)
there was no good way to test a Snowflake instance with the lack of funding for
the project. Trino has a high bar for quality and none of the maintainers felt
it was a risk worth taking due to the likely popularity of the integration and
likelihood of future maintenance issues. Once each pull request hit this same
fate, it stalled with no clear path to resolve the real issue of funding the
Snowflake infrastructure needed by the
[Trino Software Foundation (TSF)](https://trino.io/foundation.html). It’s never
fun to mention that you can’t move forward on work with constraints like these,
and without a monetary solution, silence is what is experienced on the side of
the contributor.

Noticing that Teng had already done a significant amount of work to contribute
his Snowflake connector, I reached out to him to see if we could brainstorm a
solution. Not long after that, Erik also reached out to get my thoughts on
how to go about contributing Bloomberg's Snowflake connector. Great, now we have
two connector implementations and no solution to getting the infrastructure to
get them tested. During the first
[Trino Contributor Congregation in 2022](https://trino.io/blog/2022/11/21/trino-summit-2022-recap.html#trino-contributor-congregation),
Erik and I brought up Bloomberg's desire to contribute a Snowflake connector and
I articulated the testing issue. Ironically, this was the first time I had
thoroughly articulated the issue to Erik as well.

As soon as I was done, Erik requested the mic and said something to the effect of,
"Oh, I wish I would have known that's the problem. The solution is simple.
Bloomberg will host the automated testing in our Snowflake account."

Done!

Just as in business, **you can never underestimate the power of communication in
an open source project** as well. Shortly after Erik, Teng, and I discussed the
best ways to merge their work, they set up the Snowflake accounts for Trino
maintainers and started the arduous process of building a thorough test suite
with the help of Yuya, 
[Piotr Findeisen](https://www.linkedin.com/in/piotrfindeisen/),
[Manfred Moser](https://www.linkedin.com/in/manfredmoser/),
and [Martin Traverso](https://www.linkedin.com/in/traversomartin/).

## The long road to Snowflake

As Teng and Erik merged their efforts, the process was anything but
straightforward. There were setbacks, vacations, meticulous reviews, and
infrastructure issues. But the perseverance of everyone involved was unwavering.

Bloomberg started by creating
[an official Bloomberg Trino repository](https://github.com/bloomberg/trino).
This was originally used as a means for Teng and Erik to collaborate and mesh 
their solutions together and to build the aforementioned testing
infrastructure. Without needing to rely on the main Trino project to merge
incremental solutions, they were able to quickly iterate the early solutions.
This repository now facilitates Bloomberg’s numerous contributions to Trino.

It took a few months just to get the 
ForePaaS<a name="fn1"></a><sup><a class="footnote" href="#fnref1">1</a></sup>
and Bloomberg solutions merged. There were valuable takes from each system and
better integration tests were written using the new testing infrastructure. The
two Snowflake connector implementations were merged together by April of 2023.
Finally, the reviews could start. Once the initial two passes happened, we
anticipated that we would see the Snowflake connector release in the summer of
2023 around Trino Fest. So much so that we planned
[a talk with Erik and Teng](https://trino.io/blog/2023/07/12/trino-fest-2023-let-it-snow-recap.html)
as an initial reveal, assuming the pull request would be merged by then. Lo and
behold, that didn’t happen, as there were still a lot of concerns around use
cases not having been properly tested.

### The halting review problem

A necessary evil that comes with pull request reviews and more broadly,
distributed consensus is that reviews can drag on over time. This can lead to
[countless number of updates](https://github.com/trinodb/trino/pull/17909#issuecomment-1841809727)
you have to make to your changes to accommodate the ever changing project
shifting beneath your feet as you simultaneously try to make progress on
[suggestions from those reviewing your code](https://github.com/trinodb/trino/pull/17909#pullrequestreview-1793724311).

![](/assets/blog/snowflake-connector/halting-review.jpg)

This is why I believe open source, while not beholden to any timelines, needs a
project and product management role which is currently covered often by
project leaders and devex engineers. This can also relieve tension between the
needs of open source and big businesses in the community with real deadlines, at
least keeping the communication consistent while ensuring bugs and design flaws
aren’t introduced to the code base.

## What’s in it for Bloomberg and ForePaaS?

If you’ve never worked in open source or for a company that contributes to open
source, you may be thinking "how the heck do these engineers convince their
leadership to let them dump so much time into these contributions?" The simple
answer is, it’s good for business.

This addressed the previous drawback of Bloomberg and ForePaaS engineers having
to maintain their own Trino forks. Each time they wanted to upgrade to a new
Trino version, then needed to adapt all their own code to changes in the
upstream code. This positive-sum outcome is why it makes great business sense
which enabled Erik and Teng to combine their battle-tested connectors, crafting
a high value creation for the community.

You can use these points to convince leadership to get on board. Showing how
companies like Bloomberg get involved in open source and benefit. Presenting
economic incentives that lower the amortized cost to your company can be
a very persuasive strategy if you want to get involved in Trino.

This journey has been about collaboration, learning, and growth that will benefit
many. I remember the night I got the email that Yuya had 
[merged the pull request](https://github.com/trinodb/trino/pull/17909), I was
ecstatic to say the least. The connector shipped with
[Trino version 440](https://trino.io/docs/current/release/release-440.html#general), 
and made connection to the most widely adopted cloud warehouse possible.

Once the hard work was done, many valuable iterations like 
[adding Top-N support](https://github.com/trinodb/trino/pull/21219) (Shoppee),
[adding Snowflake Iceberg REST catalog support](https://github.com/trinodb/trino/pull/21365)
(Starburst), and [adding better type 
mapping](https://github.com/trinodb/trino/pull/21365) (Apple) were added to the
Snowflake integration. I love showcasing this trailblazing, and yes, altruistic
work from Erik, Teng, Yuya, Martin, Manfred, and Piotr - and everyone who
helped in the Trino community. A special thanks to the managers and
leadership at Bloomberg and ForePaaS for their generous commitment of time
and resources to the Trino community.

As we celebrate this milestone, we're already looking forward to the next
adventure. Here's to federating them all, together!

Notes:
<a name="fnref1"></a><sup><a class="footnote-ref" href="#fn1">1</a></sup>
<span class="footnote-ref-text">ForePaaS has been integrated into [OVHCloud](https://ovhcloud.com), which is renamed as [Data Platform](https://help.ovhcloud.com/csm/en-public-cloud-data-platform-what-is?id=kb_article_view&sysparm_article=KB0060801).</span>

_bits_
