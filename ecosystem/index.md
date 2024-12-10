---
layout: default
title: Ecosystem
show_hero: true
show_pagenav: true
---

The ecosystem of integrations with Trino includes the [client
drivers](#client-drivers), [client applications](#client-applications),
connectors for [data sources](#data-sources), and [add-ons](#add-ons). They are
developed and maintained by the Trino community as well as other communities and
vendors.

## Client drivers

{% include_relative client-drivers-intro.md %}

### Official client drivers

{% assign category="client-driver" %}
{% assign owner="trinodb" %}
{% include toolsgrid.html %}

### Other client drivers

{% assign category="client-driver" %}
{% assign owner="other" %}
{% include toolsgrid.html %}

<br>

## Client applications

{% include_relative client-applications-intro.md %}

### Official client applications

{% assign category="client-application" %}
{% assign owner="trinodb" %}
{% include toolsgrid.html %}

### Other client applications

{% assign category="client-application" %}
{% assign owner="other" %}
{% include toolsgrid.html %}

<br>

## Data sources

{% include_relative data-sources-intro.md %}

### Official data sources

{% assign category="data-source" %}
{% assign owner="trinodb" %}
{% include toolsgrid.html %}

### Other data sources

{% assign category="data-source" %}
{% assign owner="other" %}
{% include toolsgrid.html %}

<br>

## Add-ons

{% include_relative add-ons-intro.md %}

### Official add-ons

{% assign category="add-on" %}
{% assign owner="trinodb" %}
{% include toolsgrid.html %}

### Other add-ons

{% assign category="add-on" %}
{% assign owner="other" %}
{% include toolsgrid.html %}
