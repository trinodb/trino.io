---
layout: default
title: Trino Community Broadcast
show_hero: true
---

<div class="container container__broadcast">
<div class="row spacer-60">
<div markdown="1" class="col-lg-8">

## About

With great data comes even greater access latency. Welcome to the Trino
Community Broadcast where we transform your latency woes to fast insights. Trino
Community Broadcast is a show where we cover events and happenings within the
open-source Trino community and show off some cool stuff about
Trino.

Trino nation, We want to hear from you! If you have a question or pull request
that you would like us to feature on the show please join the [Trino
slack]({{site.url}}/slack) and go to the `#trino-community-broadcast` channel
and let us know there. Otherwise, you can message Manfred Moser or Brian Olsen
directly on Slack or Twitter.

See us live every two weeks!

</div>
<div markdown="1" class="col-lg-3">

## Co-hosts

- Brian Olsen [@bitsondatadev](https://twitter.com/bitsondatadev)
- Manfred Moser [@simpligility](https://twitter.com/simpligility)

## Watch or listen

- Watch:
<a href="https://www.youtube.com/playlist?list=PLFnr63che7war_NzC7CJQjFuUKLYC7nYh" target="_blank">
  <i class="fab fa-youtube watch-listen-icon" title="Youtube"></i>
</a>
<a href="https://www.twitch.tv/trinodb" target="_blank">
  <i class="fab fa-twitch watch-listen-icon" title="Twitch"></i>
</a>
- Listen:
<a href="https://podcasts.apple.com/us/podcast/trino-community-broadcast/id1533484786" target="_blank">
  <i class="fab fa-apple watch-listen-icon" title="Apple"></i>
</a>
<a href="https://podcasts.google.com/feed/aHR0cHM6Ly9mZWVkcy5idXp6c3Byb3V0LmNvbS8xMzc0NTMyLnJzcw==" target="_blank">
  <i class="fab fa-google watch-listen-icon" title="Google"></i>
</a>
<a href="https://open.spotify.com/show/53ZrVCCmZSsEmvlNfzpWSL" target="_blank">
  <i class="fab fa-spotify watch-listen-icon" title="Spotify"></i>
</a>
- <a href="{{ '/broadcast/feed.xml' | relative_url }}">Subscribe via RSS</a>

</div>
<div markdown="1" class="col-md-12">

## Upcoming shows

<iframe src="https://calendar.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23dd00a1&amp;ctz=America%2FDetroit&amp;src=NDhibXJvaXVpZmg2NWJsZWNhOGxzNGhyNTRAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;color=%23D81B60&amp;mode=AGENDA&amp;showCalendars=0&amp;showTz=1&amp;showTabs=0&amp;showPrint=0" style="border:solid 1px #777; margin-bottom: 2rem;" width="100%" height="240" frameborder="0" scrolling="no"></iframe>

## Latest episode

{% assign latestEpisode =  site.episodes | last %}

<div class="post-entry card latest-entry">
  <div class="d-flex flex-column-reverse flex-lg-row justify-content-between">
    <div class="latest-entry-text-container">
      <h3><a class="post-link" href="{{ episode.url | relative_url }}">{{ latestEpisode.title | escape }}</a></h3>
      <span class="post-meta">{{ latestEpisode.date | date: "%b %-d, %Y" }}</span>
      <ul>
        {% for section in latestEpisode.sections %}
        <li>
            {{section.title}}:
            <a href="https://www.youtube.com/watch?v={{ latestEpisode.youtube_id}}&t={{ section.time }}s" target="_blank">
            {{ section.desc }}
            </a>
        </li>
        {% endfor %}
      </ul>
      <a href="{{ site.baseurl }}{{ latestEpisode.url }}" style="margin-top: auto;">Listen, watch, or read the show notes...</a>
    </div>
    <div class="latest-entry-video-container">
        <div class="latest-entry-video-wrapper">
          <iframe src="https://www.youtube.com/embed/{{ latestEpisode.youtube_id }}" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
  </div>
</div>

<div markdown="1" class="previous-episode-header">

## Previous episodes

<a href="/broadcast/episodes.html">See all episodes</a>
</div>
<div class="episode-grid">
{% for episode in site.episodes reversed offset:1 limit:9 %}
  <div class="post-entry card">
    <h5><a class="post-link" href="{{ episode.url | relative_url }}">{{ episode.title | escape }}</a></h5>
    <span class="post-meta">{{ episode.date | date: "%b %-d, %Y" }}</span>
    <ul>
      {% for section in episode.sections limit:3 %}
      <li>
          {{section.title}}:
          <a href="https://www.youtube.com/watch?v={{ episode.youtube_id}}&t={{ section.time }}s" target="_blank">
          {{ section.desc }}
          </a>
      </li>
      {% endfor %}
    </ul>
    <a href="{{ site.baseurl }}{{ episode.url }}">Listen, watch, or read the show notes...</a>
  </div>
{% endfor %}
</div>

</div>
</div>
</div>
