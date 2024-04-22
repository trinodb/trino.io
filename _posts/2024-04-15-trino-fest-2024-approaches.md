---
layout: post
title: "A sneak peek of Trino Fest 2024"
author: "Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2024/announcement-banner.png
show_pagenav: true
---

Trino Fest is drawing ever closer. Commander Bun Bun has been hard at work
behind the scenes arranging the schedule and making sure that Trino's trip to
Boston is going to be a great one. In case you missed it,
[we announced Trino Fest]({{site.baseurl}}{% post_url 2024-02-20-announcing-trino-fest-2024 %})
a couple months ago, and if you *have* missed it, make sure to go register to
attend! All our speakers will be in person in downtown Boston on the 13th of
June, with plenty of opportunities for networking and a happy hour event at the
end of the day. But if you can't make the trip to enjoy the lovely New England
summer, we'll also be live-streaming the event, and you can register to join us
virtually.

<div class="card-deck spacer-30">
    <a class="btn btn-orange" href="http://www.starburst.io/info/trino-fest-2024?utm_medium=trino&utm_source=website&utm_campaign=Global-FY25-Q2-EV-Trino-Fest-2024&utm_content=Blog-2">
        Register to attend!
    </a>
</div>
<div class="spacer-30"></div>

Still on the fence, though? Read on for a preview of our speaker lineup and
brief summaries of their talks. Keep in mind this also isn't the full lineup,
and we'll follow up soon with the last few talks that round out the schedule.

<!--more-->

## A brief word from our sponsors...

Thank you to our sponsors for making this event happen...

<div class="container">
  <div class="row">
    <div class="col-sm">
      <a href="https://www.starburst.io/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/starburst-small.png" title="Starburst, event host and organizer">
      </a>
    </div>
    <div class="col-sm">
      <a href="https://www.onehouse.ai/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/onehouse-small.png" title="Onehouse, event sponsor">
      </a>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <a href="https://www.alluxio.io/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/alluxio-small.png" title="Alluxio, event sponsor">
      </a>
    </div>
    <div class="col-sm">
      <a href="https://cloudinary.com/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/cloudinary-small.png" title="Cloudinary, event sponsor">
      </a>
    </div>
    <div class="col-sm">
      <a href="https://www.upsolver.com/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/upsolver-small.png" title="Upsolver, event sponsor">
      </a>
    </div>
  </div>
</div>

And now onto what you're waiting for: a preview of most of the talks coming to
Trino Fest this year!

## Lakehouses

It's no secret that using Trino as part of your lakehouse has become one of its
major use cases in the past few years. We're excited to say that at Trino Fest,
we'll have representation for each of the modern big three table formats:
Iceberg, Delta Lake, and Hudi.

### Iceberg

[Apache Iceberg](https://iceberg.apache.org/) will be covered twice: Amogh
Jahagirdar from [Tabular](https://tabular.io/) will be diving into the world of
Iceberg views and how they can be leveraged to coordinate across different query
languages and dialects. Amit Gilad from [Cloudinary](https://cloudinary.com/)
will be covering the story of migrating out of Snowflake to the wonderful world
of open table formats and Iceberg.

### Delta Lake

Marius Grama, a Trino contributor at [Starburst](https://www.starburst.io/),
will be going into detail on the history, development, and improvements to the
[Delta Lake](https://delta.io/) connector. With
[time travel for the Delta Lake connector]({{site.baseurl}}{% post_url 2024-04-11-time-travel-delta-lake %})
landing in Trino 445, it's one of the most exciting areas for development in
open source Trino, and there's some interesting stories that Marius is excited
to share with the community.

### Hudi

Rounding out data lakes, Ethan Guo from [Onehouse](https://www.onehouse.ai/)
will be diving into Trino's [Hudi](https://hudi.apache.org/) connector, giving
an update on what's landed lately to improve performance and functionality.
He'll also give a preview of what's coming soon. The features are flying in, and
if you're a current or prospective user of Hudi with Trino, you won't want to
miss out.

## Data takes

Of course, there's more to Trino than querying data lakes, and there's a wide
variety of talks to discuss the other activities going on within the Trino
community.

### Small scale

Ben Jeter at [Executive Homes](https://www.executivehomes.com/), who gave
[a talk at Trino Fest last year]({{site.baseurl}}{% post_url 2023-07-25-trino-fest-2023-datto %})
while at [Datto](https://www.datto.com/), is back to discuss running Trino at a
more moderate scale than that we're used to hearing about in the Trino space.
Forget petabytes and exabytes, and welcome a tiny cluster querying thousands,
not millions, of records that still derives huge value from Trino. It's a great
playbook for smaller startups and enterprises who still need robust, flexible,
performant analytics.

### Maximizing performance

Jonas Kylling from [Dune](https://dune.com/about) will be detailing how they've
managed to optimize Trino and squeeze out every ounce of performance to reduce
query costs and runtimes. That includes leveraging the new Alluxio-based file
system caching, emulating various cluster sizes to avoid expensive idle cluster
time, and storing, sampling, and filtering query results to avoid re-executing
queries.

### Query intelligence

Marton Bod from Apple brings insights to query intelligence. He'll demonstrate
how Apple has understood when their clusters are most utilized and who's using
them, enabling slicing and dicing along different dimensions. Having a query
intelligence dataset can be used for real-time cluster dashboarding,
self-service troubleshooting, and automatic generation of recommendations for
users, all of which can empower Trino to be better than ever.

## And more!

Of course, Trino's own Martin Traverso will be giving a keynote on the latest
and greatest in the project, covering everything big that's landed since Trino
Summit, as well as a glimpse at the roadmap for the project in the coming few
months. Several other big talks are falling into place that we can't announce
just yet, so stay tuned for more info as the event draws nearer.

## Trino contributor congregation

The day after Trino Fest, we'll also be hosting an in-person meetup for
Trino contributors and engineers to catch up, discuss the Trino roadmap, and
engage directly with the maintainers in-person. It's a great opportunity to put
faces and voices to those GitHub handles, align on the big ideas or tricky PRs
that have been moving slowly, and find more ways to get involved in Trino
development. If you're interested in attending, message Manfred Moser or Cole
Bowden on the [Trino Slack]({{site.url}}/slack.html), and we'll get you added to
the attendee list and share more details.