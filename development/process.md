---
layout: default
menu_id: development
title: Contribute
pretitle: Development
show_hero: true
show_pagenav: true
---


<div class="container container__development">

  <div class="row spacer-60">
  <div class="col-md-12">
<div markdown="1" class="leftcol widecol process">

The Trino project succeeds with your help and contributions. Find details on how
to contribute, how maintainers assist, and more related information in the
following sections:

## Contribution process

This is the process we suggest for contributions.  This process is designed to
reduce the burden on project reviewers, impact on other contributors, and to
keep the amount of rework from the contributor to a minimum.

1. Sign the [contributor license agreement]({{site.github_org_url}}/cla), and
   proceed with the next steps while the CLA is processed.

2. Start a discussion by creating a GitHub
   [issue]({{site.github_repo_url}}/issues), or asking on [Slack](/slack.html)
   (unless the change is trivial, for example a spelling fix in the
   documentation).

    1. This step helps you identify possible collaborators and reviewers.
    2. Does the change align with technical vision and project values?
    3. Will the change conflict with another change in progress? If so, work
       with others to minimize impact.
    4. Is this change large?  If so, work with others to break into smaller
       steps.

4. Implement the change

    1. Create or update [your own fork of the repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks)
       from the [Trino project](https://github.com/trinodb) that you want to
       contribute to.
    2. If the change is large, post a draft GitHub
       [pull request]({{site.github_repo_url}}/pulls) with the title prefixed
       with `[WIP]`, and share with collaborators.
    3. Include tests and documentation as necessary.
    4. Follow the [pull request and commit guidelines](#commit), the [release
       note guidelines](#release-note), and other suggestions from the [Trino
       development
       guidelines](https://github.com/trinodb/trino/blob/master/.github/DEVELOPMENT.md).

5. Create a GitHub [pull request]({{site.github_repo_url}}/pulls) (PR).

    1. If you already have a `[WIP]` or draft PR, change it to ready for review.
    2. Refer to the [GitHub documentation for more details about collaborating with PRs](https://docs.github.com/en/pull-requests).
    3. Make sure the pull request passes the tests in CI.
    2. If known, request a review from an expert in the area changed. If
       unknown, ask for help on [Slack](/slack.html).

   There are some tests that use external services, like Google BigQuery, and
   require additional credentials. The Trino project cannot share these
   credentials with contributors, so it runs these tests in its CI workflows
   only on branches in the Trino repository, not in contributor forks.
   Maintainers trigger these test runs for other pull requests as part of their
   review.

6. Review is performed by one or more reviewers.

    1. This normally happens within a few days, but may take longer if the
       change is large, complex, or if a critical reviewer is unavailable. (feel
       free to ping the reviewer or [DevRel team](https://github.com/orgs/trinodb/teams/devrel/members)
       on the pull request).

7. Address concerns and update the pull request.

    1. Comments are addressed to each individual commit in the pull request, and
       changes should be addressed in a new
       [`fixup!` commit](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---fixupamendrewordltcommitgt)
       placed after each commit. This is to make it easier for the reviewer to
       see what was updated.
    2. After pushing the changes, add a comment to the pull-request, mentioning
       the reviewers by name, stating that the review comments have been
       addressed. This is the only way that a reviewer is notified that you are
       ready for the code to be reviewed again.
    3. Go to step 5.

8. Maintainer merges the pull request after final changes are accepted.

9. Maintainers organize a release to ship the next Trino version with your
   improvements.

    * All maintainers and the DevRel team collaborate to include your change in
      the release notes.
    * Roughly every week, the maintainers initiate a new release build. Exact
      timing depends on any release blocker issues and availability to run the
      release build.
    * After the release all binaries are available and the documentation and the
      website are updated.
    * Finally the release is announced.

## Pull request and commit guidelines<a name="commit"></a>

Contributions to Trino projects are managed as [collaboration with pull
requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests).

Pull requests are usually merged into `master` or `main` using the  [`rebase and
merge`](https://docs.github.com/en/github/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges#rebase-and-merge-your-pull-request-commits)
strategy to preserve the commits from the contributor and avoid adding empty
merge commits.

Reviews allow feedback from one or more maintainer and other community members,
all helping the project as volunteers in addition to their own contributions. It
is important to make these reviews as fast and efficient as possible, while at
the same time enabling feedback and discussion about the technical approach and
relevant details. Reviews are time consuming and it is in the best interest for
the contributor to keep reviews as simple as possible. The following guidelines
are designed to help contributors.

A typical pull request should strive to contain a single logical change, but not
necessarily a single commit. Unrelated changes should generally be extracted
into their own PRs.

If a pull request contains a stack of commits, then popping any number of
commits from the top of the stack, should not break the PR, meaning that every
commit should build and pass all tests.

Commit messages and history are important as well, because they are used by
other developers to keep track of the motivation behind changes. Keep logical
changes together and order commits in a way that explains the evolution of the
change by itself. Rewriting and reordering commits is a natural part of the
review process.

Mechanical changes like refactoring, renaming, removing duplication, extracting
helper methods, static imports should be kept separated from logical and
functional changes and also be broken up into separate commits. This makes
reviewing the code much easier and reduces the chance of introducing unintended
changes in behavior.

Whenever in doubt on splitting a change into a separate commit, ask yourself the
following question: if all other work in the PR needs to be reverted after
merging to master for some objective reason, such as a bug has been discovered,
is it worth keeping that commit still in master.

When writing a commit message, follow the
[seven rules of a great commit message](https://chris.beams.io/posts/git-commit/):

* Separate subject from body with a blank line.
* Limit the subject line to 50 characters.
* Capitalize the subject line.
* Do not end the subject line with a period.
* Use the [imperative mood, as used in a
  command or request](https://en.wikipedia.org/wiki/Imperative_mood), in the subject line.
* Wrap the body at 72 characters.
* Use the body to explain what and why versus how.

Read the [full commit message guide](https://chris.beams.io/posts/git-commit/)
for more details and examples.

The rapid evolution of the project and therefore the content of the default
branch also means that contributors must rebase their pull request branch
regularly and ensure no conflicts prevent merging.

## Release note guidelines<a name="release-note"></a>

Release notes should communicate the user-facing aspects of all change with a
specific version. As a results internal refactoring or improvements, such as
build fixes or new tests, are not included. New features, new configuration,
performance changes, bug fixes and other aspects relevant for users and
administrators must be included.

Release note entries should be suggested by the contributor. Correct content and
wording is part of the pull request review and merge process. If necessary the
contributor and merging maintainer can work with the maintainer assembling the
release notes PR.

Some release notes are broken up into separate section for different components.
For example, Trino release are ordered following the
[template](https://github.com/trinodb/trino/blob/master/docs/release-template.md)

In each section different release notes entries are sorted:

1. **New features**: Start with `Add` or `Add support for` or similar wording
2. **Performance improvements**: Start with `Improve` or `Improve performance`
   or similar wording
3. **Bug fixes**: Start with `Fix` or `Prevent`  or similar wording

Use [imperative present tense, as used in a command or
request](https://en.wikipedia.org/wiki/Imperative_mood) to describe the change.
For example, use `Add` or `Fix` or `Improve`, not `Added` or `Fixed` or
`Improved`.

When a change adds configuration, include the configuration details after the
description of the functionality. Detail the property names and their types.
Consider linking to new documentation.

View older release notes for example and strive for consistency with other
release notes and release notes entries.

Link to specific sections in the documentation to avoid overly long entries,
especially if more information is needed.

Release notes entries that prevent application start up with old configuration
or otherwise change application behavior significantly must be marked as
breaking changes. 

The specific syntax for the release notes, breaking changes, links and other
aspects, is dependent on the used documentation system for each project. For
example, Trino uses markdown files with Sphinx, while Trino Gateway uses
markdown files with mkdocs. Other projects use plain markdown files in the
repository without a documentation system.

Follow the guidelines for the documentation system in terms of formatting code,
links, or keywords. Details are typically available in a README file or as part
of the documentation itself.

Release notes should also follow the documentation style guide used for all
Trino documentation - the [Google developer documentation style
guide](https://developers.google.com/style).

### Trino and Trino Gateway release notes process

The release notes for Trino and Trino Gateway are assembled by a contributor
during the development cycle for each release with the following process:

* After a release is shipped a new pull request for the release notes is
  created. It uses the description of a prior release notes pull request. Trino
  includes a template file to start the new release notes. Trino Gateway adds a
  new section on the same page. Follow the PRs for
  [Trino 472](https://github.com/trinodb/trino/pull/25101) and 
  [Trino Gateway 14](https://github.com/trinodb/trino-gateway/pull/589) as
  examples.
* Every merged pull request is reviewed for a suitable release notes entry and
  sufficient documentation. If necessary, further clarification and
  documentation is requested from the contributor and the merging maintainer.
* The release notes pull request is updated daily with the relevant details.
* The release date is set in the PR and closer to the release date further
  reviews from maintainers are requested. Trino releases weekly, Trino Gateway
  every four weeks.
* On the day of the release everything is finalized with the release manager and
  upon approval the PR is merged. After the release is cut the process starts
  again with the same or a different contributor.

## Maintainer processes

[Maintainers](./roles.html#maintainer) support the contributions from the
community and other maintainers by participating in the contribution process.
The following additional processes and steps apply for their work.

### Pull request review

The following aspects apply for reviewing pull requests.

* Code and tests should be part of the pull requests and review.
* Commit content, sequencing, and messages must be reviewed.
* Documentation should be part of the PR or available in a separate PR, that is
  ideally merged and managed together with the code contribution.
* Maintainers can schedule additional workflow runs with tests that use external
  services when reviewing a PR by adding a comment:

  ```
  /test-with-secrets sha=<all-40-characters>
  ```
  The SHA value should be the full 40 character git SHA of a commit of the
  feature branch, usually the head commit. This allows runs with the full test
  suite, including third party integrations and infrastructure for branches that
  are not in the core repository. Maintainers must review the pull request to
  understand and assess the security implications of running the test suite on
  the external service and ensure that no malicious code is run.

### Pull request review and merge

The following criteria and aspects apply for merging pull requests.

* CLA check must pass to confirm that a CLA was submitted and filed.
* CI test suite must pass, or significant evidence must be available that
  failures are unrelated. This can include local test runs by the maintainer.
* Approval of a reviewing maintainer is required before a pull request can be
  merged. If a maintainer authors a pull request, another maintainer must
  approve it.
* Approvals and input from other reviewers are helpful for the decision of the
  maintainers, but not required.
* In the event that the maintainer team is divided on whether a particular
  contribution should be merged, the final decision is made by the
  [BDFLs](./roles.html#bdfl) of the project.
* By default, merging should be done as a **Rebase and merge**. Maintainers can
  also use **Squash and merge** at their discretion. This is suitable for small
  fixes on commit messages, or if PR is ready but the contributor is
  unresponsive. When using squash and merge, ensure to remove the PR number that
  is automatically inserted by the GitHub interface as part of the suggested new
  commit message.
* The merging maintainer must assist the release team with release notes entries
  creation and any necessary clarification. If necessary, the merging maintainer
  collaborates with the contributors and reviewers on details.

### CLA management

Reviews and assistance for the contributor on a pull request can proceed as soon
as a PR is filed and set as ready for review. A signed CLA is required for
merging a PR. Submitted CLAs are managed by the [BDFLs](./roles.html#bdfl).

Maintainers can trigger a CLA verification on a PR by adding a comment with the
command `@cla-bot check`.
</div>
</div>
</div>
</div>
