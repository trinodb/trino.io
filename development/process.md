---
layout: page
menu_id: development
title: Development - Process
---

<div markdown="1" class="leftcol widecol process">

## Contribution Process

This is the process we suggest for contributions.  This process is designed to reduce the burden on project 
reviews, impact on other contributors, and to keep the amount of rework from the contributor to a minimum.

1. Sign the [contributor license agreement](https://github.com/prestosql/cla).

2. Start a discussion by creating a Github [issue](https://github.com/prestosql/presto/issues), or asking on
   [Slack]({{ site.slack_url }}) (unless the change is trivial).
     
    1. This step helps you identify possible collaborators and reviewers.
    2. Does the change align with technical vision and project values?
    3. Will the change conflict with another change in progress? If so, work with others to minimize impact.
    4. Is this change large?  If so, work with others to break into smaller steps.

3. Implement the change

    1. If the change is large, post a preview Github [pull request](https://github.com/prestosql/presto/pulls) 
       with the title prefixed with `[WIP]`, and share with collaborators.
    2. Include tests and documentation as necessary.

4. Create a Github [pull request](https://github.com/prestosql/presto/pulls) (PR).

    1. Make sure the pull request passes the tests in Travis CI.
    2. If known, request a review from an expert in the area changed.  If unknown, ask for help on Slack.

5. Review is performed by one or more reviewers.

    1. This normally happens within a few days, but may take longer if the change is large, complex, or if a 
       critical reviewer is unavailable. (feel free to ping the pull request).

6. Address concerns and update the pull request.
    
    1. Comments are attached to each individual commit in the pull, and changes should be addressed in a
       new `Fixup!` commit placed after each commit.  This is to make it easier for the reviewer to see what was updated.
    2. After pushing the changes, add a comment to the pull-request, mentioning the reviewers by name, stating
       the change have been addressed.  This is the only way that a reviewer is notified that you are ready
       for the code to be reviewed again.
    3. Go to step 5.

7. Maintainer merges the pull request after final changes are accepted.

8. Add release notes to the [issue](https://github.com/prestosql/presto/labels/release-notes) for the upcoming release.

</div>
