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

{% assign category="client-driver" %}
{% include toolsgrid.html %}

<br>

## Client applications

{% include_relative client-applications-intro.md %}

{% assign category="client-application" %}
{% include toolsgrid.html %}

<br>

## Data sources

{% include_relative data-sources-intro.md %}

{% assign category="data-source" %}
{% include toolsgrid.html %}

<br>

## Add-ons

{% include_relative add-ons-intro.md %}

{% assign category="add-on" %}
{%- include toolsgrid.html -%}
