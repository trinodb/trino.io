---
layout: page
menu_id: development
title: Development - Roles
---

<div>
    <h2>Overview</h2>

    <p>
        Everyone is encouraged to participate in the Presto project. Anyone can influence the project by simply being
        involved in the discussions about new features, the roadmap, architecture, and even problems they are facing.
        The various roles described here do not carry more weight in these discussions, and instead we try to always
        work towards consensus. The Presto project has a strong <a href="vision.html">vision and development philosophy</a>
        which helps to guide discussions and normally allows us to reach consensus. When we can't come to consensus,
        we work to figure out what we agree on, and what we don't. Then we move forward by building what we agree on,
        which helps everyone better understand the parts we don't agree on (and hopefully builds empathy at the same time).
    </p>

    <p>
        The following describes the expectations and duties of the various roles.
    </p>

    <h2>Participants</h2>

    <p>
        This is the most important role. Very simply put, participants are those who show up and join in discussions
        about the project. Users, developers, and administrators can all be participants, as can literally anyone who
        has the time, energy, and passion to become involved. Participants suggest improvements and new features. They
        report bugs, regressions, performance issues, and so on. They work to make Presto better for everyone.
    </p>

    <p>
        <b>Expectations and duties:</b>
    </p>

    <p>
    <ul>
        <li>Be involved in discussions about features, roadmaps, architecture, and long-term plans.</li>
        <li>Help other users on the mailing list, on GitHub issues, and on Slack.</li>
        <li>Propose and discuss new features and improvements.</li>
        <li>Help raise the project's quality bar.</li>
        <li>Let everyone else know what isn't working or is confusing.</li>
        <li>Report bugs and performance regressions.</li>
        <li>Suggest improvements to infrastructure and testing.</li>
        <li>Recommend improvements to documentation and the website.</li>
        <li>
            Understand that although English is the language of this project, English is not the first language of
            many participants. Assume positive intent from others and realize that negative sounding comments are
            often unintentional due to language barriers.
        </li>
    </ul>
    </p>


    <h2>Contributors</h2>

    <p>
        A contributor submits changes to Presto. The full contribution process is described <a href="process.html">here</a>.
    </p>

    <p>
        <b>Expectations and duties:</b>
    </p>

    <ul>
        <li>Be empathetic to the reviewers. Reviewing a change can be hard work and time consuming.</li>
        <li>
            Keep commits small when possible and provide reasoning and context when submitting changes. Reviews
            will go smoother if you make the reviewer’s job easier.
        </li>
        <li>
            Be responsive when changes are requested by the reviewer. It is easier to re-review the modified changes
            if they are completed shortly after original review.
        </li>
        <li>Ask for clarification if you are confused by a suggested change.</li>
        <li>Speak up if your contribution appears to be stuck.</li>
        <li>Read the project vision and development philosophy.</li>
        <li>
            Follow the style guidelines and more importantly, follow the Presto coding conventions by matching your
            code to the existing code. Keep in mind the Presto development philosophy is to have all code appear as
            if it were written by a single person.
        </li>
        <li>Sign the contributor license agreement (CLA).</li>
    </ul>

    <h2>Reviewers</h2>

    <p>
        A reviewer reads a proposed change to Presto, and assesses how well the change aligns with the Presto vision
        and guidelines. This includes everything from high level project vision to low level code style. Everyone
        is invited and encouraged to review others' contributions -- you don't need to be a committer for that.
    </p>

    <p>
        <b>Expectations and duties:</b>
    </p>

    <ul>
        <li>
            Be empathetic to contributors. They may have put a lot of effort into the proposed change and may
            not be familiar with the codebase, the process, or the history of the project.
        </li>
        <li>Be responsive to questions.</li>
        <li>Re-review after suggested changes have been applied.</li>
        <li>Be clear about which changes are only suggestions, and which changes are necessary.</li>
        <li>Let the contributor know what is going on, so reviews don't appear to be stuck.</li>
        <li>Raise a discussion when a change does not seem to align with the vision or development philosophy.</li>
        <li>Point out deviations from the code conventions and style guidelines.</li>
        <li>Ask for help reviewing areas you don't understand.</li>
    </ul>

    <h2>Committers</h2>

    <p>
        In Presto, committership is an active job. A committer is responsible for checking in code only after ensuring
        it has been reviewed thoroughly and aligns with the Presto vision and guidelines. In addition to merging code,
        a committer actively participates in discussions and reviews. Being a committer does not grant additional rights
        in the project to make changes, set direction, or anything else that does not align with the direction of the
        project. Instead, a committer is expected to bring these to the project participants as needed to gain consensus.
        Committership is for an individual, so if a committer changes employers, the committership is retained. However,
        if a committer is no longer actively involved in the project, their committer status will be reviewed.
    </p>

    <p>
        <b>Expectations and duties:</b>
    </p>

    <ul>
        <li>Be an active reviewer and participant.</li>
        <li>Know which changes are likely to be controversial, and work to resolve the controversy as early as possible.</li>
        <li>Know when a change needs more reviewers involved.</li>
        <li>Ensure the review of a proposed change is thorough.</li>
        <li>Point out when a contribution appears to be stuck.</li>
        <li>Update release notes when committing changes.</li>
        <li>Follow the CLA and IP policies.</li>
    </ul>

    <p>
        An Apache Hive committer did an excellent write up on their process and much of this aligns with our philosophy
        on committers. <a href="https://cwiki.apache.org/confluence/display/Hive/BecomingACommitter">Read about it</a>.
    </p>

    <h2>Path to Becoming a Committer</h2>

    <ol>
        <li>
            <b>Read:</b> Understand the project values and scope, the development philosophy and guidelines, and the change
            process. These contain necessary background information to be successful in Presto.
        </li>
        <li>
            <b>Contribute:</b> This will help you learn the codebase, and understand the development process. Start with
            something small to become familiar with the process.
        </li>
        <li>
            <b>Review:</b> Once you become familiar with a part of Presto, start reviewing proposed changes to that part.
            A committer will do an additional final review, and this will help you understand what you are missing in your
            reviews. At some point, your first pass reviews will not require additional changes during the final review.
        </li>
        <li>
            <b>Committer:</b> The next step is to demonstrate an understanding of what you know and don’t know. It is common
            for changes to require reviews from multiple committers, since no one person is familiar with all of Presto. We
            are also looking for an understanding of the project values and technical vision. Being a committer means
            reviewing and merging code in your areas of expertise from all contributors. Committership is retained while
            being active in the project.
        </li>
    </ol>
</div>
