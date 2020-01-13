---
layout: blog
---

<div class="home">
  {% for post in site.posts %}
    <h1><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h1>
    <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}
    {%- if post.author -%}
    &nbsp;&bull; {{ post.author}}
    {%- endif -%}
    </span>
    {{ post.excerpt }}

    {%- assign excerpt = post.excerpt | strip -%}
    {%- assign content = post.content | remove_first: post.excerpt_separator | strip -%}
    {%- if content != excerpt -%}
      <a href="{{ site.baseurl }}{{ post.url }}">Read more...</a>
    {%- endif -%}

  {% endfor %}

  <p class="rss-subscribe">
    <a href="{{ '/blog/feed.xml' | relative_url }}">subscribe via RSS</a>
    <svg class="svg-icon"><use xlink:href="{{ '/assets/blog/social-icons.svg#rss' | relative_url }}"></use></svg>
  </p>
</div>
