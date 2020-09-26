---
layout: post
title:  "Hello I'm Brian, Presto Developer Advocate"
author: Brian Olsen
excerpt_separator: <!--more-->
---

Hello, Presto nation!

My name is Brian, and I’m a new developer advocate working at Starburst. Let me 
give you a little background on how I got here, and cover how my role can help
the Presto community.

![](/assets/blog/developer-advocate/brian.jpg)

<!--more-->

My career in computation and databases started in the military. As luck would
have it, I worked on a big data team as my first job out of college! I was in a
Hive shop that dealt with the typical outdated runtime and slow query
turnaround. Eventually, our architect introduced us to Presto as an alternative.
I worked with him to start testing and moving our existing use cases built on
Hive to use Presto. We also used Elasticsearch and had a few cases that needed
to perform joins and unions over the datasets in both Elasticsearch and Hive.
There were a few use cases that were not going to immediately be transferable
without some modification to the Presto Elasticsearch connector. 

## Joining the Presto community

The first modification was [adding support for Elasticsearch array 
types](https://github.com/prestosql/presto/issues/2441), and the second was, 
[support for nested types](https://github.com/prestosql/presto/issues/754). My 
first interaction with the Presto community was incredible! As a serial
open-source attempter, I always wanted to get invested in an open-source
project. I had started pull requests in various projects. Sometimes I ran into 
unpleasant maintainers, in other cases the rules were daunting or too confusing
to start. I created a pull request only to have it sit there with no
communication as to why it wasn't accepted or even looked at. However, when I
first joined [Slack](/slack.html), I searched to see if there was already a
discussion about array types in the history. I ran into [a discussion between 
Dain and Martin about this 
issue](https://prestosql.slack.com/archives/CP1MUNEUX/p1570064139005900). I
conversed with Martin, who was incredibly polite and willing to take time to 
discuss how this should be implemented. 

## Contributing

When I actually pulled the code, I saw how well written and maintained it was
compared to many open-source projects I had seen in the past. I made a few
changes, wrote a test around my use case, and signed a CLA agreement. After a
couple of weeks, my pull request was merged and I had finally contributed to an
open-source project. After that interaction, and seeing the code, I wanted to do
more. I really saw something special with this community.

While many Presto contributors are doing amazing work contributing code, I
noticed there were some holes in other areas of the community that needed to be
filled. I started answering questions on Slack, LinkedIn, and Twitter and I
planned out a Udemy course for Presto. The [initial 
video](https://youtu.be/RPaG0Gu2I6c) I piloted is about tuning the memory
configuration of Presto.
 
## Becoming a developer advocate

Around this time I got into contact with some folks at Starburst about joining 
them to work with the community and Presto full-time! As I joined, we hadn't
figured out what my exact role was at Starburst. Eventually, we decided I would
best serve as a developer advocate. What I've come to find is this role is 
aiming to do exactly what I set out to do before I joined. As a developer
advocate, I serve the community and act as a liaison between Starburst and the
Presto community. Up until this time, that responsibility has been unofficially
shared by many of the maintainers of Presto. I am here to simply take some of
that responsibility from them and focus all of my efforts on community growth
and health. 

The health of a community is difficult to define and is generally
subject to various signals that we can observe. These signals include an
increase in helpful interactions within the community, new members joining the
community, members who are actively engaging in the community, diversity of the
community, and more. If we start by focusing on making the community successful,
the success of the project will follow. Keeping the goal in mind that co-creator
David Phillips mentions:

> This is the type of project that we look at Postgres as the inspiration. 
> Postgres started in the eighties, it became a SQL system in the nineties, and
> it's still in active use and active development today. We say we want Presto
> to have the same kind of history. - David Phillips


## Next Steps

My first goal is to create a larger set of free learning materials, that expand
upon my initial goals when planning for my Udemy course. I recently started a
show with Manfred Moser called the Presto Community Broadcast. We stream live
every other Thursday on [Twitch](https://www.twitch.tv/prestosql). This show is
available on [Twitch](https://www.twitch.tv/prestosql), [Youtube
](https://www.youtube.com/playlist?list=PLFnr63che7war_NzC7CJQjFuUKLYC7nYh), and
as an [audio-only podcast](https://presto.buzzsprout.com/). We can reference any
relevant material we create on this show for future teaching or blogs. We want
these live sessions to be interactive, and look forward to your feedback to
understand if our efforts are actually helping, or if you have ideas to improve
the show. This show, along with blogs, documentation, and interactive tutorials
are how I initially intend to fill some common questions that are received
through our [Slack](/slack.html) and [Stack 
Overflow](https://stackoverflow.com/questions/tagged/presto) channels. Another
goal of adding these materials is to attract new members to the community. Not
all the material may be super relevant to the existing members of the community,
but this makes the community much more viable for newer members.
 
Outside of providing new learning materials, your feedback helps us to
understand common problems and allows us to fix them. This feedback will aid us
in focusing on issues commonly voiced within the community but somehow get lost
in translation. This could be improving the Presto code itself, or it could be
making the documentation better, or to address common confusion, even if the
confusion comes from a force outside of the Presto community. 

For instance, I recently [wrote a 
blog](https://bitsondata.dev/what-is-benchmarketing-and-why-is-it-bad/) about
some shady benchmarketing practices that were painting Presto in a bad light. 
The goal here was to make fun of the wildly bogus claims brought against Presto 
and the community. What better way to do that than to write a nerdy Justin
Bieber parody?

{% youtube FSy8V-R0_Zw %}

While I have hopefully convinced you all of my mission here. I can’t accomplish
any of this in a vacuum. The whole point of my work starts and ends with all of
you. I look forward to speaking with and one day post COVID-19, meeting you all
at meetups and conferences. For now virtual meetups and 
[Twitch](https://www.twitch.tv/prestosql) are a great start. If you have ideas
or want to reach out to introduce yourself, you can find me on 
[Slack](/slack.html) or [Twitter](https://twitter.com/bitsondatadev).
 
Thanks for reading this and being a part of this community. One last thing to
tell you about myself, I'm a sucker for cheesy sign-offs so...

_For fast data at resto, Presto is the besto!_
