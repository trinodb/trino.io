---
layout: post
title: "Big names round out the Trino Fest 2024 lineup"
author: "Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2024/announcement-banner.png
show_pagenav: false
---

We gave
[a sneak peek of the Trino Fest lineup a month ago]({{site.baseurl}}{% post_url 2024-04-15-trino-fest-2024-approaches %}),
and we're excited to now bring you the full lineup for the event. We've got some
major names being added, including Amazon, Microsoft, and another talk from
Apple. With Fourkites and a joint talk with LanceDB and CharacterAI also added
to the schedule, we're excited to present the
[full lineup for Trino Fest 2024](https://www.starburst.io/info/trino-fest-2024/#agenda).

Trino Fest is barely a month away on the 13th of June, and whether you want to
attend live in Boston or tune in virtually, this is a reminder that you
should [register to attend!](http://www.starburst.io/info/trino-fest-2024?utm_medium=trino&utm_source=website&utm_campaign=Global-FY25-Q2-EV-Trino-Fest-2024&utm_content=Blog-3)

<!--more-->

## Trino Fest, the contributor congregation, and logistics

In case you missed
[our announcement of Trino Fest]({{site.baseurl}}{% post_url 2024-02-20-announcing-trino-fest-2024 %}),
it's a hybrid event taking place from 9am-5pm Eastern Time on June 13th. It'll
feature talks from a wide range of Trino users and contributors, with topics
ranging from use cases, migrations, cluster management and administration,
to lakehouse integrations and more. If you want to join us in-person, we'll be at
the Hyatt Regency Boston. There will also be a meeting for Trino contributors
the day after the event at the Starburst office in Boston from 9am-1pm, and if
you'd be interested in attending that, please reach out to myself (Cole Bowden)
or Manfred Moser on the [Trino Slack]({{site.url}}/slack.html).

If you still haven't booked a hotel, we also have a discounted rate at the Hyatt
for the event to make life easy - whether that's waking up and heading
downstairs for the start of the event, or being able to quickly duck back to
your room for a 30-minute meeting without missing too much. One link will take
you to a booking for just the night before the event, while the other allows
you to optionally book an extra night prior or include the night after Trino
Fest so you can stick around for the contributor congregation or explore Boston.

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="https://www.hyatt.com/en-US/group-booking/BOSTO/G-STA4">
        Book your hotel for June 12-13
    </a>
    <a class="btn btn-pink" href="https://www.hyatt.com/en-US/group-booking/BOSTO/G-STA3">
        Book your hotel for June 11-14
    </a>
</div>
<div class="spacer-30"></div>

## And don't forget those additional speakers

George Fisher, Ishan Patwa, and Oleg Savin will be diving deep into how Trino is
leveraged at Microsoft. While we've previously had LinkedIn at Trino events,
this is the first time the Trino community is getting to hear about the scale of
Trino within Microsoft proper, and with their plans to cover clients,
integrations, result caching, a sharded connector, visualization for monitoring,
and AKS deployment with Azure, there will be a lot to learn.

Alok Kumar Prusty and Amogh Margoor from Apple will be joining the lineup to
discuss Trino query intelligence. With the mountain of query metadata, the team
at Apple has been able to better understand Trino usage and use that knowledge
to create impactful improvements for their Trino users. With dashboarding,
self-service troubleshooting, and automatic recommendations for query
optimization, Alok and Amogh will detail how a world-class engineering team can
take an awesome tool like Trino and make it even better for the end users.

Also relatively new to the Trino community is discussing AI workloads. Lei Xu
from [LanceDB](https://lancedb.com/) and Noah Shpak from
[character.ai](https://character.ai/) will be highlighting exactly that,
using Trino as an analytics engine on top of a LanceDB-powered vector data lake.
With AI data so often being in a silo, analyzing it with a traditional SQL
workload is often expensive or complicated... but Lei and Noah will be
demonstrating how character.ai's LanceDB/Trino pairing maintains the power of
both systems while making it easy.

Dai Ozaki from Amazon will be diving into how to optimize Trino with S3. Given
how many people are using Trino with S3 already, hearing directly from Dai, an
engineer at Amazon, regarding best practices and optimizations should prove
beneficial for a massive chunk of the Trino community. Dai plans on talking
about how Trino and S3 interact, and how that knowledge can be used to get the
most out of your stack and avoid common bottlenecks.

And last but not least, Aprit Garg from [FourKites](https://www.fourkites.com/)
will be discussing utilizing Trino to handle nearly a petabyte of logs.
FourKites is able to ingest massive amounts of logs, use S3 and
Parquet to keep storage costs low, transform and extract logs at scale, and then
use Trino as the engine to query those logs and reference them in context with
other data sets and data stores. Arpit will also touch on using Superset as a
frontend for Trino.

And keep in mind - all of that is in addition to the talks we've already
announced!
[Register to attend](http://www.starburst.io/info/trino-fest-2024?utm_medium=trino&utm_source=website&utm_campaign=Global-FY25-Q2-EV-Trino-Fest-2024&utm_content=Blog-3),
[book your hotel](https://www.hyatt.com/en-US/group-booking/BOSTO/G-STA3), and
the Trino community is looking forward to seeing you there!

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
    <div class="col-sm">
      <a href="https://www.startree.ai/" target="_blank">
        <img src="{{site.url}}/assets/images/logos/startree-small.png" title="Startree, event sponsor">
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
