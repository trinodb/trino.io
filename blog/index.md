---
layout: blog
---

<div class="home">
  <ul class="post-list">
    {%- for post in site.posts -%}
    <li>
      <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
      <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
      {{ post.excerpt }}
    </li>
    {%- endfor -%}
  </ul>

  <p class="rss-subscribe">
    <a href="{{ '/blog/feed.xml' | relative_url }}">subscribe via RSS</a>
    <svg class="svg-icon"><use xlink:href="{{ '/assets/blog/social-icons.svg#rss' | relative_url }}"></use></svg>
  </p>
</div>
