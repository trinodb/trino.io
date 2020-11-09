---
layout: page
title: Presto Community Broadcast Episodes
---

<link rel="stylesheet" href="{{ '/assets/episode/main.css' | relative_url }}">
<div class="home">
  <div>
  </div>
  {% for episode in site.episodes reversed %}
  <div class="post-entry">

    <h1><a class="post-link" href="{{ episode.url | relative_url }}">{{ episode.title | escape }}</a></h1>
    <span class="post-meta">{{ episode.date | date: "%b %-d, %Y" }}
    </span>
    <ul>
          {% for section in episode.sections %}
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

  <p class="rss-subscribe">
    <a href="{{ '/broadcast/feed.xml' | relative_url }}">subscribe via RSS</a>
    <svg class="svg-icon"><use xlink:href="{{ '/assets/blog/social-icons.svg#rss' | relative_url }}"></use></svg>
  </p>
</div>
