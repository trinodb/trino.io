---
layout: default
menu_id: development
title: Roles
pretitle: Development
show_hero: true
show_pagenav: true
---

<div class="container container__development">

  <div class="row spacer-60">
  <div class="col-md-12">
<div markdown="1" class="leftcol widecol">

## Overview

Everyone is encouraged to participate in the Trino project. Anyone can influence
the project by simply being involved in the discussions about new features, the
roadmap, architecture, and problems they are facing. The various roles
described here do not carry more weight in these discussions, and instead we try
to always work towards consensus. The Trino project has a strong
[vision and development philosophy](/development/vision.html) that helps to
guide discussions and allows us to reach consensus. When we can't come to
consensus, we work to figure out what we agree on, and what we don't. Then we
move forward by building what we agree on, which helps everyone better
understand the parts we don't agree on, and hopefully builds empathy at the same
time.

The following describes the expectations and duties of the various roles.

## Participants <a name="participant"></a>

This is the most important role. Very simply put, participants are those who
show up and join in discussions about the project. Users, developers, and
administrators can all be participants, as can literally anyone who has the
time, energy, and passion to become involved. Participants suggest improvements
and new features. They report bugs, regressions, performance issues, and so on.
They work to make Trino better for everyone.

**Expectations and duties:**

* Be involved in discussions about features, roadmaps, architecture, and
  long-term plans.
* Help other users on [Slack](./slack.html), on GitHub issues, and GitHub discussions.
* Propose and discuss new features and improvements.
* Help raise the project's quality.
* Let everyone else know what isn't working or is confusing.
* Report bugs and performance regressions.
* Suggest improvements to infrastructure and testing.
* Recommend improvements to documentation and the website.
* Understand that although English is the language of this project, English is
  not the first language of many participants. Assume positive intent from
  others and realize that negative sounding comments are often unintentional due
  to language barriers.

## Contributors <a name="contributor"></a>

A contributor submits changes to the [Trino
repositories]({{site.gihub_org_url}}) following the [contribution
process](/development/process.html).

**Expectations and duties:**

* Be empathetic to the reviewers. Reviewing a change can be hard work and
  time-consuming.
* Keep commits small when possible and provide reasoning and context when
  submitting changes. Reviews go smoother if you make the reviewer’s job easier.
* Be responsive when changes are requested by the reviewer. It is easier to
  re-review the modified changes if they are completed shortly after original
  review.
* Ask for clarification if you are confused by a suggested change.
* Speak up if your contribution appears to be stuck.
* Read the [project vision](/development/vision.html) and development
  philosophy.
* Follow the style guidelines and more importantly, follow the Trino coding
  conventions by matching your code to the existing code. Keep in mind the Trino
  development philosophy is to have all code appear as if it were written by a
  single person.
