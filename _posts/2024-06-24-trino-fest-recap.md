---
layout: post
title: "Trino Fest 2024 recap"
author: "Manfred Moser, Cole Bowden, Monica Miller"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2024/trino-fest-talk.jpg
---

Trino Fest 2024 is successfully in the books! While over 100 enthusiastic
members of the community gathered in Boston, over 650 virtual attendees joined
us worldwide to learn from our expert speakers as they discussed topics such as
table formats, enhancements and optimizations, and use cases with Trino both
large and small. And now it is your chance to revisit the presentations or catch
up on everything you missed.

<!--more-->

## Impressions

Judging from early results from attendee and speaker feedback, everyone enjoyed
the event. Asked about what sessions the audience liked we got answers like

* *They were all very insightful.*
* *All of it, but especially the realtime demos to see speed difference on query
  optimization.*
* and *All of them, nothing was missed!*

Just like some attendees, our speakers travelled from Europe, Asia, and other
places, and enjoyed the event.

* *Thanks for organizing the awesome event and inviting me for the talk!*
* *Was great to finally meet you and we had a great time at Trino Fest!*
* *Thanks for a great event last week. It was a pleasure to meet you all.*

Many of us also [met Commander Bun Bun](https://www.linkedin.com/posts/k-shreya-s_trinofest2024-bigdata-analytics-activity-7209236269774585857-p8-e?utm_source=share&utm_medium=member_desktop),
and [we sent greetings to the remote audience as
well](https://www.youtube.com/watch?v=4jPYpU9Jrrw).

<img src="{{site.url}}/assets/blog/trino-fest-2024/cbb-manfred.jpg">

The keynote, the sessions, and all the talk in the hallways confirmed that Trino
continues to thrive and expand in usage. Large companies like [Apple, Microsoft,
LinkedIn, Amazon, and many other users]({{site.url}}/users.html) openly talk
about shipping Trino as part of their products and using it for internal usage
as well. Smaller companies either run Trino themselves or take advantage of
Trino-based products for all their data platform needs. Our sessions for Trino
Fest offered something to learn for everyone.

<img src="{{site.url}}/assets/blog/trino-fest-2024/hallway-chat.png">

## Sponsors

Bringing together the event was only possible thanks to the great Trino events
team around [Anna Schibli](https://www.linkedin.com/in/anna-schibli-418692172/)
at our main sponsor Starburst, and the assistance from all our other sponsors. A
heartfelt thank you from Commander Bun Bun and all of us go out to you!

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

## Sessions

Now, following is what you are really looking for. All the talks, speakers,
short recaps, slide decks, video recordings, and following Q&A sessions, ready
for you. Enjoy!

**What’s new in Trino this summer**
<br>Presented by Martin Traverso from
[Starburst](https://www.starburst.io){:target="_blank"}

Martin recapped everything that's happened in Trino over the last six months,
taking a look at the biggest new features and how Trino development is going
better than ever. He also gave a sneak peek at what we can expect soon in Trino.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=mk3n0_tAdZY){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/keynote.pdf){:target="_blank"}

---

**Reducing query cost and query runtimes of Trino powered analytics platforms**
<br>Presented by Jonas Irgens Kylling from
[Dune](https://dune.com/){:target="_blank"}.

Jonas gave a detailed talk about how Dune has improved their performance of
Trino with a few key tweaks. That includes leveraging caching with Alluxio,
advanced cluster management, and storing, sampling, and filtering query results.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=11yhPXIXiBY){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/dune.pdf)

---

**Enhancing Trino's query performance and data management with Hudi: innovations and future**
<br>Presented by Ethan Guo from
[Onehouse](https://www.onehouse.ai/){:target="_blank"}.

Ethan gave a look into development on Hudi and Trino's Hudi connector,
explaining multi-modal indexing and how it can improve query performance. He
also gave an overview of the roadmap and future of the connector.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=JMzS2BbeK0E){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/onehouse.pdf)

---

**Trino Engineering @ Microsoft**
<br>Presented by George Fisher and Ishan Patwa from
[Microsoft](https://www.microsoft.com/){:target="_blank"}.

George and Ishan gave a deep dive into what's been going on with Microsoft's
deployment and management of Trino. This included clients and integrations,
result caching, a sharded SQL connector, deep debugging and monitoring, and
seamless security integration with Azure.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=t7ndqYUhKSA){:target="_blank"}

---

**Enhancing data governance in Trino with the OpenLineage integration**
<br>Presented by Alok Kumar Prusty from
[Apple](https://www.apple.com/){:target="_blank"}.

Alok's lightning talk is all about how Apple deployed OpenLineage, an open
framework for data lineage collection and analysis, and built a Trino plugin to
publish OpenLineage complaint events that can be viewed and monitored.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=A7hj1M7IYj8){:target="_blank"}

---

**Best practices and insights when migrating to Apache Iceberg for data engineers**
<br>Presented by Amit Gilad from
[Cloudinary](https://cloudinary.com/){:target="_blank"}.

Amit shared how Cloudinary expanded their data lake to use Apache Iceberg. He
demonstrated how moving from Snowflake to an open table format allowed them to
reduce storage costs and leverage different query and processing engines to run
more powerful analytics at scale.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=dKQ2zShNlyQ){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/cloudinary.pdf)

---

**Trino query intelligence: insights, recommendations, and predictions**
<br>Presented by Marton Bod from [Apple](https://www.apple.com/){:target="_blank"}.

Marton's lightning talk explored how Apple has monitored and stored metadata for
every Trino query execution, then used that data for for real-time cluster
dashboarding, self-service troubleshooting, and automatic generation of
recommendations for users.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=K3iSXOJNaSQ){:target="_blank"}

---

**The open source journey of the Trino Delta Lake Connector**
<br>Presented by Marius Grama from
[Starburst](https://www.starburst.io){:target="_blank"}.

Marius went into a deep dive on all the work and collaboration that's gone into
making the Delta Lake connector in Trino a robust, first-class connector. Casual
discussions, engineers working together, GitHub issues filed by the community,
and innovative contributions have all come together, and Marius' talk shows why
an open source community is so powerful.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=mPfRYdvDcMo){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/delta-lake.pdf)

---

**Tiny Trino; new perspectives in small data**
<br>Presented by Ben Jeter and Thomas Zugibe from
[Executive Homes](https://www.executivehomes.com/){:target="_blank"}.

Ben and Tommy explore how Executive Homes uses Trino's robust suite of
integrations to handle data at a small scale. Instead of petabytes, how about a
handful of gigabytes in several different systems? It's something that Trino is
well-equipped to handle thanks to how well-supported it is in the data
ecosystem, and they explain why.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=ZcY9LJDdB6Y){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/executive-homes.pdf)

---

**Bridging the divide: running Trino SQL on a vector data lake powered by Lance**
<br>Presented by Lei Xu from [LanceDB](https://lancedb.com/){:target="_blank"}
and Noah Shpak from [Character.ai](https://character.ai/){:target="_blank"}.

Lei and Noah give an overview of LanceDB, how it works, and what makes it a
great database for multimodal AI. Then they dive into a Trino connector for
Lance, and explore how Trino slots into Character.AI's workload to blend
analytics with training and generating new models.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=jmOsVbGfon0){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/lance-characterai.pdf)

---

**How FourKites runs a scalable and cost-effective log analytics solution to
handle petabytes of logs**
<br>Presented by Arpit Garg from
[FourKites](https://www.fourkites.com/){:target="_blank"}.

With nearly a petabyte of logs being managed at FourKites, it shouldn't be a
huge surprise that they've turned to Trino to handle understanding and analyzing
them. Arpit discusses how they've scaled log ingestion, strategically used S3
with Parquet to minimize storage costs, transformed and extracted those logs at
scale, and leveraged Trino to search and explore the datasets with Superset as a
frontend for visualization.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=xdCZBQJt-0g){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/fourkites.pdf)

---

**Observing Trino**
<br>Presented by Matt Stephenson from
[Starburst](https://www.starburst.io){:target="_blank"}.

Starburst has built a comprehensive observability platform around Trino to
better serve its users and customers. Matt explored all the components of it,
including how to integrate with Jaeger, Prometheus, and ELK.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=v7p72Ggcc5I){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/observing-trino.pdf)

---

**Accelerate Performance at Scale: Best Practices for Trino with Amazon S3**
<br>Presented by Dai Ozaki from [AWS](https://aws.amazon.com/){:target="_blank"}.

Dai's talk explores best practices to get the most out of using Trino in
conjunction with Amazon S3. He discusses partitioning, scaling workloads,
reducing latency, and resolving common bottlenecks, providing valuable insights
for anyone trying to manage and deploy Trino with S3.
<br><i class="fab fa-youtube" style="color: red;"></i> [Video recording](https://www.youtube.com/watch?v=cjUUcHlUKxQ){:target="_blank"}
| [Slides]({{site.url}}/assets/blog/trino-fest-2024/aws-s3.pdf)

## What's next

While you are busy catching up, we are still working hard on a recap of the
Trino Contributor Congregation. We also had a lot of great conversations that
lead us to follow up action items such as more pull requests to review, new
contributors to onboard, and more projects to work on.

Make sure you to [join the community on Slack]({{site.url}}/slack.html) to learn
more in the next little while.

Oh, and one last thing...

<div class="card-deck spacer-30">
    <a class="btn btn-orange" href="https://www.starburst.io/info/trino-summit-2024/?utm_medium=trino&utm_source=website&utm_campaign=NORAM-FY25-Q4-CM-Trino-Summit-2024-IMC-Upgrade&utm_content=Trino-Fest-Blog-Recap">
        Trino Summit 2024 registration is open
    </a>
</div>
<div class="spacer-30"></div>

See you soon,

*Manfred, Cole, and Monica*