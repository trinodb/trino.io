---
layout: page
menu_id: download
title: Download
version: 308
---

<div>
  <h2>Current release</h2>
  <p>
      The current Presto release is version <b>{{ page.version }}</b>.
      See <a href="docs/current/release/release-{{ page.version }}.html">release notes</a>.
  </p>
</div>

<div class="feature-grid">
  <div>
    <h2>Server</h2>
    <p>
        See <a href="docs/current/installation/deployment.html">Deploying Presto</a>
        for complete deployment instructions.
    </p>
    <p>
        <a class="button" href="https://repo1.maven.org/maven2/io/prestosql/presto-server/{{ page.version }}/presto-server-{{ page.version }}.tar.gz"><img src="/assets/icon-download.png" />presto-server-{{ page.version }}.tar.gz</a>
    </p>
  </div>
  <div>
    <h2>Command Line Interface</h2>
    <p>
        You can run queries using the interactive
        <a href="docs/current/installation/cli.html">Command Line Interface</a>.
    </p>
    <p>
        <a class="button" href="https://repo1.maven.org/maven2/io/prestosql/presto-cli/{{ page.version }}/presto-cli-{{ page.version }}-executable.jar"><img src="/assets/icon-download.png" />presto-cli-{{ page.version }}-executable.jar</a>
    </p>
  </div>
  <div>
    <h2>JDBC Driver</h2>
    <p>
        Connect to Presto from Java using the
        <a href="docs/current/installation/jdbc.html">JDBC Driver</a>.
    </p>
    <p>
        <a class="button" href="https://repo1.maven.org/maven2/io/prestosql/presto-jdbc/{{ page.version }}/presto-jdbc-{{ page.version }}.jar"><img src="/assets/icon-download.png" />presto-jdbc-{{ page.version }}.jar</a>
    </p>
  </div>
</div>
