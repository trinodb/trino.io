---
layout: post
title: "Zero-cost reporting"
author: "Jan Waś, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Starburst.png
show_pagenav: false
---

Let's say you have some data. Maybe it's in a spreadsheet, a CSV file, a
relational database, or multiple terabytes of data in an S3 bucket. You need
to run SQL queries on this data, and you'd like to share those results with your
teammates, coworkers, and partner teams, but you want to do it in a way that
allows everyone to view those results on-demand, on the web, and with the latest
results without the need for any manual effort on your part.

<!--more-->

{% youtube 586qvEyuO_U %}

## Recap

There are a lot of tools that might be able to do this for you, but whatever you
choose, you'll need to spend time or money to set it up, and you don't want to
spend a lot. With so many options, there's the possibility of getting stuck in
analysis paralysis, and trying to find the best way forward may leave you
stymied. Jan Waś from Starburst has a suggestion: keep it simple with Trino,
plaintext files, Git, and GitHub actions, and you can set it all up for free.

To start, why put results into plaintext files? With markdown, files are both
human-legible and machine-readable. By saving queries in normal files, it's easy
to see and edit those queries. You can commit your queries and results to Git,
and then you can push them to a service like GitHub, where those files will be
even more readable thanks to the web UI. Then, once on GitHub, you can use the
power of actions to re-run the queries, update your results on a schedule, and
keep things up to date for teammates to view via GitHub Pages. Sound neat? Check
out the talk to see how Jan does it!

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!