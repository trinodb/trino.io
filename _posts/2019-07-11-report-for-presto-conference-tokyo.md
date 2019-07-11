---
layout: post
title:  "A Report of First Ever Presto Conference Tokyo"
author: Kai Sasaki, Arm Treasure Data
excerpt_separator: <!--more-->
---

Nowadays, Presto is getting much attraction from the various kind of companies all around the world. Japan is not an exception. Many companies are using Presto as their primary data processing engine.

To keep in touch with each other among the community members in Japan, we have just held the first ever Presto conference in Tokyo with welcoming Presto creators, [Dain Sundstrom](https://github.com/dain), [Martin Traverso](https://github.com/martint) and [David Phillips](https://github.com/electrum). The conference was hosted at the Tokyo office of [Arm Treasure Data](https://www.treasuredata.com/). This article is the summary of the conference aiming to convey the excitement in the room.

![](/assets/blog/presto-conference-tokyo/overall-view.jpg)

<!--more-->

# Presto: Current and Future

First of all, Presto creators introduced their work in these days and software foundation launched in the last year. They covered the following changes and enhancements achieved by the community recently.

* Presto Software Foundation
* New Connectors
  * Phoenix
  * Elasticsearch
  * Apache Ranger

Attendees can also learn several plans that will happen shortly.

* The plan to support more complex pushdown to connectors
* Case-sensitive identifier
* Timestamp semantics
* Dynamic filtering
* Connectors such as Iceberg, Kinesis, Druid.
* Coordinator high availability


# Reading The Source Code of Presto

To make attendees get used to the technical talk about Presto in the conference, [Leo](https://github.com/xerial) provided a guide for walking around the source code of Presto code. Since the Presto source code repository is enormous, it must be helpful as a leader to help developers explore the forest of the codebase.

<div style='text-align: center;'>
<iframe src="//www.slideshare.net/slideshow/embed_code/key/vTpEZFzu03tVhv" width="440" height="330" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/taroleo/reading-the-source-code-of-presto" title="Reading The Source Code of Presto" target="_blank">Reading The Source Code of Presto</a> </strong> from <strong><a href="https://www.slideshare.net/taroleo" target="_blank">Taro L. Saito</a></strong> </div>
</div>

# Presto At Arm Treasure Data

Then [Kai](https://github.com/Lewuathe) (it's me) provides an overview of how Arm Treasure Data uses Presto in their service. Presto is heavily used to support many enterprise use cases, including IoT data analysis, and it is becoming the hub component processing high throughput workload from many kinds of clients such as Spark, ODBC and JDBC.

<div style='text-align: center;'>
<iframe src="//www.slideshare.net/slideshow/embed_code/key/cVfDINF85hx0Vx" width="440" height="330" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/taroleo/presto-at-arm-treasure-data-2019-updates" title="Presto At Arm Treasure Data - 2019 Updates" target="_blank">Presto At Arm Treasure Data - 2019 Updates</a> </strong> from <strong><a href="https://www.slideshare.net/taroleo" target="_blank">Taro L. Saito</a></strong> </div>
</div>

# Large Scale Migration from Hive to Presto in Yahoo! JAPAN

We could learn how hard to migrate large scale workload from Hive to Presto from the presentation given by [Start]() from Yahoo Japan. Quite a few people seem to be interested in the tool they have created to convert HiveQL into Presto SQL. They might have faced the same type of challenges.

<div style='text-align: center;'>
<iframe src="//www.slideshare.net/slideshow/embed_code/key/ld3tI0uIzAQe1" width="440" height="330" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/techblogyahoo/large-scale-migration-fromhive-to-presto-at-yahoo-japan" title="Large scale migration fromHive to Presto at Yahoo! JAPAN" target="_blank">Large scale migration fromHive to Presto at Yahoo! JAPAN</a> </strong> from <strong><a href="https://www.slideshare.net/techblogyahoo" target="_blank">Yahoo!デベロッパーネットワーク</a></strong> </div>
</div>

# Presto At LINE

LINE is the biggest company providing the mobile communication tool in Japan. (say WhatsApp in Japan). [Wataru Yukawa](https://github.com/wyukawa), [Yuya Ebihara](https://github.com/ebyhr) gave us how they can improve their platform with collaborating with the community. We could find difficulty and challenge primarily provoked by the dependencies on other Hadoop ecosystems such as HDFS and Spark.

<div style='text-align: center;'>
<iframe src="//www.slideshare.net/slideshow/embed_code/key/Hx9oz6Pi1su5rj" width="440" height="330" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/wyukawa/presto-conferencetokyo2019" title="Presto conferencetokyo2019" target="_blank">Presto conferencetokyo2019</a> </strong> from <strong><a href="https://www.slideshare.net/wyukawa" target="_blank">wyukawa </a></strong> </div>
</div>

One notable thing in the session was the question about the discussion of how to make the error message excellent provided by Presto. David and creators are genuinely caring about the error message shown by the system. To reduce the time consumed to deal with the inquiry about the error, improving the error message is one of the best options. That's the primary reason to maintain the error message easy to understand.

# Q&A Session

At the end of the conference, attendees got a chance to freely ask Presto creators about a bunch of topics not only Presto technical thing but also their working style, or thoughts. Here is a part of the list of Q&A talked at the conference.

Q: What do you expect most from Japan community?
> Considering the communication in the Israel community, gaining the diversity of the use case will make Presto better. We are expecting that kind of diversity. Japan surely has a unique community to solve the difficulty. Having a Japanese slack channel might be a good idea to help each other :)

Q: How do you review the pull request code? How to keep the quality of the code review process?
> Code review difficulty depends on the complexity of PR itself. We use IntelliJ intensively to read the code base. There are mainly two things to keep the code review quality. One is that involving the actual code review will make you a good reviewer. Another thing is automating minor checks such as code style. These things are helpful to keep the code review process functional.

> Make it readable is the most important thing in the Presto codebase.
- Do not use the abbreviation and slung because not everyone can understand these words at a glance
- Write comment -> Write code -> Delete comment. That is the process to make the code readable itself.

Q: SQL on Everything approach vs. pursuing the performance. Which direction should Presto move forward?
> It depends on the community decision. However, along with the discussion with several companies in the community, even not a single company does not show much concern about the performance of Presto.

# Wrap Up

This conference was the first ever Presto conference inviting the Presto creators in Tokyo. We were able to have an exciting discussion with the community developers and creators. One of the great things we could find in the conference was the enthusiasm of creators to make Presto usable by every developer. They are genuinely caring about the error message checked by users, code quality read by developers. Thanks to this type of good usability from the viewpoint of both users and developers, Presto keeps gaining attraction from the community.

That was a great time to have many conversations with the community members. We really appreciate developers in the community and creators. Thank you so much for coming to the conference and see you next time!


# Reference

* [Presto Conference Tokyo 2019](https://techplay.jp/event/733772)
* [Reading The Source Code of Presto](https://www.slideshare.net/taroleo/reading-the-source-code-of-presto)
* [Presto At Arm Treasure Data - 2019 Updates](https://www.slideshare.net/taroleo/presto-at-arm-treasure-data-2019-updates)
* [Large Scale Migration from Hive to Presto in Yahoo! JAPAN](https://www.slideshare.net/techblogyahoo/large-scale-migration-fromhive-to-presto-at-yahoo-japan)
* [Presto At LINE](https://www.slideshare.net/wyukawa/presto-conferencetokyo2019)
