---
layout: post
title: "Why leaving Facebook/Meta was the best thing we could do for the Trino Community"
author: "Martin Traverso, Dain Sundstrom, and David Phillips"
excerpt_separator: <!--more-->
---

It might surprise some that our departure from Facebook was one of the simplest 
decisions we’ve ever made. Many posts that discuss leaving a FAANG company focus
on leaving some grand sum of money or prestige of working at the company. For 
us, we were leaving the company where we had launched a project that we knew 
would quickly outgrow the walls of Facebook, and solve a much larger set of 
problems in the analytics domain. At the time we didn’t quite anticipate that 
Presto, a distributed SQL query engine for big data analytics, would be adopted 
around the globe by thousands of companies and an overwhelming number of 
industries. We appreciate Facebook for serving as the launchpad that inspired 
others to adopt Presto. Despite the harmonious beginnings, once the needs of the
community and Facebook no longer aligned, we had to leave, but we’ll get to that
part shortly.

<!--more-->

![](/assets/blog/leaving-facebook-meta-best-for-trino/original-gang.png)

## People make up communities, not companies

When we created Presto, it was clear to us that it needed to be open source.
Presto started in 2012, just before the Facebook IPO. The culture was very
conducive to starting an open source project. At that time, Facebook was working
on Open Compute which ended up disrupting the hardware industry, and we wanted
to achieve a similar impact for the analytics industry with Presto. We lobbied for and
gained approval from the VP of Infrastructure, Jay Parikh, and released 
[Presto as an open source project](https://web.archive.org/web/20220203224702/https://www.computerworld.com/article/2485668/facebook-goes-open-source-with-query-engine-for-big-data.html). It’s something that we wanted to
do from the beginning, because we had worked with open source projects and 
believed that the most successful projects are open source.

Getting other people and companies involved makes for a healthier project. You
end up not just building something that satisfies your needs, but needs from
everyone else, and in turn, you benefit. We reached out personally to
people from companies like Airbnb, Dropbox, Netflix, and LinkedIn to get them
involved because we wanted to bootstrap a real community. Five people at
Facebook hacking away was not enough. We actually had these companies beta test
Presto, so that when we launched, the problems that they had found were fixed.

It’s important to understand why that’s beneficial to really grasp our
philosophy behind open source. In reality, when we say we’re getting more
companies involved, that’s true, but more importantly, we’re getting people
involved. Individuals in the tech space are interested in solving technology
problems. Companies are interested in solving problems that benefit their board,
investors, and their customers. It’s incredibly common to see an overlap in the
problems that engineers, analysts, and scientists are interested in solving with
the problems that companies need to solve, but it’s never guaranteed.

Moreover, the interest of a company is very susceptible to change from company
growth, IPOs, acquisitions, directional pivots, and general political and
cultural changes. As people start to put their time and energy into a project,
their own identity starts to blend with the success of the project. This is much
less the case with corporations. Since corporations include many people, it
only takes a small set of people in the right position to decide that a project
is no longer aligned with the direction or goals of a company.

Those of us in the Trino Software Foundation believe that 
[individuals that work on Trino actually make up the community](https://venturebeat.com/2021/08/27/who-owns-open-source-projects-people-or-companies/) and not the companies who so graciously allow their employees to
contribute. We view our community as visionaries that want to solve problems and
build systems that last for decades into the future. We don’t allow near-sighted
decisions that may affect the quality of the system, or that may diminish the
value of the application to the greater problem space. Most people do not want
to work on something for years, and then have the company change direction and
throw away all their work.

To be clear, we’re not saying it’s a bad thing when a company moves in another
direction. That is the nature of business and having corporate involvement can
also be a healthy component of open source. To us, however, the core of what
makes a project long-lasting and beneficial for everyone using the product are
the people who are there building the system and interested in the problem
space. So what happened at Facebook that caused us to leave?

## Why we left Facebook

As Presto became central to the infrastructure of prominent projects in Facebook,
it attracted the attention of engineers and managers at Facebook who wanted to 
work on this project. This is a strong sign of success, but some of these folks
did not have the same commitment to the open-source community. This was the
source of much of the conflict as engaging in open-source takes a lot of time
and effort, and we had a strict policy of "no one is special". This means that
everyone's code is reviewed, and just because you work for Facebook you still
have to earn commit rights. Engineers at Facebook are strongly motivated to
create "memorable" works to advance in the company, and this means this extra
work is just slowing things down. Feedback from these engineers ultimately
culminated in the managers making the decision to give automatic contributor
rights to any Facebook engineer working on Presto, so that these engineers could
move faster.

You may think Facebook engineers or managers are the big bad wolf in this
scenario, but they really are not. Engineers at these highly competitive
companies must create memorable work, or they will not get the promotions they
deserve. And if you are a junior engineer and do not get promoted, you get
fired. Corporate leaders also have the right to change how they allocate
resources to work on open-source projects. There’s nothing inherently wrong with
any of this. The problem was changing the commitment we made to keep the
open-source community neutral. It was at that point we knew that we had to
create a fork of the project if we wanted to keep the community's interest at
the forefront for the project to remain healthy.

It was also at this point we made our single biggest mistake. We didn’t change
the name away from Presto. It was admittedly hard to walk away from a name we
all knew and loved. We believed that we had set up the project, so that the name
"Presto" was owned by the community and not Facebook. The truth is that once the
community walked out of the project, Facebook was the only one left in Presto
and they became the sole owner. But, the biggest reason this was absolutely the
wrong choice is much simpler; it made the people that stayed at Facebook really
angry. We expected Facebook to do what they really wanted: stop doing the extra
open-source work, fork internally, and leave the community alone. Instead, they
somehow found the motivation to do a lot of work to set up a competing project.
Finally, we spent two additional years continuing to build the Presto name
rather than building the new name and brand. In hindsight, all of this was just
dumb, and we were suffering from our own sunk cost fallacy. So we continued
under the Presto name with the distinguishing suffix of PrestoSQL versus the
original project’s PrestoDB.

## Building the Trino community

The new PrestoSQL project gave a new home to the existing Presto community. It
provided a project that focused on the open source community and not just the
needs of Facebook. It also gave us time to troubleshoot problems of people who
used Presto. This is what we were doing internally at Facebook but instead we
applied our knowledge of the system towards the community. This was one of the
reasons why leaving Facebook was so beneficial. As we worked closer with
everyone else, we started learning what areas of the project we should focus on
and it turns out that many of the things we were working on at Facebook were
simply not problems that all the other people in the community were facing. This
wasn’t the only benefit to us leaving Facebook, though.

The hardest part about making a new project successful is user adoption. 
Building great software doesn’t organically build a community. Presto gained 
some of its initial popularity because Facebook used it. We never had to try 
very hard to develop the community initially as the Facebook brand did a great 
job at getting people’s attention. But this community was exclusive to Silicon 
Valley companies. Leaving Facebook acted as a forcing function for us to build 
the community in a classic grassroots way. We went out and started talking to 
people, getting people connected, doing more promotions and events. We were 
pretty motivated after we left. However, all of this is a lot of work for a few 
programmers and while it’s great to see people respond to your work, it takes a
lot out of you. This provided the conditions that gave rise for members to step
up in the new project and become more involved.

We saw the pattern repeat when
[we were forced to rebrand and changed the name to Trino]({% post_url 2020-12-27-announcing-trino %}).
We doubled down again on developing the community, and again participation
accelerated. It’s because of this that we believe the Trino community is stronger
than ever before.

![](/assets/blog/leaving-facebook-meta-best-for-trino/stars.jpeg)

Since the split, Trino release cycles have increased and far surpassed the speed
we had when we were running Presto. Once brand confusion was settled with the
change to the Trino name, the community numbers skyrocketed and we saw 
[unprecedented growth in metrics like GitHub stars, YouTube subscribers, and Slack members]({% post_url 2021-12-31-trino-2021-a-year-of-growth %}). 
We have many new community-driven features released in Trino that we will be
discussing in more detail in another blog post coming soon. To name a few, Trino now 
[supports fault-tolerant execution mode]({% post_url 2022-05-05-tardigrade-launch %}),
[revamped its timestamp support](https://github.com/trinodb/trino/issues/37), 
[dynamic partition pruning]({% post_url 2020-06-14-dynamic-partition-pruning %}),
[polymorphic table functions]({% post_url 2022-07-22-polymorphic-table-functions %}),
[advanced window functions]({% post_url 2021-03-10-introducing-new-window-features %}), 
and much much more!

![](/assets/blog/leaving-facebook-meta-best-for-trino/trajectory.png)

## Conclusion

These metrics help confirm our experience in previous open source projects and
with Trino. In the long run, individual-driven open source projects tend to lead
to healthier communities and healthier ecosystems over company-driven open
source projects. We believe that, we practice that, and we are now reaping the
benefits of it as we close the pages of the first decade of this remarkable
project. We can’t begin to express how thankful we are to all of you who
believed in us and have helped grow Trino to what it is today. Also, we do
thank the Facebook leadership, especially Jay Parikh, who gave us the green
light to create and open source Presto from the beginning. We are looking
forward to the twentieth and thirtieth anniversaries as we continue to disrupt
the analytics industry and improve the lives of those who work in it.