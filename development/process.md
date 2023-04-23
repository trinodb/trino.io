---
layout: default
menu_id: development
title: Contribution process
pretitle: Development
show_hero: true
show_pagenav: false
---


<div class="container container__development">

  <div class="row spacer-60">
  <div class="col-md-12">
<div markdown="1" class="leftcol widecol process">


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

   Trino maintainers can schedule additional workflow runs after reviewing a PR
   by adding a comment starting with this line:

    ```
    /test-with-secrets sha=<all-40-characters>
    ```

   The SHA value should be the full 40 character git SHA of a commit
   of the feature branch, usually the head commit.

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

    * Approval of one maintainer is required for merge. This includes cases when
      the author of the PR is a maintainer, and a second maintainer reviews, and
      approves the PR. In these cases either maintainer can merge the PR.
    * Approvals and input from other reviewers are helpful for the decision of
      the maintainers, but not required.
    * In the event that the maintainer team is divided on whether a particular
      contribution should be merged, the final decision is made by the [BDFLs](/development/roles.html)
      of the project.

</div>
</div>
</div>
</div>
