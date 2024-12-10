Clients applications allow you to connect to Trino, submit SQL queries, and
receive the results. Client applications can access all [configured data sources
in catalogs]({{site.baseurl}}/ecosystem/index.html#data-sources).

Client applications include command line tools, desktop applications, web-based
applications, and software-as-a-service solutions. Common features are
interactive SQL query authoring with editors, rich user interfaces for graphical
query creation, query running and result rendering, visualizations with charts
and graphs, reporting, and dashboard creation.

You can use client applications for data pipelines in Trino including across
catalog. Client applications that support other data sources can be used in data
pipelines connecting them with Trino catalogs.

Client applications use [client
drivers]({{site.baseurl}}/ecosystem/client-driver.html) as wrappers around the
[client protocol]({{site.baseurl}}/docs/current/client/client-protocol.html) or
the client protocol directly.