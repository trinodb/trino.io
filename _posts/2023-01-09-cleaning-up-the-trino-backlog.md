---
layout: post
title:  "Cleaning up the Trino pull request backlog"
author: "Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/backlog-blog/so-many-pull-requests.png
---

At some point in the lifecycle of a successful open source project, it reaches a
point where the number of incoming pull requests (PRs) outpace the project's
ability to get code merged. It happens for a huge variety of reasons, including
developers moving on to other projects before tying up every loose end,
reviewers who miss a request for review, and because some stagnant PRs were
never going to happen and should have been closed two years ago. The GitHub
notification system doesn't do anyone any favors, either. Having too many open
PRs is a problem for a project, because they make it harder to tell what is
being worked on and what may as well be dead code walking.

And when we cross 700 open pull requests in Trino, constantly adding a few more
to the pile every week, what do we do? We clean it up! Let's talk about how
we're doing it, why we're doing it that way, and how we're planning on
preventing this from happening again. The end result should be some process
improvements that make contributing to Trino a better, faster, and more painless
experience.

<!--more-->

## Spring cleaning

The "how" is an easy thing to talk about. The Trino developer relations team is
in the process of going through all open PRs, from oldest to newest, manually
taking a look at each one and checking in on how we may want to proceed. For PRs
where the author seems to have abandoned it and not responded to a review, we close
them down, encouraging the authors to open them right back up if they decide
they want to continue work. For everything else, though, we've been taking a
more measured approach, offering to help facilitate reviews or discussion for
these long-lasting bits of code that may still have a chance of making their way
into Trino.

To anyone who's managed a repository before, this may seem like more effort than
necessary. You can add a bot to close anything that's been stale or inactive for
too long, and problem solved, right? Sure, that does solve the problem, but it
creates a couple others.

First, and perhaps most importantly: it's not very human. Having a pull request
that you put time and effort into get shut down by a bot without having another
person swing by to say hello can be demoralizing, and it builds a negative
experience that might discourage future contributions to the project. We want
our contributors to like Trino and to enjoy the process of adding on to it, and
a GitHub bot slamming the door shut on their hard work isn't going to help with
that. Having a bot do our work for us would also deprive us of a valuable
learning opportunity. Manually checking in on each pull request that slipped
through the cracks has allowed us to identify pain points in Trino code reviews
which we can try to mitigate moving forwards, and it's provided a ton of
valuable insights for deciding on how to best improve the process.

Second, and perhaps even more significant: there's a lot of cool stuff we'd be
missing out on if we automatically closed everything. While going through the
backlog, we've found dozens of year-old pull requests that still have a lot of
value for Trino and only needed someone to take another look at them. For some,
the author may be missing, but the ideas are good and the PR can be handed off
to someone else to carry the torch and get it across the finish line. For
others, the author is still happy and ready to iterate on it, and all that's
needed to get the ball rolling again is to ping a reviewer or two to take
another look. We've even found a couple PRs that were approved and ready to go,
and all it took was a simple click of the merge button. The effort-to-impact
ratio on that is off the charts - think of all the value we'd be missing out on
if we'd automatically closed those!

The result of the effort so far has been excellent.

<img src="/assets/blog/backlog-blog/open-pull-requests-graph.png"/>

We're not completely done with the cleanup effort, but as you can see, we're
slowing down. Our oldest PRs are increasingly recent, still in development,
and worth having open. Going from a peak of 700+ open pull requests to around
300 is a massive improvement, and the goal is to end up in the vicinity of about
200 open pull requests in Trino at any point in time.

## Keeping things pristine

But with the cleanup being so manual, the next challenge is stopping the pull
requests from steadily piling back up while we're not paying attention to them.
The fix for that is simple - we're going to keep paying attention. The Trino
developer relations team is planning on tracking and getting involved in two
categories of pull requests to keep the number of open PRs stable.

The first category is pull requests that don't get any immediate attention from
a reviewer. While Trino reviewers are overall excellent and quick to take a look
at incoming pull requests, about five percent slip through the cracks, where a
contributor submits something that receives no reviews or comments and lives on
in the pull request backlog. That's not a good experience for the contributor,
and it's not good for Trino, either, because that contribution could have a lot
of value. We plan on stopping this from happening by implementing workflows
which spring Trino developer relations into action when these situations arise.
If a pull request goes a few days without a comment, we'll be the safety net to
ask questions, get engineers involved, and make sure that at least a few pairs
of eyes take a look at every incoming PR in a timely manner.

The second category is pull requests that get some reviews, but eventually
stagnate or stop being actively worked on. This happens for a lot of reasons,
but in all cases, if a pull request goes a few weeks with no activity, the
developer relations team will be checking in. Our goal will be to figure out the
proper path forward, whether that's flagging down some reviewers again,
communicating that the pull request should be closed, or anything else. The end
result should be that nothing slips through the cracks and ends up going months
without human contact. If an author vanishes or everyone gets too busy to look
at a pull request again, though, the final stop will ultimately be a stale bot
which closes pull requests that have gone a few months with no activity.

With all these processes in place, contributors should never feel like their
efforts are going unnoticed. Submitted code should be reviewed quickly,
iterated on in a timely manner, and merged without much delay. In situations
where a pull request is *not* going to be merged, the Trino developer relations
team should be able to chime in quickly to make that clear, saving contributors
from wasting time and effort on a false impression that their code will be
landed. And if you have any questions, concerns, or suggestions about all of
this, don't hesitate to reach out to us directly on the Trino Slack using
`@devrel-team`!