* Sign the [contributor license agreement (CLA)](https://github.com/trinodb/trino/blob/master/LICENSE).

[You can view all contributors on GitHub.](https://github.com/orgs/trinodb/teams/contributors/members)

## Reviewers <a name="reviewer"></a>

A reviewer reads a proposed change to Trino, and assesses how well the change
aligns with the Trino vision and guidelines. This includes everything from high
level project vision to low level code style. Everyone is invited and encouraged
to review others' contributions -- you don't need to be a maintainer for that.

**Expectations and duties:**

* Be empathetic to contributors. They may have put a lot of effort into the
  proposed change and may not be familiar with the codebase, the process, or the
  history of the project.
* Be responsive to questions.
* Re-review after suggested changes have been applied.
* Be clear about which changes are only suggestions, and which changes are
  necessary.
* Let the contributor know what is going on, so reviews don't appear to be
  stuck.
* Raise a discussion when a change does not seem to align with the vision or
  development philosophy.
* Point out deviations from the code conventions and style guidelines.
* Ask for help reviewing areas you don't understand.

## Maintainers <a name="maintainer"></a>

In Trino, maintainer is an active role. A maintainer is responsible for merging
code only after ensuring it has been reviewed thoroughly and aligns with the
Trino vision and guidelines. In addition to merging code, a maintainer actively
participates in discussions and reviews. Being a maintainer does not grant
additional rights in the project to make changes, set direction, or anything
else that does not align with the direction of the project. Instead, a
maintainer is expected to bring these to the project participants as needed to
gain consensus. The maintainer role is for an individual, so if a maintainer
changes employers, the role is retained. However, if a maintainer is no longer
actively involved in the project, their maintainer status will be reviewed.

**Expectations and duties:**

* Be an active reviewer and participant.
* Know which changes are likely to be controversial, and work to resolve the
  controversy as early as possible.
* Know when a change needs more reviewers involved.
* Add the language lead to reviews when appropriate.
* Ensure the review of a proposed change is thorough.
* Point out when a contribution appears to be stuck.
* Assist with the authoring of release notes.
* Follow the CLA and IP policies.

An Apache Hive committer did an excellent write up on their process and much of
this aligns with our philosophy on maintainers.
[Read about it](https://cwiki.apache.org/confluence/display/Hive/BecomingACommitter).

Trino maintainers typically focus on the core trino repository, but many also
work across [other projects in the trinodb
organization](https://github.com/orgs/trinodb/repositories) and upstream projects
such as [airlift](https://github.com/airlift/airlift), and assist with the
[trinodb subprojects](#subprojects).

The following community members are Trino maintainers:

<table style="width: 30%">
  <thead>
    <tr>
      <th><i class="fab fa-github"></i></th>
      <th>Full name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="https://github.com/dain">dain</a></td>
      <td>Dain Sundstrom</td>
    </tr>
    <tr>
      <td><a href="https://github.com/ebyhr">ebyhr</a></td>
      <td>Yuya Ebihara</td>
    </tr>
    <tr>
      <td><a href="https://github.com/electrum">electrum</a></td>
      <td>David Phillips</td>
    </tr>
    <tr>
      <td><a href="https://github.com/findepi">findepi</a></td>
      <td>Piotr Findeisen</td>
    </tr>
    <tr>
      <td><a href="https://github.com/hashhar">hashhar</a></td>
      <td>Ashhar Hasan</td>
    </tr>
    <tr>
      <td><a href="https://github.com/kasiafi">kasiafi</a></td>
      <td>Kasia Findeisen</td>
    </tr>
    <tr>
      <td><a href="https://github.com/kokosing">kokosing</a></td>
      <td>Grzegorz Kokosiński</td>
    </tr>
    <tr>
      <td><a href="https://github.com/losipiuk">losipiuk</a></td>
      <td>Łukasz Osipiuk</td>
    </tr>
    <tr>
      <td><a href="https://github.com/martint">martint</a></td>
      <td>Martin Traverso</td>
    </tr>
    <tr>
      <td><a href="https://github.com/mosabua">mosabua</a></td>
      <td>Manfred Moser</td>
    </tr>
    <tr>
      <td><a href="https://github.com/pettyjamesm">pettyjamesm</a></td>
      <td>James Petty</td>
    </tr>
    <tr>
      <td><a href="https://github.com/Praveen2112">Praveen2112</a></td>
      <td>Praveen Krishna</td>
    </tr>
    <tr>
      <td><a href="https://github.com/raunaqmorarka">raunaqmorarka</a></td>
      <td>Raunaq Morarka</td>
    </tr>
    <tr>
      <td><a href="https://github.com/sopel39">sopel39</a></td>
      <td>Karol Sobczak</td>
    </tr>
    <tr>
      <td><a href="https://github.com/wendigo">wendigo</a></td>
      <td>Mateusz Gajewski</td>
    </tr>
  </tbody>
</table>

### Path to becoming a maintainer

1. **Read:** Understand the project values and scope, the development philosophy
   and guidelines, and the change process. These contain necessary background
   information to be successful in Trino.
2. **Contribute:** This helps you learn the codebase, and understand the
   development process. Start with something small to become familiar with the
   process.
3. **Review:** Once you become familiar with a part of Trino, start reviewing
   proposed changes to that part. A maintainer does an additional final review,
   and this helps you understand what you are missing in your reviews. At some
   point, your first pass reviews will not require additional changes during the
   final review.
4. **Maintainer:** The next step is to demonstrate an understanding of what you
   know and don’t know. It is common for changes to require reviews from
   multiple people, since no one person is familiar with all of Trino. We are
   also looking for an understanding of the project values and technical vision.
   Being a maintainer means reviewing and merging code in your areas of
   expertise from all contributors. The maintainer role is retained while being
   active in the project.

## Subproject maintainers <a name="subproject-maintainer"></a>

A subproject maintainer on the Trino project is a maintainer with limited scope
in terms of access to specific repositories within the [trinodb GitHub
organization]({{site.github_repo_url}}). The scope is also limited in terms of
the used technologies.

Subproject maintainers only have merge access on a specific subproject
repository. Subproject repositories cover a subset of the overall scope of the
Trino project. They are often associated to a specific aspect of running the
project or a technology stack and integration for Trino.

Examples for subproject repositories are the
[trino.io]({{site.github_org_url}}/trino.io) website source or the
[grafana-trino]({{site.github_org_url}}/grafana-trino) repository for the Trino
Grafana data source plugin. Other potential subprojects are
[trino-python-client]({{site.github_org_url}}/trino-python-client),
[trino-go-client]({{site.github_org_url}}/trino-go-client), and
[charts]({{site.github_org_url}}/charts).

**Expectations and duties:**

The expectations and duties of a subproject maintainer are identical to those of
a maintainer, but limited to the subproject repository and the related
technologies.

### Subprojects

The following subproject repositories and subproject maintainers are configured:

[aws-proxy]({{site.github_org_url}}/aws-proxy) - Proxy for AWS S3
* [<i class="fab fa-github"></i> mosiac1](https://github.com/mosiac1) Cristian Osiac
* [<i class="fab fa-github"></i> Randgalt](https://github.com/Randgalt) Jordan Zimmerman
* [<i class="fab fa-github"></i> vagaerg](https://github.com/vagaerg) Pablo Arteaga

[charts]({{site.github_org_url}}/charts) - Helm charts for Trino
* [<i class="fab fa-github"></i> nineinchnick](https://github.com/nineinchnick) Jan Waś

[grafana-trino]({{site.github_org_url}}/grafana-trino) - Grafana data source plugin for Trino
* [<i class="fab fa-github"></i> nineinchnick](https://github.com/nineinchnick) Jan Waś

[trino.io]({{site.github_org_url}}/trino.io) - Trino website
* [<i class="fab fa-github"></i> bitsondatadev](https://github.com/bitsondatadev) Brian Olsen
*  [<i class="fab fa-github"></i> colebow](https://github.com/colebow) Cole Bowden

[trino-gateway]({{site.github_org_url}}/trino-gateway) - Trino Gateway load balancer and router
* [<i class="fab fa-github"></i> Chaho12](https://github.com/Chaho12) Jaeho Yoo
* [<i class="fab fa-github"></i> oneonestar](https://github.com/oneonestar) Star Poon
* [<i class="fab fa-github"></i> vishalya](https://github.com/vishalya) Vishal Jadhav
* [<i class="fab fa-github"></i> willmostly](https://github.com/willmostly) Will Morrison

[trino-go-client]({{site.github_org_url}}/trino-go-client) - Trino client fo Go
* [<i class="fab fa-github"></i> nineinchnick](https://github.com/nineinchnick) Jan Waś

[trino-js-client]({{site.github_org_url}}/trino-js-client) - Trino client for Javascript
* [<i class="fab fa-github"></i> regadas](https://github.com/regadas) Filipe Regadas
* [<i class="fab fa-github"></i> nineinchnick](https://github.com/nineinchnick) Jan Waś


## Language lead

The language lead is the maintainer specifically responsible for maintaining the
SQL language implementation in Trino. Trino attempts to adhere to the ANSI SQL
specification and related extensions and conventions as closely as possible.
Because SQL is the primary interface for Trino users, the language lead serves
as the sole decision maker regarding SQL language decisions. The primary
objective for this role is to maintain compatibility between versions and ensure
adherence to the SQL standard. All pull requests making changes or additions to
Trino SQL syntax, types, and function library must have the `syntax-needs-review`
label and be reviewed by the language lead.

Martin Traverso [<i class="fab fa-github"></i>
martint](https://github.com/martint) is the language lead.

## File system lead

The file system lead is the maintainer specifically responsible for maintaining
the `TrinoFileSystem` APIs for accessing files and file systems, typically used
in the [object storage
connectors]({{site.url}}/docs/current/object-storage.html#object-storage-connectors).

The `TrinoFileSystem` APIs are carefully designed to contain only the operations
needed by Trino, and with a goal of each operation being simple to understand,
fully documented, and thoroughly tested. These APIs replace the legacy Hadoop
FileSystem APIs. With the new APIs, the project improves developer productivity,
because you can rely on the documented behavior and be confident this is
verified by tests. Additionally, the clarity of the requirements for the APIs
empowers developers to add support for additional file systems.

To maintain this simplicity, the APIs are only changed and expanded in a very
conservative and careful manner. Any such changes of the API and its behavior
musted be reviewed and approved by the file system lead.

David Phillips  [<i class="fab fa-github"></i>
electrum](https://github.com/electrum) is the file system lead.

## Benevolent dictators for life <a name="bdfl"></a>

Common [among other open source projects](https://en.wikipedia.org/wiki/Benevolent_dictator_for_life),
the role of benevolent dictator for life (BDFL) empowers particularly esteemed
maintainers to act as the ultimate authority for technical decisions. In
circumstances where the maintainers are divided or uncertain about how to
proceed on a given issue, final say will defer to the benevolent dictators.

**Expectations and duties:**

* Lead the maintainer team, including upholding policies and appointing new
  maintainers.
* Resolve disputes and provide rulings on technical matters to move the project
  forward.
* Listen and answer to the community. The benevolent dictators *are benevolent*,
  and their goal is to act in the best interests of Trino, its contributors, and
  its users.

Dain Sundstrom [<i class="fab fa-github"></i> dain](https://github.com/dain),
David Phillips [<i class="fab fa-github"></i>
electrum](https://github.com/electrum), and Martin Traverso [<i class="fab
fa-github"></i> martint](https://github.com/martint) are the BDFLs.

## Trino Software Foundation

The Trino Software Foundation is the governing authority of the entire Trino
project. Though it does not get involved in day-to-day discussions or technical
decisions, it maintains oversight of the project and intellectual property.
[You can read more about the Trino Software Foundation here.](/foundation.html)

</div>
</div>
</div></div>
