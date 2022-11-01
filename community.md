---
layout: default
menu_id: community
title: Trino Community
---

<div class="jumbotron card card-image" style="background-image: linear-gradient(to top, #001C93 0%, #000033 70%);background-size:cover;">
  <div class="text-white text-center py-5 px-4">
    <div>
      <h1><a href="/community/">Community</a></h1>
      <p class="lead">Join thousands of users and developers from all around the world. </p>
    </div>
  </div>
</div>

<div class="container">
  <div class="col-md-12 spacer-60">
    <div class="community-content-section">
      <div class="community-content-container slack-content-container">
        <div class="slack-text-container">
          <h2>Join the discussion</h2>
          <p>The Trino community is very active and helpful on Slack, with users and developers from all around the world. If you need help using or running Trino, this is the place to ask. Check out the following channels,
          and find <a href="./slack.html">many more for specific topics</a>.</p>
        </div>
        <div class="slack-stats-container">
          <div class="community-stats">
            <span>8126</span>
            Slack members
          </div>
          <div class="community-stats">
            <span>618</span>
            Weekly active members
          </div>
          <div class="community-stats">
            <span>586</span>
            Contributors
          </div>
        </div>
      </div>
      <div class="slack-channels-top d-flex mb-3">
        <a href="{{site.slack_join}}" class="slack-channel slack-blue-gradient">
          <img src="../assets/images/graphics/community-general.svg">
          Join Trino Slack
        </a>
        <a href="https://trinodb.slack.com/archives/CFLB9AMBN" class="slack-channel slack-pink-gradient">
          <i class="fa fa-home fa-lg"></i>
          #announcements
        </a>
        <a href="https://trinodb.slack.com/archives/CGB0QHWSW" class="slack-channel slack-orange-gradient">
          <i class="fa fa-tools fa-lg"></i>
          #troubleshooting
        </a>
      </div>
      <div class="slack-channels-bottom d-flex">
        <a href="https://trinodb.slack.com/archives/CP1MUNEUX" class="slack-channel slack-orange-gradient">
          <i class="fa fa-code fa-lg"></i>
          #dev
        </a>
        <a href="https://trinodb.slack.com/archives/CFP480UKX" class="slack-channel slack-blue-gradient">
          <i class="fa fa-server fa-lg"></i>
          #releases
        </a>
        <a href="https://trinodb.slack.com/archives/CFQAMGRQE" class="slack-channel slack-pinkorange-gradient">
          <img src="../assets/images/graphics/community-announcements.svg">
          <i class="fa fa-bullhorn fa-lg"></i>
          #beginner
        </a>
      </div>
    </div>
    <div class="community-content-section">
      <h2>Events that don’t suck</h2>
      <div class="community-content-container">
        <a href="./broadcast" class="community-broadcast-block">
          <div class="community-broadcast-image-wrapper">
            <img src="../assets/images/community/tcb.png" alt="Trino Community Broadcast" />
            <img src="../assets/images/community/tcb.gif" alt="Trino Community Broadcast preview" />
          </div>
        </a>
        <div class="events-thirds-container">
          <a href="https://www.meetup.com/pro/trino-community/" class="event-third-block"></a>
          <a href="https://twitter.com/trinodb" class="event-third-block">
            <div>Follow us<h2>@trinodb</h2></div>
            <img src="../assets/images/community/twitter.png" alt="@trinodb on Twitter" />
          </a>
          <a href="https://www.youtube.com/c/trinodb" class="event-third-block">
            <div>Watch the latest videos and past events from the Trino community</div>
            <img src="../assets/images/community/youtube.png" alt="trinodb on YouTube" />
          </a>
        </div>
      </div>
    </div>
    <div class="community-content-section">
      <h2>Contribute</h2>
      <div class="community-content-container contribute-content-container">
        <div class="contribute-text-container">
          <div class="contribute-github-button d-flex flex-row">
            <a class="github-button" href="https://github.com/trinodb" data-size="large" aria-label="Follow @trinodb on GitHub">Follow @trinodb</a>
            <a class="github-button" href="https://github.com/trinodb/trino" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star trinodb/trino on GitHub">Star</a>
          </div>
          <p>Help build the next generation of fast, distributed SQL query engines for big data analytics. Trino is maintained by hundreds of people around the globe. Over the years, the Trino project has developed an extensive vision of the software and a strong development philosophy.</p>
          <p>Understanding these helps you get up to speed on the software and how the project works quickly.</p>
          <p><a href="../development/vision.html">Read more about the project vision and development philosophy.</a></p>
        </div>
        <div class="d-flex flex-column" style="flex: 1 1 50%;">
          <div class="contribute-thirds-container">
            <div class="circle-icon-container circle-bugs">
              <i class="fa fa-bug fa-lg"></i>
            </div>
            <div>
              <h3>Find and report issues</h3>
              <p>Found a bug? Help us by filing an issue on GitHub.</p><p>For security vulnerabilities, alert us by emailing <a href="mailto:security@trino.io">security@trino.io</a></p>
              <a class="github-button" href="https://github.com/trinodb/trino/issues" data-icon="octicon-issue-opened" data-size="large" data-show-count="true" aria-label="Issue trinodb/trino on GitHub">Issue</a>
            </div>
          </div>
          <div class="contribute-thirds-container">
            <div class="circle-icon-container circle-docs">
              <i class="fa fa-pencil-alt fa-lg"></i>
            </div>
            <div>
              <h3>Write documentation</h3>
              <p>Contributions are not just about code. Help the community understand how to use our distributed SQL engines by adding to <a href="../docs/current/">our docs</a>. See our <a href="https://github.com/trinodb/trino/tree/master/docs">README</a> for more information.</p>
            </div>
          </div>
          <div class="contribute-thirds-container">
            <div class="circle-icon-container circle-pr">
              <i class="fa fa-code-branch fa-lg"></i>
            </div>
            <div>
              <h3>Open a pull request</h3>
              <p>Improve existing functionality, or even add your own feature.</p>
              <p>Read about our <a href="../development/process.html">contribution process</a> or visit our <a href="../docs/current/develop.html">developer guide</a> to learn more.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="community-content-section">
      <h2>Trino contributors</h2>
      <p>A huge amount of gratitude goes out to all contributors. Without you, none of this is possible.</p>
        <object type="image/svg+xml" data="../assets/images/community/contributors.svg"></object>
    </div>
  </div>
</div>
<script async defer src="https://buttons.github.io/buttons.js"></script>
