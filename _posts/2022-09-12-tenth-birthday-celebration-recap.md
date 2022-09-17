---
layout: post
title: "Trino's tenth birthday celebration recap"
author: "Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-tenth-birthday/creators.jpeg
---

What an exciting month we had in August! August marked the ten-year birthday of
the Trino project. Don't worry if you missed all the excitment as we've
condensed it all in this post.

<!--more-->

## Blog posts

We felt it necessary to chronicle the larger events that happened in the last
decade of the project through the lens of where we are today.

* [Why leaving Facebook/Meta was the best thing we could do for the Trino Community]({% post_url 2022-08-02-leaving-facebook-meta-best-for-trino %})
* [A decade of query engine innovation]({% post_url 2022-08-04-decade-innovation %})
* [Happy tenth birthday Trino!]({% post_url 2022-08-08-trino-tenth-birthday %})

We shared these posts on HackerNews and the Facebook and the query innovation 
posts both hit the front page. This resulted in one of the largest amount of 
page views on the Trino website in a given day - more than 25k views!

![](/assets/blog/trino-tenth-birthday/hn-top.png)

## Trino ten-year timeline video

Another way we celebrated was creating an epic ten-year montage video that
chronicles the incredible journey starting with the Presto project's humble
beginnings, and how it evolved into the success that Trino is today:

<iframe src="https://www.youtube.com/embed/hPD95_-bZZw" width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px;
margin-bottom:5px; max-width: 100%;" allowfullscreen="">
</iframe>

## Birthday celebration with the creators of Trino

To cap things off last month, we hosted a meetup with the creators to reflect
on the last ten years, laugh and listen to some stories from the early days,
talk about the exciting features currently launching, and speculate on the next
ten years of Trino. Here are some highlights you missed:

### Adding dynamic catalogs

Dain discusses what dynamic catalogs could look like in Trino. Currently, to add
catalogs in Trino, you need to add the new catalog configuration file and then
restart Trino. With dynamic catalogs, you can add and remove these catalogs at
runtime with no restart required. There is still no guarantee of exactly when
this feature would arrive, but some of the foundations are currently being 
added. <a href="https://www.youtube.com/clip/UgkxkYmwM6gmw9-GceMUb5IxqIKm0qNXt3fY" target="_blank"> 
<i class="fab fa-youtube" style="color: red;"></i> Dain dives into this a bit
more in this clip</a>

### Vectorization and performance

As more marketing around vectorized databases has come up recently many have
asked if Trino will be following the trend. This question comes up at an
interesting time as 
[Trino now requires Java 17 to run]({{site.url}}/episodes/36.html). Java 17
comes with a lot of capabilities to vectorize, and while we are excited to start
looking into these capabilities, simply updating workloads to use vectorization
doesn't pack the performance punch that many would expect it to. The answer is
more complex:

