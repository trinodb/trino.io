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
        <p class="mr-5 mb-5 lead">Learn about who uses Trino, helps with
        development, and is generally part of our community!</p>
        </div>
    </div>
  </div>
</div>

<div class="container">
<div style="display:flex;">
  {%- include users.html -%}
</div>
<hr class="spacer-30"/>
</div>

<div class="container">

{% for user in site.data.users %}
<div class="row spacer-30">
<a name={{user.anchor}}></a>
  <div class="card">
    <div class="card-body">
      <div class="row">
        <div class="col-md-3 col-s-12 center-image">
          <img src="{{user.logo}}" alt="{{user.name}}" class="img-fluid img-padding">
        </div>
        <div class="col-md-9 col-s-12">
          <h2>{{user.name}}</h2>
          <p>{{user.testimonial}}</p>
          {% if user.urltext == nil %}
            {% capture linktext %}
            View the {{user.name}} website
            {% endcapture %}
          {% else %}
            {% assign linktext = user.urltext %}
          {% endif %}
          {% if user.url == nil %}
          {% else %}
          <p><a href="{{user.url}}" target="_blank">{{linktext}}</a></p>
          {% endif %}
        </div>
      </div>
    </div>
  </div>
</div>
{% endfor %}

<div class="row spacer-30">
  <div class="row">
    <div class="col-md-12 col-s-12">
    <h1>Are you a user too?</h1>
    <p>We are happy to include your testimonial! Contact us on the
      <a href="./slack.html">community chat</a>, and we will get you added.</p>
    </div>
  </div>
</div>

</div>
