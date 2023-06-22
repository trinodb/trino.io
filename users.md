---
layout: default
title: Users
---

<div class="homepage-gradient">
  <div class="jumbotron card card-image homepage-gradient homepage-bg">
    <div class="text-white row justify-content-end">
        <div class="col-md-7">
        <h1 class="card-title h1-responsive pt-3 mb-5 font-bold">
            <strong>
                Trino users
            </strong>
        </h1>
        <p class="mr-5 mb-5 lead">Learn about organizations who use Trino, help with
        development, and are generally part of our community!</p>
        </div>
    </div>
  </div>
</div>

<div class="container spacer-30">
  <div style="display:flex;">
    {%- include users.html -%}
  </div>
  <div class="spacer-30">&nbsp;</div>
</div>

<div class="container spacer-30">

{% for user in site.data.users %}

{% if user.anchor == nil %}
{% else %}
<div class="row spacer-30">
<a name="{{user.anchor}}"></a>
  <div class="card" style="width: 100%">
    <div class="card-body">
      <div class="row">
        <div class="col-md-3 col-s-12 center-image">
          <img src="{{user.logo}}" alt="{{user.name}}" class="img-fluid img-padding">
        </div>
        <div class="col-md-9 col-s-12">
          <h2>{{user.name}}</h2>
          <div markdown="1">{{user.testimonial}}</div>
          <ul>
          {% for link in user.links %}
          <li><a href="{{link.url}}" target="_blank">{{link.urltext}}</a></li>
          {% endfor %}
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
{% endif %}
{% endfor %}

<div markdown="1" class="row spacer-60 col-md-12 leftcol widecol">

# Are you a user too?

We are happy to include your testimonial! Contact us on the
[community chat](slack.html), and we will get you added.

</div>
</div>
