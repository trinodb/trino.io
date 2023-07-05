---
layout: post
title: "Trino Fest 2023 recap"
author: "Manfred Moser, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/trino-fest.png
---

Last week we held Trino Fest, and it kept us all so busy, we forgot to spend
time chilling by the lakehouse! Great demos, amazing announcements, new plugins,
and use cases reached our active audience. Thanks go to our event host and
organizer [Starburst](https://www.starburst.io/), to our sponsors
[AWS](https://aws.amazon.com/) and [Alluxio](https://www.alluxio.io/), to our
many well-prepared speakers, and to our great live audience. Now you get a
chance to catch up on anything you missed.

<!--more-->

<div class="container">
  <div class="row">
    <div class="col-sm">
      <a href="https://www.starburst.io/">
        <img src="{{site.url}}/assets/images/logos/starburst-small.png" title=" Starburst, event host and organizer ">
      </a>
    </div>
    <div class="col-sm">
      <a href="https://www.alluxio.io/">
        <img src="{{site.url}}/assets/images/logos/alluxio-small.png" title="Alluxio, event sponsor">
      </a>
    </div>
    <div class="col-sm">
      <a href="https://aws.amazon.com/">
        <img src="{{site.url}}/assets/images/logos/aws-small.png" title="AWS, event sponsor">
      </a>
    </div>
  </div>
</div>

In the weeks leading up to the event, we published numerous blog posts, and
racked up great interest in the Trino community and beyond. Over 1100
registrations blew away our numbers from last year. More importantly, during the
two half-days of the event, we had over 560 attendees watching live and
participating in the busy chat.

## Sessions

If you could not attend every session, or if you missed out on attending
completely, then we've got great news for you! You still  have a chance to learn
from the presentations and the experience and knowledge of our speakers.

* [Trino for lakehouses, data oceans, and beyond]({% post_url 2023-06-22-trino-fest-2023-keynote-recap %})
  presented by Martin Traverso, co-creator of Trino and CTO at
  [Starburst](https://www.starburst.io/).
* [Anomaly detection for Salesforce’s production data using
  Trino]({% post_url 2023-06-26-trino-fest-2023-salesforce %}) presented by Geeta Shankar and Tuli Nivas
  from [Salesforce](https://www.salesforce.com/).
* [Zero-cost reporting]({% post_url 2023-06-28-trino-fest-2023-starburst-recap
  %}) presented by Jan Waś from
  [Starburst](https://www.starburst.io/).
* [CDC patterns in Apache Iceberg]({% post_url 2023-06-30-trino-fest-2023-apacheiceberg
  %}) presented by Ryan
  Blue from [Tabular](https://tabular.io/).
* [Ibis: Because SQL is everywhere and so is Python]({% post_url 2023-07-03-trino-fest-2023-ibis%})
  presented by Phillip Cloud from [Voltron Data](https://voltrondata.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>AWS Athena
  (Trino) in the cybersecurity space](https://youtu.be/WCuJaW7zC8k) presented by
  Anas Shakra from [Artic Wolf](https://arcticwolf.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Skip rocks
  and files: Turbocharge Trino queries with Hudi’s multi-modal indexing
  subsystem](https://youtu.be/IiDOmAEOXUM) presented by Nadine Farah and  Sagar
  Sumit from [OneHouse](https://www.onehouse.ai/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Redis &
  Trino - Real-time indexed SQL queries (new
  connector)](https://youtu.be/JjBtZ26IHYk) presented by Allen Terleto and
  Julien Ruaux from [Redis](https://redis.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Let it SNOW
  for Trino](https://youtu.be/kmpO_yM8OAs) presented by Erik Anderson from
  [Bloomberg](https://www.bloomberg.com/company/values/tech-at-bloomberg/open-source/projects/)
  and Yu Teng from [ForePaaS](https://www.forepaas.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>DuneSQL, a
  query engine for blockchain data](https://youtu.be/sCJncarnGdU) presented by
  Miguel Filipe and Jonas Irgens Kylling from [Dune](https://dune.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Data Mesh
  implementation using Hive views](https://youtu.be/ZgcVtPFkKHM) presented by
  Alejandro Rojas from [Comcast](https://comcast.github.io/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Inspecting
  Trino on ice](https://youtu.be/PSGuAMVc6-w) presented by Kevin Liu from
  [Stripe](https://stripe.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Trino
  optimization with distributed caching on Data
  Lake](https://youtu.be/oK1A5U1WzFc) presented by Hope Wang and Beinan Wang
  from [Alluxio](https://www.alluxio.io/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>Starburst
  Galaxy: A romance of many architectures](https://youtu.be/K3AlAWB-Gmg)
  presented by Benjamin Jeter from [Datto](https://www.datto.com/).
* [<i class="fab fa-youtube" style="color:red;padding-right:0.5em;"/>FugueSQL,
  Interoperable Python and Trino for interactive
  workloads](https://youtu.be/aKhI1Phfn-o) presented by [Kevin
  Kho](https://www.linkedin.com/in/kvnkho/).

## Next up

This first recap is sharing all the video recordings with you all if you can't
wait. But stay tuned, because we'll also be publishing individual blog posts and
recaps for each session, and they'll include additional useful info:

* Summary of the main lessons and takeaways from the session
* Slide decks for you to browse on your own
* Interesting and fun quotes from the speakers and audience
* Notes and impressions from the audience and event hosts
* Questions and answer during the event
* Links to further documentation, tutorials, and other resources

We'll be rolling out recap posts for a few talks each week, so keep an eye out
on our [community chat]({{site.url}}/slack.html) or the website for updates.

At the same time, we are already marching ahead and planning towards our next
major event in autumn. Trino Summit 2023 - here we come!
