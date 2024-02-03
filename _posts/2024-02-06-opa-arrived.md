---
layout: post
title:  "Open Policy Agent for Trino arrived"
author: Manfred Moser
image: /assets/images/logos/opa-small.png
excerpt_separator: <!--more-->
show_pagenav: true
---

Trino now ships with an access control integration using the popular and widely
used [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) from the Cloud Native
Computing Foundation. The release of [Trino
438]({{site.url}}/docs/current/release/release-438.html) marks an important
milestone of the effort towards this integration.

<!--more-->

## Collaboration and history

Open Policy Agent was first released in 2016 and has gained more and more
popularity in the ecosystem of cloud native applications and beyond.

Initial efforts for an integration with Trino started at Bloomberg, Stackable,
Raft, and other places separately and sometimes in parallel, with only partial
collaboration. You might have first heard about it in August 2022 in the [Trino
Community Broadcast episode 39]({{site.url}}/episodes/39.html) with a team from
Raft as guests.

Usage and experience with OPA grew. In the end, Pablo Arteaga from
[Bloomberg](https://www.techatbloomberg.com/) and Sebastian Bernauer and Sönke
Liebau from [Stackable](https://stackable.tech/) had the initiative to start a
pull request to Trino. Their persistence and collaboration led them through many
review comments, update commits, and even a second PR, to submit a talk and
eventually present at Trino Summit 2023 about the Open Policy Agent access
control with Trino and their motivation to move from Apache Ranger to OPA.

## OPA at Trino Summit 2023

The presentation from Pablo and Sönke titled "Trino OPA authorizer - An open
source love story" received a lot of interest from the audience at the event and
on YouTube since then. They detailed the architectural differences of using
Ranger and OPA. Sönke detailed the usage of OPA in the Stackable platform and
how it enables a single access control platform to apply across many systems.
They discussed their collaboration on the pull request, and Pablo showed a
migration path from Ranger, and a full demo of OPA with Trino.

{% youtube fbqqapQbAv0 %}

They also made the [slide deck available for your
reference]({{site.url}}/assets/blog/trino-summit-2023/opa-trino.pdf).

Edward Morgan and Bhaarat Sharma from [Raft](https://teamraft.com/) also
presented [Avoiding pitfalls with query federation in data
lakehouses](https://www.youtube.com/watch?v=6KspMwCbOfI) at Trino Summit, and
detailed their OPA usage in their Data Fabric platform. It combines Delta Lake,
Trino, Apache Kafka, and Open Policy Agent (OPA) into a robust lakehouse data
platform. They talked about access control in Trino overall and how important it
is for their customers, including the US Department of Defense. Their
presentation also included a demo of OPA with Trino.

{% youtube 6KspMwCbOfI %}

## OPA on the way to Trino

Pablo and Sebastian continued their efforts on the [pull
request](https://github.com/trinodb/trino/pull/19532) after Trino Summit. They
worked successfully with Dain on the code review and necessary changes, and
helped Manfred with the documentation.

Finally, with the release of Trino 438, the [Open Policy Agent access
control]({{site.url}}docs/current/security/opa-access-control.html) is available
to all Trino users.

The community is already taking notice with follow up pull requests for further
improvements and blog posts such as [Enhancing Security and Observability in
Trino with Open Policy Agent and
OpenTelemetry](https://www.linkedin.com/pulse/enhancing-security-observability-trino-open-policy-agent-isa-inalcik-zhl9e/)
from Isa Inalcik.

## Benefits of OPA

The arrival of OPA support for Trino marks an important step. OPA is a mature
and widely used access control system. Its
[ecosystem](https://www.openpolicyagent.org/ecosystem/) includes many
integrations, user interfaces, development tools, and other resources.

OPA is a very flexible authorization system, making it an ideal match for Trino.
Trino deployments are often part of a diverse data platform, spanning a variety
 of interconnected data sources, pipelines, client tools and applications.

Trino users now have an alternative to the file-based access
control from the Trino project itself, the effort to support your own Ranger
integration, or the use of commercial offerings for access control.

## What's next

We reached another milestone but we are not done yet. Specifically for OPA, we
are looking at the following next tasks:

* Get more features from various older, private forks converted into pull
  requests to Trino so everyone can benefit.
* Update the documentation with more practical advice and tips.
* Provide further resources for running OPA with Trino, writing rego scripts,
  and helping the community.
* Implementation of row level filtering and column masking, based on the
  [draft](https://github.com/bloomberg/trino/pull/16) from Pablo

Special thanks go to everyone participating so far. Consider this an open
invitation to join the effort.

Ping me on Slack directly or find us in #opa-dev.

*Manfred*