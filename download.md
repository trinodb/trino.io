---
layout: default
menu_id: download
title: Get started with Trino
show_hero: true
---

<div class="container">
  <div class="row spacer-60">
    <div class="col-md-12 text-center">
       <p>The current Trino release is version <b>{{ site.trino_version }}</b>.
        Learn more details from the <a href="docs/current/release/release-{{ site.trino_version }}.html">
        release notes</a>.</p>
    </div>
  </div>
    <!-- Card deck -->
    <div class="card-deck spacer-30">
    <div class="card mb-4">
        <div class="card-body text-center">
            <h3 class="card-header-title mb-3">Server package</h3>
            <p class="card-text">See <a href="docs/current/installation/deployment.html">Deploying 
            Trino</a> for complete deployment instructions.</p>
            <!-- Download button -->
            {% download presto-server .tar.gz %}
            {% download presto-server-rpm .rpm %}
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-body text-center">
            <h3 class="card-header-title mb-3">Command line client</h3>
            <p class="card-text">You can run queries using the interactive <a href="docs/current/installation/cli.html">
            command line interface</a>.</p>
            <!-- Download button -->
            {% download presto-cli -executable.jar %}
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-body text-center">
            <h3 class="card-header-title mb-3">JDBC driver</h3>
            <p class="card-text">Connect to Trino from Java using the <a href="docs/current/installation/jdbc.html">
            JDBC driver</a>, which is available in
            <a href="https://search.maven.org/artifact/io.prestosql/presto-jdbc/{{ site.trino_version }}/jar">Maven Central</a>.</p>
            <!-- Download button -->
            {% download presto-jdbc .jar %}
        </div>
    </div>
    <!-- Card -->
    </div>
    <!-- Card deck -->
</div>


<div class="container spacer-60">

<a name="more"></a>

<div class="row spacer-60">
<div class="col-md-6">

<div markdown="1" class="leftcol widecol">
## Community resources

* **Chat on Slack:** [{{site.slack_fqdn}}](slack.html)
* **Issues:** [GitHub issues]({{site.github_repo_url}}/issues)
* **Twitter:**
  [@{{site.twitter_user}}](https://twitter.com/{{site.twitter_user}})
  [#{{site.twitter_hashtag}}](https://twitter.com/search?q=%23{{site.twitter_hashtag}})
  [#prestosql](https://twitter.com/search?q=%23prestosql)
  [#prestodb](https://twitter.com/search?q=%23prestodb)
* **Live show and podcast:** [Trino Community Broadcast](/broadcast/)
* **YouTube:** [Trino Channel](https://www.youtube.com/channel/UCpqxUwvIA6vaXW45KO1GMhA)
* **Mailing list:** [presto-users](https://groups.google.com/group/presto-users) (legacy, Slack is preferred)


</div>
</div>

<div class="col-md-6">
<div markdown="1" class="leftcol widecol">

## Getting help

If you need help using or running Trino, please ask a question on
[Slack](slack.html).
Please [report]({{site.github_repo_url}}/issues/new)
any issue you find with Trino.

## Guidelines

* [Code of conduct](individual-code-of-conduct.html) for individuals
* [Guidelines](guidelines-corporate.html) for participants with corporate interests

</div>
</div>


<div class="container">
  <div class="row spacer-60">
    <div class="col-md-12 text-center">
      <h2>External resources</h2>
    </div>
  </div>
  <div class="spacer-30"></div>
  <!-- Card deck -->
  <div class="card-deck spacer-30">
    <!-- Card -->
    <div class="card mb-4">
        <div class="card-body text-center">
          <h3 class="card-header-title mb-3">Books</h3>
            <p class="card-text"><a href="/presto-the-definitive-guide.html">Presto: The Definitive Guide</a><br />
            SQL at Any Scale, on Any Storage, in Any Environment</p>
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-body text-center">
        <h3 class="card-header-title mb-3">Research papers</h3>
            <p class="card-text"><a href="paper.html">Presto: SQL on Everything</a></p>
            <p class="card-text"><a href="http://vldb.org/pvldb/vol12/p2170-tan.pdf">Choosing A Cloud DBMS: Architectures and Tradeoffs</a></p>
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-body text-center">
          <h3 class="card-header-title mb-3">Starburst newsletter</h3>
            <p class="card-text">Monthly newsletter on Trino and surrounding technologies.</p>
            <p class="card-text"><a href="https://www.starburstdata.com/presto-newsletter/">Subscribe</a></p>
        </div>
    </div>
  </div>
</div>