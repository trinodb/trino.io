---
layout: blog
title: Blog archives
---

<div class="content container clearfix spacer-30">

<!-- Ensures table of contents isn't displayed on this page, don't remove. -->
<!-- No TOC -->

<div class="row blog-page">
  <div class="col-12 text-surface-medium">
    <h2>{{ page.title}}</h2>
    <p class="subtitle-1">The complete list of posts from the Trino team</p>
  </div>
</div>

<div class="row blog-page">
  <div class="col-12">
    {% for post in site.posts %}
      <hr />
      <div class="archive-row">
        <div>
          <p class="overline">{{ post.date | date: "%-d %B %Y" }}</p>
          <h4 class="archives-title-link"><a href="{{ post.url }}">{{ post.title}}</a></h4>
          <p class="caption">{{ post.author }} </p>
        </div>
        <!-- {% if post.image %}
          <div class="archive-post-img">
            <img src="{{ post.image }}">
          </div>
        {% endif %} -->
      </div>
    {% endfor %}
  </div>
</div>
<div class="spacer-60"></div>

</div>
