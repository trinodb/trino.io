---
layout: default
title: Trino Community Broadcast
show_hero: true
---

<div class="container container__broadcast">
<div class="row spacer-60">
<div markdown="1" class="col-lg-8">

The Trino Community Broadcast is a show about the Trino project and community.
Topics include the data sources, clients, add-ons, platforms and usages of
Trino. We interview users, contributors, partners, and other community members
about their connection to Trino, look at demos together, and chat about the tech
stacks, the code, and often explain concepts along the way.

Each episode also brings you news about the latest releases, events, and
interesting developments in the ecosystem around Trino.

## Upcoming episodes

<dl>
<dt>13 Mar 2025: Trino Community Broadcast 72 - Keeping the lake clean</dt>

<dt>27 Mar 2025: Trino Community Broadcast 73 - Wrapping Trino packages with a bow</dt>
<dd><a href="https://www.linkedin.com/in/manfredmoser">Manfred Moser</a> talks
about his recent work to improve Trino packaging and demos how to create your 
own RPM, tarball, and container image.</dd>

</dl>

Find [more details and other events on our calendar]({{site.url}}/community.html#events).

Trino users, contributors, and partners, we want to hear from you! If you have a
topic, question or pull request that you would like us to feature on the show
join the [Trino slack]({{site.url}}/slack) and contact us there.

</div>
<div markdown="1" class="col-lg-4">

## Hosts

- [Manfred Moser](https://www.linkedin.com/in/manfredmoser), main organizer and host
- [Cole Bowden](https://www.linkedin.com/in/cole-m-bowden), co-host

## Watch

<a href="https://www.youtube.com/playlist?list=PLFnr63che7war_NzC7CJQjFuUKLYC7nYh" target="_blank">
  <i class="fab fa-youtube fa-3x fa-fw watch-listen-icon" title="Youtube"></i>
</a>
<a href="https://www.twitch.tv/trinodb" target="_blank">
  <i class="fab fa-twitch fa-3x fa-fw watch-listen-icon" title="Twitch"></i>
</a>
<a href="https://www.linkedin.com/company/trino-software-foundation/events/" target="_blank">
  <i class="fab fa-linkedin fa-3x fa-fw watch-listen-icon" title="LinkedIn"></i>
</a>

Watch live on any platform to ask questions.

## Listen

<a href="https://open.spotify.com/show/52YXvNXAgf7xlW6FqTR29f" target="_blank">
  <i class="fab fa-spotify fa-3x fa-fw watch-listen-icon" title="Spotify"></i>
</a>
<a href="https://podcasts.apple.com/us/podcast/trino-community-broadcast/id1533484786" target="_blank">
  <i class="fab fa-apple fa-3x fa-fw watch-listen-icon" title="Apple"></i>
</a>

## Subscribe

<a href="{{site.baseurl}}/community.html#events">
  <i class="fa fa-calendar fa-3x fa-fw watch-listen-icon" title="Calendar"></i>
</a>
<a href="{{site.baseurl}}/broadcast/feed.xml" target="_blank">
  <i class="fa fa-rss fa-3x fa-fw watch-listen-icon" title="RSS feed"></i>
</a>
<a href="https://www.linkedin.com/company/trino-software-foundation/events/" target="_blank">
  <i class="fab fa-linkedin fa-3x fa-fw watch-listen-icon" title="LinkedIn events"></i> 
</a>

</div>
<div markdown="1" class="col-md-12">

## Latest episode

{% assign latestEpisode =  site.episodes | last %}

<div class="post-entry card latest-entry">
  <div class="d-flex flex-column-reverse flex-lg-row justify-content-between">
    <div class="latest-entry-text-container">
      <h3><a class="post-link" href="{{ latestEpisode.url | relative_url }}">{{ latestEpisode.title | escape }}</a></h3>
      <span class="post-meta">{{ latestEpisode.date | date: "%b %-d, %Y" }}</span>
      {% if latestEpisode.introduction != nil %}
        <p>{{latestEpisode.introduction}}</p>
      {% endif %}
      <ul>
      {% for section in latestEpisode.sections %}
        <li>
          <a href="https://www.youtube.com/watch?v={{ latestEpisode.youtube_id }}&t={{ section.time }}s" target="_blank">
          {% if section.desc == nil %}
            {{section.title}} ({{ section.time }}s)
          {% else %}
            {{section.title}}: {{ section.desc }} ({{ section.time }}s)
          {% endif %}
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

<div class="previous-episode-header">
<h2>Previous episodes</h2>
<a class="btn btn-pink" style="margin-left: 10em;"
  href="{{site.baseurl}}/broadcast/episodes.html">or see all episodes</a>
</div>

<div class="episode-grid">
{% assign offsetNumber = site.episodes.size | minus: 10 %}
{% for episode in site.episodes reversed offset:offsetNumber %}
{% if forloop.first == true %}
 {% continue %}
{% else %}
  <div class="post-entry card">
    <h5><a class="post-link" href="{{ episode.url | relative_url }}">{{ episode.title | escape }}</a></h5>
    <span class="post-meta">{{ episode.date | date: "%b %-d, %Y" }}</span>
    {% if episode.introduction != nil %}
      <p>{{episode.introduction}}</p>
    {% endif %}
    <ul>
    {% for section in episode.sections limit:5 %}
      <li>
        <a href="https://www.youtube.com/watch?v={{ episode.youtube_id }}&t={{ section.time }}s" target="_blank">
        {% if section.desc == nil %}
          {{section.title}} ({{ section.time }}s)
        {% else %}
          {{section.title}}: {{ section.desc }} ({{ section.time }}s)
        {% endif %}
        </a>
      </li>
    {% endfor %}
    </ul>
    <a href="{{ site.baseurl }}{{ episode.url }}">Listen, watch, or read the show notes...</a>
  </div>
{% endif %}
{% endfor %}

<a class="btn btn-pink" href="{{site.baseurl}}/broadcast/episodes.html">See all episodes</a>
</div>

</div>
</div>
</div>
