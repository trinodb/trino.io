---
layout: post
title:  First Presto Summit in India, Bangalore, September 2019
author: Vijay Mann, Director of Engineering, Qubole
image: /assets/blog/Bangalore-2019/MyPost.png
excerpt_separator: <!--more-->
---


![](/assets/blog/Bangalore-2019/MyPost.png)

[Qubole](https://www.qubole.com/developers/presto-on-qubole/) organized the first ever Presto Summit in India on September 05, 2019. 
Bangalore, as the technology  and startup hub of India was the perfect venue for India’s first Presto Summit. Presto has seen a lot 
of interest and adoption in this (south asia and asia pacific) region, as was evident with the 
turnout in the last two Presto Meetups organized by Qubole over the past year. Courtyard By Marriott, 
on Outer Ring Road (ORR) - a 17 KM stretch that hosts 10% of Bangalore’s working population (around 1 million people), 
as the conference venue proved to be an ideal destination for Presto enthusiasts, several of whom, work in its immediate vicinity.

With 150 attendees from more than 75 companies,  Presto community in India was super excited and 
eager to meet and interact with Presto co-creators - [Martin Traverso](https://www.linkedin.com/in/traversomartin/),
[Dain Sundstrom](https://www.linkedin.com/in/dainsundstrom/) and
[David Phillips](https://www.linkedin.com/in/electrum/), who flew down to Bangalore for this  Event. 


<!--more-->

# Welcome Note by Joydeep Sen Sarma

![](/assets/blog/Bangalore-2019/JE1A1895.JPG)

[Joydeep Sen Sarma](https://www.linkedin.com/in/joydeeps/), co-creator Hive and co-founder Qubole, kicked off the event by welcoming 
Presto co-creators, speakers and all the attendees. He also provided a brief historical perspective 
of Qubole's contributions to Presto and highlighted the importance of Presto in Qubole's customer base. 

# Keynote by Martin, Dain and David
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%201.%20Keynote%20by%20Martin%2C%20David%2C%20Dain.pdf)
[Video](https://youtu.be/viBY8Fa3OjI)

![](/assets/blog/Bangalore-2019/JE1A1911.JPG)

This was followed by the most awaited presentation of the day - 
the keynote from Martin, Dain and David. Martin took the audience through Presto's journey - right from its birth at Facebook, 
to its growth and adoption at Facebook, and finally to the present with the formation of Presto Software Foundation 
for wider community involvement. He also highlighted some of their design choices and some mis-steps they took along the way.


# Presto at Grab
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%202.%20Talk%20by%20Edwin%20Law%20Grab.pdf)
[Video](https://youtu.be/0TR7Nzs8asc)

![](/assets/blog/Bangalore-2019/grab-talk.jpg)

First industry speaker of the day was [Edwin Hui Hean Law](https://www.linkedin.com/in/edwinlawhh/), 
Data Engineering Lead at [Grab, Singapore](https://www.grab.com/sg/). He and his team flew all the way 
from Singapore for Presto Summit - a true testament to their passion and interest in Presto. His talk 
covered Grab’s experience of using Presto on Amazon EMR followed by their migration to Presto on Qubole. 
He provided his insights on the relative pros and cons of these platforms. Final part of his talk covered his 
team’s recent experimentation with Presto on Kubernetes. 


# Read Support for Hive ACID tables in Presto
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%203.%20Talk%20by%20Shubham%20Tagra%20Qubole.pdf)
[Video](https://youtu.be/Q2Nv18ohegA)

![](/assets/blog/Bangalore-2019/JE1A2023.JPG)

Next, [Shubham Tagra](https://www.linkedin.com/in/shubham-tagra-267a5838/), Sr. Staff at [Qubole](https://www.qubole.com/developers/presto-on-qubole/), 
presented his work on providing read support for Hive ACID tables in Presto. This has become increasingly important with the arrival of 
data privacy regulations like GDPR and CCPA that grant users "Right to erasure" and/or "Right to rectification". 
These regulations require that organisations storing user data are obligated to delete or update user data as per user request. 
Hive ACID is a solution available in open source that addresses these problems around delete and updates. 
Shubham’s talk covered why he picked Hive ACID over other options available in open source, as well as 
details of Hive ACID and Presto integration that he added. 


# Presto Optimizations at Zoho Corporation
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%204.%20Talk%20by%20Praveen%20Krishna%20Zoho.pdf)
[Video](https://youtu.be/mffX12yZTaU)

![](/assets/blog/Bangalore-2019/JE1A2072.JPG)

Post lunch, [Praveen Krishna](https://www.linkedin.com/in/praveenkrishna2112/) from [Zoho Corporation](https://www.zohocorp.com/), 
presented a summary of his team’s journey with Presto. In order to serve their teams with a pretty small cluster, 
they had to optimize Presto at various levels. Praveen’s team started by analyzing various phases of query execution 
and their impact on performance. Praveen’s team optimized Presto’s planner and reduced the planning time by 
20-30% for queries involving multiple joins on wide tables. He also highlighted how they have integrated 
Apache Lucene to speed up full text search operation. After several iterations his team came up with a model 
where they maintained the Lucene index for each row group in the ORC itself. For columns with higher null ratio, 
replacing normal blocks with run length encoded blocks reduced memory consumption . With this logic implemented 
in ORC reader and Core Presto, they were able to reduce memory pressure in the cluster . 


# Presto at Walmart Labs
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%205.%20Talk%20by%20Ashish%20Tadose%20Walmart%20Labs.pdf)
[Video](https://youtu.be/wap7Hr7P8Bo)

![](/assets/blog/Bangalore-2019/JE1A2092.JPG)

Second presentation in this session was from [Ashish Kumar Tadose](https://www.linkedin.com/in/ashish-tadose-78773b22/), 
Principal Engineer at [Walmart Labs](https://www.walmartlabs.com/). He gave an overview of how his team is 
using Presto on Google Compute Cloud (GCP). 
He highlighted the challenges associated with querying diverse data sources at Walmart and how his team has 
tackled these challenges using Presto. His talk also described how his team has implemented monitoring, auto scaling, 
caching (via Alluxio), and security policies via Ranger. 


# Presto at InMobi
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%206.%20Talk%20by%20Rohit%20Chatter%20InMobi.pdf)
[Video](https://youtu.be/zEvqrAss7Iw)

![](/assets/blog/Bangalore-2019/JE1A2222.JPG)

Ater a coffee break, [Rohit Chatter](https://www.linkedin.com/in/rohit-chatter-525b62/), CTO at [InMobi](https://www.inmobi.com/), 
provided a historical perspective of how his team has migrated from Hive in private Data centers to Presto on the 
public cloud. His talk covered various aspects of how his team handles autoscaling and workload management on the cloud. 


# Presto Scheduler Changes for Rubix
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%207.%20Talk%20by%20Garvit%20Gupta%2C%20Microsoft%20and%20Ankit%20Dixit%2C%20Qubole.pdf)
[Video](https://youtu.be/x8xIWuQnEFs)

![](/assets/blog/Bangalore-2019/JE1A2258.JPG)
![](/assets/blog/Bangalore-2019/JE1A2248.JPG)
Next, [Garvit Gupta](https://www.linkedin.com/in/garvitg/) from [Microsoft](http://www.microsoft.com) presented his work on 
Presto scheduler changes for data locality and optimized scheduling for caching engines like [RubiX](https://www.qubole.com/rubix/). 
This work was done primarily as part of his internship at Qubole. This talk was co-presented 
by [Ankit Dixit](https://www.linkedin.com/in/ankit-dixit-a725545b/) from [Qubole](https://www.qubole.com/developers/presto-on-qubole/), 
who first gave an overview of the  Rubix caching engine and its architecture.  Garvit highlighted the need for having locality as another dimension 
to be considered while assigning splits to nodes and how this led to the implementation of a new Presto scheduler. 
The new scheduling model manages to prioritize locality while ensuring a uniform distribution of workload to nodes and 
improves efficacy of any data caching framework that you would use with Presto. His talk covered the new scheduler 
changes in detail, and concluded with  performance numbers where he saw upto 9x improvement in cached/local reads with RubiX.


# Presto at MiQ Digital
[Slides](https://go.qubole.com/rs/510-QPZ-296/images/Presto%20Summit%20India%20-%208.%20Talk%20by%20Rohit%20Srivastava%20MIQ.pdf)
[Video](https://youtu.be/nOmI48iqlU4)

![](/assets/blog/Bangalore-2019/JE1A2274.JPG)

Final presentation of the day was from [Rohit Srivastava](https://www.linkedin.com/in/rohitsrivastava20/), 
Engineering Manager at [MiQ Digital](http://www.wearemiq.com/), who presented an overview of Unified Insights & Data 
Analytics platform at MiQ. He highlighted several challenges that his team had to overcome, such as scaling the 
team/infrastructure/company, dealing with data copies, duplication of data pre-processing and the cost and 
effort that goes into it, meeting strict SLAs etc.  He gave an overview of how using Presto on Qubole for all 
dashboarding needs with additions like standardising most of their data to be stored in the Apache Parquet format 
on S3 has helped overcome some of these challenges.


In summary, first Presto Summit in India, had a great mix of  talks - some  were around Presto usage and 
experience of operating large Presto deployments across multiple clouds, while some others focussed on niche 
technical contributions around Presto scheduler changes for data locality, speeding up ORC reader, and read support for 
Hive ACID tables in Presto. Participants had interesting and engaging questions for all the speakers and in general, 
enjoyed interacting with Presto founders, other Presto users and developers in the region.  

Videos and slides for all talks can be found [here](https://go.qubole.com/2019-09-05---FE---Presto-Summit-19-Bangalore_Post-Summit-Videos-LP-2.html
).

We look forward to the next Presto Summit in this region soon!
