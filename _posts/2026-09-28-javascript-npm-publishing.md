---
layout: post
title: "Trino JavaScript packages are back on npm"
author: "Manfred Moser"
excerpt_separator: <!--more-->
image: /assets/images/logos/javascript-small.png
---

<!-- TODO: replace the header image with a purpose-made banner under
     assets/blog, rather than reusing the JavaScript logo. Note that the
     -small variants are the 250 by 200 mobile srcset images for the user and
     tool grids, while the post layout renders this field as a plain img at
     the top of the post. -->

Trino has an official JavaScript client and a React query editor component. For
the better part of a year, neither project could publish a release to the npm
registry. Both are unblocked now. They publish automatically, under new names,
with trusted publishing and provenance attestations, and without a single stored
credential. Both have since reached a stable release.

<!--more-->

## The two projects

In late 2024 I wrote about
[the many places JavaScript shows up in Trino]({{ site.baseurl }}{% post_url 2024-11-18-javascript %}),
from client drivers to the web user interfaces to the Grafana plugin. Two of
those threads matter here.

The [trino-js-client](https://github.com/trinodb/trino-js-client) project is the
official Trino client for Node.js, donated to the project by
[Filipe Regadas](https://github.com/regadas) and released for the first time
under the Trino umbrella in 2024. More projects depend on it than you might
expect. Business intelligence and analytics through
[Lightdash](https://lightdash.com), the Trino dialect connector in
[Malloy](https://www.malloydata.dev), the database manager
[Beekeeper Studio](https://www.beekeeperstudio.io), several Visual Studio Code
extensions including the
[SQLTools driver]({{ site.baseurl }}/ecosystem/client-application.html#vscode),
and a community node for n8n workflows all build on it. The readme carries
[the full list](https://github.com/trinodb/trino-js-client#projects-using-this-client),
and additions are welcome.

The [trino-query-ui](https://github.com/trinodb/trino-query-ui) project is
newer. It packages a query editor as a reusable React component, with metadata
browsing, schema-aware SQL completion, multiple query tabs, and result set
inspection. It is meant to be embedded in the
[Trino Web UI]({{ site.baseurl }}/docs/current/admin/web-interface.html), and in
any other React application that needs a Trino query editor.

## What broke

In 2025 the npm registry was hit by a series of supply chain attacks that spread
through compromised publishing tokens. GitHub responded with a
[plan for a more secure npm supply chain](https://github.blog/security/supply-chain-security/our-plan-for-a-more-secure-npm-supply-chain/)
that phases out publishing with long-lived tokens entirely.

Both Trino projects published with a stored token, so both stopped publishing.
The last token-based releases were `trino-client` 0.2.9 in November 2025 and
`trino-query-ui` 0.1.1 in December 2025. The next release attempt built fine and
then failed at the publish step with `Access token expired or revoked`, which is
recorded in
[trino-query-ui issue 31](https://github.com/trinodb/trino-query-ui/issues/31).

That was more than an inconvenience. Without a published package, the query
editor could not be consumed as a dependency, and the work to bring it into the
Trino Web UI had nowhere to go. The issue collected a steady stream of people
asking when it would be fixed.

## Access first

The first obstacle was not technical. Configuring trusted publishing needs owner
access to the npm organization and admin access to the repositories, and working
out who held what took longer than the code changes did. Thanks to Martin
Traverso and Filipe Regadas for tracking down the accounts and sorting out the
access.

## Trusted publishing

With access in place, both repositories moved to
[npm trusted publishing](https://docs.npmjs.com/trusted-publishers). Instead of
reading an `NPM_TOKEN` secret, the release workflow authenticates with OpenID
Connect. npm verifies the identity of the workflow itself, down to the
repository and the workflow file name, and issues a short-lived credential for
that one run.

Nothing is stored in the repository, so there is no token to rotate, expire, or
leak. The trusted publisher configuration on npmjs.com is the single place that
decides which workflow may publish which package.

Trusted publishing also brings provenance. Every version published this way
carries a [SLSA provenance](https://slsa.dev/provenance/v1) attestation that
links the tarball on npm back to the commit and the workflow run that built it.
Consumers can check it:

```shell
npm audit signatures
```

## New package names

Both packages moved under the `@trinodb` scope on npm, which makes project
ownership of the packages explicit and gives future Trino JavaScript packages a
consistent name.

| Old name | New name | Current version |
| --- | --- | --- |
| `trino-client` | `@trinodb/trino-js-client` | 1.0.0 |
| `trino-query-ui` | `@trinodb/trino-query-ui` | 2.0.0 |

The old names stay on npm at their last published version and receive no further
releases, so update the dependency name to keep getting new versions:

```shell
npm install @trinodb/trino-js-client
npm install @trinodb/trino-query-ui
```

Several downstream projects have already moved. Progress on the rest is tracked
in the trino-js-client repository, in
[issue 979](https://github.com/trinodb/trino-js-client/issues/979). If you
maintain something that depends on the old name, that issue is the place to
look, and a pull request renaming the dependency is welcome.

## Releases are automated now

Both repositories use the same release flow. The workflow runs on every push to
the default branch and checks whether the version in the package manifest
changed. When it did, the workflow publishes to npm and then creates the GitHub
release with generated notes. When it did not, the workflow does nothing.

Cutting a release is therefore a single reviewed pull request that bumps the
version. There is no manual tagging step and no manual publish.

The order of the two final steps matters. Publishing runs first, and the release
is created only after the publish succeeds. Doing it the other way around left
behind a GitHub release and a tag for a version that never reached npm, which
then had to be deleted by hand before the run could be repeated.

## Versioning follows Trino

Both projects changed how they number releases at the same time. From 1.0.0
onward, every release increments the major version. 1.0.0 is followed by 2.0.0,
then 3.0.0, with no compatibility implied between them.

The scheme mirrors the way Trino itself numbers releases, and it sets the
expectation that each version is its own upgrade. Read the release notes rather
than the version number to find out what changed. For the query editor
component in particular, the peer dependency ranges and the embedding contract
are still moving, so patch and minor guarantees would be promises the project
breaks on the next release.

This is also why the two version numbers differ. The query editor has cut two
releases since the scheme took effect, and the client one.

## Snags worth knowing

A few details cost real time, and they apply to any project making the same
move:

* **Trusted publishing cannot create a package that does not exist yet.** The
  registry has nothing to attach the trusted publisher configuration to. The
  first version under each scoped name has to be published by hand, and the
  workflow takes over from the next version onwards.
* **Use a current Node.js release.** The OIDC token exchange needs a recent npm
  command line interface. Both repositories now build and release on Node.js 24.
* **Yarn behaves differently from npm.** The trino-js-client project builds with
  Yarn, which generates a provenance attestation only when it is asked to
  through `publishConfig`, and which otherwise publishes to a registry mirror
  rather than to the registry that holds the trusted publisher configuration.
  Both need an explicit setting. The move also required an upgrade from Yarn
  3.2.1 to 4.18.0.

Both repositories document the resulting release process in their readme files,
and the full trail of the work is captured in
[trino-query-ui issue 31](https://github.com/trinodb/trino-query-ui/issues/31).

## Where the projects stand

The JavaScript client reached 1.0.0. The API did not change for that release.
After more than three years of production use at 0.x, the version number was
simply understating the status. The release is also the first one guarded by a
compatibility suite that installs the packed tarball and runs the call patterns
of the largest downstream projects against a live Trino, so a change that would
break them fails in continuous integration rather than in their build.

The query editor component reached 2.0.0, now ships TypeScript declarations, and
tracks the same dependency versions as the Trino Web UI, which is a
precondition for embedding it there.

One limitation is worth stating plainly, because it decides whether the
component is usable for you today. The query editor submits queries to
`/v1/statement` with the hardcoded identity `X-Trino-User: system`, and it
cannot reuse an authenticated Trino Web UI session. Web UI cookies are scoped to
`/ui`, and `/v1/statement` uses client authentication instead, so queries can
fail with `401 Unauthorized` even for a user who is logged into the Web UI. The
component therefore expects a Trino that accepts unauthenticated requests. The
details and the planned fix are in
[trino-query-ui issue 61](https://github.com/trinodb/trino-query-ui/issues/61).

## What's next

Publishing was the blocker, not the goal. With releases flowing again, the
following work becomes possible:

* Embed the query editor in the Trino Web UI, which is the reason the
  trino-query-ui project exists, tracked in
  [issue 5](https://github.com/trinodb/trino-query-ui/issues/5).
* Reuse the authenticated Web UI session, which gates any production use, in
  [issue 61](https://github.com/trinodb/trino-query-ui/issues/61).
* Integrate with Trino Gateway, where a user also has to be able to choose a
  cluster, in [issue 6](https://github.com/trinodb/trino-query-ui/issues/6).

The plans from the 2024 post are still on the list for the JavaScript client as
well, and several of them now have a way to reach users again:

* Support authentication methods beyond basic authentication, in
  [issue 524](https://github.com/trinodb/trino-js-client/issues/524)
* Support authenticated browser clients, the client-side half of the same
  session problem, in
  [issue 985](https://github.com/trinodb/trino-js-client/issues/985)
* Stop losing precision on 64-bit integers, in
  [issue 983](https://github.com/trinodb/trino-js-client/issues/983)
* Add support for the spooling client protocol
* Improve the documentation and the example projects
* Test with Trino Gateway and adjust as needed

## Help wanted

All of this needs more hands. The JavaScript work in Trino is separate enough
from the query engine that you do not need to know Java, or Trino internals, to
be useful. If you write TypeScript, React, or GitHub Actions, there is something
here for you.

Have a look at the open issues in
[trino-js-client](https://github.com/trinodb/trino-js-client/issues) and
[trino-query-ui](https://github.com/trinodb/trino-query-ui/issues), come talk to
us in the `#core-dev` channel on [Trino Slack]({{ site.baseurl }}/slack.html),
and join an
[upcoming Trino contributor call]({{ site.baseurl }}/community.html#events).

## Credits and support

Most of the work described in this post was mine, across both repositories: the
trusted publishing setup, the package renames, the release automation, the
compatibility suite, and the releases themselves. It went faster because other
people cleared the way. [Martin Traverso](https://github.com/martint) and
[Filipe Regadas](https://github.com/regadas) sorted out the npm and repository
access the whole effort depended on, and
[Peter Kosztolanyi](https://github.com/koszti) and
[Bob Du](https://github.com/BobDu) contributed fixes that shipped in the last
two releases of the query editor.

Maintaining these projects is ongoing work rather than a one-time push, and I
track every contribution as an issue in
[my contributions repository](https://github.com/simpligility/contributions) so
that it is visible and reviewable. If you or your organization depend on the
Trino JavaScript projects and want that maintenance to keep going, you can
[sponsor this work on GitHub](https://github.com/sponsors/mosabua), and
[my sponsor page](https://simpligility.ca/sponsor/) explains what it covers. My
thanks to everyone already sponsoring it.

That is separate from supporting the Trino project itself. The
[Trino sponsor page]({{ site.baseurl }}/sponsor.html) covers how individuals and
organizations back the Trino Software Foundation.