* Do modern workloads benefit from vectorization? 
  [<i class="fab fa-youtube" style="color: red;"></i>
  See Martin's answer to this](https://www.youtube.com/clip/UgkxmPAur8thP_D-_GpCcg-sqprEAqwWdyck){:target="_blank"}
* Is there a benefit to vectorization over Java's auto-vectorization?
  [<i class="fab fa-youtube" style="color: red;"></i>
  Sometimes, but Dain elaborates on when](https://www.youtube.com/clip/Ugkx1AKbq0jQyZhOH4MKNf3LO4i9kZAmLqpJ){:target="_blank"}
* If not vectorization, what type of performance improvements does Trino focus on?
  [<i class="fab fa-youtube" style="color: red;"></i>
  Martin and Dain list some simple but impactful ones](https://www.youtube.com/clip/UgkxQwDYDS6evVJelNVjWAgrIhzg_Q-cAEyq){:target="_blank"}
* The debate around query time optimization versus runtime adaption.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Which should you optimize first?](https://www.youtube.com/clip/Ugkxt5ryTBP-EPEEo_OOcW2PKvNiJkj5n8UR){:target="_blank"}

### Polymorphic table functions

One feature that is top-of-mind for everyone in the Trino project are
[polymorphic table functions]({% post_url 2022-07-22-polymorphic-table-functions %})
or simply "table functions" as Dain prefers to call them.

* What is a table function?
  [<i class="fab fa-youtube" style="color: red;"></i>
  David and Dain discuss standard and polymorphic table functions](https://www.youtube.com/clip/Ugkx62IKgPd_v9eGBaPUHP2hyaRkWSXh8w8h){:target="_blank"}
* Could we rewrite the [Google Sheets connector]({{site.url}}/docs/current/connector/googlesheets)
  as a table function?.
  [<i class="fab fa-youtube" style="color: red;"></i>
  David and Dain discuss how this would work](https://www.youtube.com/clip/UgkxKIhplQHgEULQkSrjKs4M5w8oNdQMJaoL){:target="_blank"}
* Why table functions are so incredibly powerful.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Eric and Dain talk about why PTFs are a game changer](https://www.youtube.com/clip/UgkxQcokpdgPjiuMKMC5-3HwHvlbmZjxAvxe){:target="_blank"}

If you want to learn more about polymorphic table functions, check out the
recent [Trino Community Broadcast episode]({{site.url}}/episodes/38.html) that
covers the potential of these functions in much more detail.

### The early days of Presto and Trino

We wanted to get some insight into what the early days of the project looked
like, and how Martin, Dain, David, and Eric began the daunting task of designing
and building a distributed query engine from scratch. Some of the discussions
were interesting while others were downright hilarious. Here are some steps you
can take to write your own query engine, at least if you want to do it the way
the Trino creators did it:

1. Look up a bunch of research papers to see how others are doing this 📑.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/gkxGjPYZRx8rhtAndyho7AZgsM4e9wG9Jt4){:target="_blank"}
    * Side note: Papers tend to be highly aspirational and skip important fundamentals.
      [<i class="fab fa-youtube" style="color: red;"></i>
      Video](https://www.youtube.com/clip/Ugkx6Hqe5iglsTgrR9hVo9U3ITi8LSxxMu4U){:target="_blank"}
1. Address the real challenges of making a query engine.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/Ugkx57PezuXyRWHrxxxoLaKni6jqFZ-StwY-){:target="_blank"}
1. Take your initial version and just throw it away 😂🗑🚮.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/UgkxJz7zve36QJZZDdtC3S29vI-Ak1jRifAH){:target="_blank"}
1. Expand outside the initial use cases by learning from other companies and
  building community 👥.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/UgkxQrBl0BzOrjvwDcEN4KAAyqehcRUc1tsf){:target="_blank"}
1. Cause a [brownout](https://en.wikipedia.org/wiki/Brownout_(software_engineering))
  on the Facebook network 📉.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/Ugkx6SyQTFgwX_kdeH018VGt2pMUbldvuKtC){:target="_blank"}
1. Realize the system you replaced was actually faster in some cases, but
  for all the wrong reasons ❌🙅.
  [<i class="fab fa-youtube" style="color: red;"></i>
  Video](https://www.youtube.com/clip/UgkxTqBY2nMAALn-OkglE5DT9dHlBuC18qf8){:target="_blank"}

After a lot of the initial work was done, Presto was deployed at Facebook and
soon after open sourced. From here, we know that the velocity of the project
picked up and once the project was independent of Facebook, the features took
off even more. While everything may seem calculated in hindsight, it was a lot
of hard work to grow the community and adoption around Presto and now Trino.
The creators knew they were making a project that would be utilized outside the
walls of Facebook, but
[<i class="fab fa-youtube" style="color: red;"></i>  they could never have 
anticipated the sheer scale of adoption Trino would see](https://www.youtube.com/clip/Ugkxh2J-1bi1rUoBpuld_FAuXYZgz2bvqPPx){:target="_blank"}.

## Conclusion

We hope you enjoyed all the fun we had celebrating these first ten years of the
Trino project. We are thrilled to think of what the following decades will
bring. We'd like to leave you with closing thoughts from Dain:

<iframe src="https://www.youtube.com/embed/6TFLKcF24HM?clip=Ugkx5bFnjvRX0USjk8vgRJdqLwZQo7Ffg0xm&amp;clipt=ELfJ2gEY8o7eAQ" width="800" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px;
margin-bottom:5px; max-width: 100%;" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="">
</iframe>
