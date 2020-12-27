---
layout: blog
title: Trino blog
---

<div class="content container clearfix spacer-30">

<div class="row blog-page">
  <div class="col-12">
    {% for post in site.posts limit:1 %}
      <div class="latest-blog card">
        <div>
          <p style="font-weight:600;">The Latest</p>
          <h3 class="blog-title"><a href="{{ post.url }}">{{post.title}}</a></h3>
          <p class="caption">{{ post.date | date_to_string }} | {{ post.author }}</p>
          <p>{{ post.excerpt }}</p>
          <div class="blog-readmore"><a href="{{ post.url }}">Read More &rarr;</a></div>
        </div>
        <div>
          {% if post.image %}
            <img src="{{ post.image }}">
           {% endif %}
        </div>
      </div>
    {% endfor %}
    <h3>Recent</h3>
    <div class="blog-cards">
      {% for post in site.posts offset:1 limit:6 %}
        <div class="card post-card square">
          <!-- Card content -->
          <div class="card-body">
            <!-- Title -->
            <h4 class="card-title"><a href="{{ post.url }}">{{post.title}}</a></h4>
            <p class="caption">{{ post.date | date_to_string }} | {{ post.author}}</p>
            <!-- Text -->
            <p class="card-text">{{ post.excerpt | strip_html | truncatewords: 30 }}</p>
            <div class="blog-readmore"><a href="{{ post.url }}">Read More &rarr;</a></div>
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
