---
layout: blog
title: Trino blog
---

<div class="content container clearfix spacer-30">

<div class="row blog-page">
  <div class="col-12">
    {% for post in site.posts limit:3 %}
      <div class="latest-blog card">
        <div>
          <p style="font-weight:600;">The Latest</p>
          <h3 class="blog-title"><a href="{{ post.url }}">{{post.title}}</a></h3>
          <p class="caption">{{ post.date | date_to_string }} | {{ post.author }}</p>
          <p>{{ post.excerpt }}</p>
          <div class="blog-readmore"><a href="{{ post.url }}">Read more &rarr;</a></div>
        </div>
        <div>
          <img src="{{ post.image | default: '/assets/trino-og.png' }}">
        </div>
      </div>
    {% endfor %}
    <h3>Recent</h3>
    <div class="blog-cards">
      {% for post in site.posts offset:3 limit:9 %}
        <div class="card post-card square">
          <!-- Card content -->
          <div class="card-body">
            <!-- Title -->
            <h4 class="card-title"><a href="{{ post.url }}">{{post.title}}</a></h4>
            <p class="caption">{{ post.date | date_to_string }} | {{ post.author}}</p>
            <!-- Text -->
            <p class="card-text">{{ post.description | default: post.excerpt | strip_html | truncatewords: 30 }}</p>
            <div class="blog-readmore"><a href="{{ post.url }}">Read more &rarr;</a></div>
          </div>
        </div>
      {% endfor %}
    </div>
    <hr />
    <h5>
      Want more? Visit the <a href="./archive.html">archives</a>
      or subscribe via <a href="{{ '/blog/feed.xml' | relative_url }}" target="_blank">RSS</a>.
    </h5>
  </div>
</div>
<div class="spacer-60"></div>

</div>
