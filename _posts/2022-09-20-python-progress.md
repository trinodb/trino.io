---
layout: post
title: "Trino charms Python"
author: "Manfred Moser, Brian Zhan, Dain Sundstrom"
excerpt_separator: <!--more-->
image: /assets/images/logos/python.png
survey_url: https://forms.gle/4bzMPZxby6E4xKm98
---

Wow, have we ever come a long way with Python support for Trino. It feels like
ages ago that we talked about DB-API, trino-python-client, SQLAlchemy, Apache
Superset, and more in [Trino Community Broadcast episode
12]({{site.url}}/episodes/12.html). More recently we talked about dbt in
[episode 21]({{site.url}}/episodes/21.html) and [episode
30]({{site.url}}/episodes/30.html), but there is so much more for Pythonistas,
Pythonians, Python programmers, and simply users of Python-powered tools.

<!--more-->

## Where are we now

Python usage shows up with nearly every Trino deployment these days, and we had
some really great developments for you all recent months:

* [Starburst](http://www.starburst.io) has really ramped up the contributions to
  the foundation of a lot of Python tools connecting to Trino. The
  [trino-python-client](https://github.com/trinodb/trino-python-client) receives
  improvements regularly and is definitely a first-class client at the same
  level as the JDBC driver or the CLI.
* [dbt Labs](https://www.getdbt.com/) and Starburst have worked hard on
  launching and improving the [dbt-trino
  project](https://github.com/starburstdata/dbt-trino) and enabling automated
  data transformation flows.
* [Apache Airflow](https://airflow.apache.org/) use cases are abound and the
  [integration is improving]({% post_url
  2022-07-13-how-to-use-airflow-to-schedule-trino-jobs %})
* [Apache Superset](https://superset.apache.org/) and
  [Preset](https://preset.io/) continue to add features and treat Trino as a
  major data source and integration, and we should probably have another Trino
  Community Broadcast episode to see that all in action.
* [Airbyte](https://airbyte.com/) was [demoed at Cinco de Trino]({% post_url
  2022-05-17-cinco-de-trino-recap %}) and is [widely used by companies such as
Lyft]({% post_url 2022-05-24-an-opinionated-guide-to-consolidating-our-data %}).

And of course there are well-known usages such as notebooks everywhere, on your
workstation, in your company, and out in the cloud. But is there more? There
must be!

## What else could we do

All of these developments are great for our users. I want to encourage you all
to try these tools and learn how amazing they are with Trino. At the same time
it feels like there got to be even more. The Python ecosystem is so large, and
there are probably dozens of use cases we never heard about, have not
considered, or dreamed about in our wildest dreams.

On the other hand I am sure there are still problems with these tools and
integrations. What is an edge case for us, might be a daily task for you. What
we consider hard and complicated, might be just what you have to deal with
anyway. And in the spirit of constant improvement, we really want to fix these
things and make it all amazing. But we need your help.

## Let us know what you think

This is now your opportunity to tell us what need to make your Trino and Python
experience better.

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="{{page.survey_url}}" target="_blank">
        Help Trino and Python
    </a>
</div>
<div class="spacer-30"></div>

## Conclusion

Trino, Python, and all the tools in the ecosystem go from strength to strength.
With your help we want to supercharge the tooling to hero levels. With your help
and input we can do it.

Join us in the `python-client` on [Trino slack]({{site.url}}/community.html),
and don't forget to [answer that survey]({{page.survey_url}}).

Thanks, and see you at the [Trino Summit 2022]({% post_url
2022-06-30-trino-summit-call-for-speakers %}).

*Manfred, Brian, and Dain*
