Clients applications allow you to connect to Trino, submit SQL queries, and
receive the results. Client applications can access all [configured data sources
in catalogs]({{site.baseurl}}/ecosystem/index.html#data-sources).

Client applications include command line tools, desktop applications, web-based
applications, and software-as-a-service solutions. Common features are
interactive SQL query authoring with editors, rich user interfaces for graphical
query creation, query running and result rendering, visualizations with charts
and graphs, reporting, and dashboard creation.

Client applications can process the returned data from Trino for use in data
pipelines across catalogs and from other data sources to Trino catalogs.

Client applications use [client
drivers]({{site.baseurl}}/ecosystem/client-driver.html) as wrappers around the
[client protocol]({{site.baseurl}}/docs/current/client/client-protocol.html) or
the client protocol directly.