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

1. Sign the [contributor license agreement]({{site.github_org_url}}/cla).

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

    1. If the change is large, post a draft GitHub
       [pull request]({{site.github_repo_url}}/pulls) with the title prefixed
       with `[WIP]`, and share with collaborators.
    2. Include tests and documentation as necessary.

5. Create a GitHub [pull request]({{site.github_repo_url}}/pulls) (PR).

    1. Make sure the pull request passes the tests in CI.
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

### Pull request review and  merge

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

</div>
</div>
</div>
</div>
