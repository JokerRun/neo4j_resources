## [Introduction](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#introduction)

|      | Go here for documentation for APOC for Neo4j version [3.0.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/index30.html) [3.1.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/index31.html) [3.2.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/index32.html) [3.3.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/index33.html) [3.4.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/3.4) [3.5.x](https://neo4j-contrib.github.io/neo4j-apoc-procedures/3.5) |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Documentation Overview](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_documentation_overview)

Main Sections

- [Overview of APOC Procedures & Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#overview)
- [Export / Import](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#export-import)
- [Database Integration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#database-integration)
- [Schema Information and Operations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#schema)
- [Utility Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#utilities)
- [Cypher Execution](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#cypher-execution)
- [Node, Relationship and Path Functions and Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#nodes-relationships)
- [Path Finding](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#path-finding)
- [Virtual Nodes & Relationships (Graph Projections)](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#virtual)

Most Frequently Used

1. [Load JSON](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-json)
2. [Load JDBC](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-jdbc)
3. [apoc.periodic.iterate](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#commit-batching)
4. [Date and Time Conversions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#datetime-conversions)
5. [Map Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#map-functions)
6. [Virtual Nodes/Rels](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#virtual-nodes-rels)

<iframe width="560" height="315" src="https://www.youtube.com/embed/V1DTBjetIfk" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

![apoc](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.gif)

Neo4j 3.x introduced the concept of user-defined procedures and functions. Those are custom implementations of certain functionality, that can’t be (easily) expressed in Cypher itself. They are implemented in Java and can be easily deployed into your Neo4j instance, and then be called from Cypher directly.

The APOC library consists of many (about 450) procedures and functions to help with many different tasks in areas like data integration, graph algorithms or data conversion.

#### [License](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_license)

Apache License 2.0

#### ["APOC" Name history](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_apoc_name_history)

[Apoc](http://matrix.wikia.com/wiki/Apoc) was the technician and driver on board of the Nebuchadnezzar in the Matrix movie. He was killed by Cypher.

**APOC** was also the first bundled [A Package Of Component](http://neo4j.com/blog/convenient-package-neo4j-apoc-0-1-released/) for Neo4j in 2009.

**APOC** also stands for "Awesome Procedures On Cypher"

### [Installation: With Neo4j Desktop](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_installation_with_neo4j_desktop)

APOC is easily installed with [Neo4j Desktop](http://neo4j.com/download), after creating your database just go to the "Manage" screen and the "Plugins" tab. Then click "Install" in the APOC box and you’re done.

![desktop apoc](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/desktop-apoc.jpg)

### [Feedback](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_feedback)

Please provide feedback and report bugs as [GitHub issues](https://github.com/neo4j-contrib/neo4j-apoc-procedures/issues) or join the [Neo4j Community Forum and ask in the APOC & Procedures category](https://community.neo4j.com/c/neo4j-graph-platform/procedures-apoc).

### [Calling Procedures & Functions within Cypher](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_calling_procedures_functions_within_cypher)

User defined **Functions** can be used in **any** expression or predicate, just like built-in functions.

**Procedures** can be called stand-alone with `CALL procedure.name();`

But you can also integrate them into your Cypher statements which makes them so much more powerful.

Load JSON example

```cypher
WITH 'https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/{branch}/src/test/resources/person.json' AS url

CALL apoc.load.json(url) YIELD value as person

MERGE (p:Person {name:person.name})
   ON CREATE SET p.age = person.age, p.children = size(person.children)
```

## [Built in Help](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#help)

![apoc help apoc](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc-help-apoc.jpg)

If you use `call apoc.help('keyword')` it lists all procedures and functions that have the keyword in their name.

With an empty keyword it lists all APOC procedures and functions, their signature and description.

To generate the help output, apoc utilizes the built in `dbms.procedures()` and `dbms.functions()` utilities.

<iframe width="560" height="315" src="https://www.youtube.com/embed/b1Yr2nHNS4M" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

### [Procedure & Function Signatures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_procedure_function_signatures)

To call procedures correctly, you need to know their parameter names, types and positions. And for YIELDing their results, you have to know the output column names and types.

INFO: The signatures are shown in error messages, if you use a procedure incorrectly.

You can see the procedures signature in the output of `CALL apoc.help("name")` (which itself uses `dbms.procedures()`and `dbms.functions()`)

```cypher
CALL apoc.help("dijkstra")
```

The signature is always `name : : TYPE`, so in this case:

```
apoc.algo.dijkstra
 (startNode :: NODE?, endNode :: NODE?,
   relationshipTypesAndDirections :: STRING?, weightPropertyName :: STRING?)
:: (path :: PATH?, weight :: FLOAT?)
```

| Name                             | Type     |
| :------------------------------- | :------- |
| Procedure Parameters             |          |
| `startNode`                      | `Node`   |
| `endNode`                        | `Node`   |
| `relationshipTypesAndDirections` | `String` |
| `weightPropertyName`             | `String` |
| Output Return Columns            |          |
| `path`                           | `Path`   |
| `weight`                         | `Float`  |

## [Installation in Neo4j Server & Docker](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#installation)

### [Manual Installation: Download latest release](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_manual_installation_download_latest_release)

Since APOC relies in some places on Neo4j’s internal APIs you need to use the **matching APOC version** for your Neo4j installaton. Make sure that the **first two version numbers match between Neo4j and APOC**.

Go to to [the latest release](http://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/3.5) for **Neo4j version 3.4** and download the binary jar to place into your `$NEO4J_HOME/plugins`folder.

You can find [all releases here](http://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/).

|      | Procedures that use internal APIs have to be allowed in `$NEO4J_HOME/conf/neo4j.conf` with, e.g. `dbms.security.procedures.unrestricted=apoc.*` for security reasons.If you want to use this via docker, you need to amend `-e NEO4J_dbms_security_procedures_unrestricted=apoc.\\\*` to your `docker run …` command. The three backslashes are necessary to prevent wildcard expansions.You *can* also whitelist procedures and functions in general to be loaded using: `dbms.security.procedures.whitelist=apoc.coll.*,apoc.load.*` |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Using APOC with the Neo4j Docker image](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_apoc_with_the_neo4j_docker_image)

The [Neo4j Docker image](https://hub.docker.com/_/neo4j/) allows to supply a volume for the `/plugins` folder. Download the APOC release matching your Neo4j version to local folder `plugins` and provide it as a data volume:

```bash
mkdir plugins
pushd plugins
wget https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5/apoc-3.5-all.jar
popd
docker run --rm -e NEO4J_AUTH=none -p 7474:7474 -v $PWD/plugins:/plugins -p 7687:7687 neo4j:3.4
```

If you want to pass custom apoc config to your Docker instance, you can use environment variables, like here:

```
docker run \
    -p 7474:7474 -p 7687:7687 \
    -v $PWD/data:/data -v $PWD/plugins:/plugins \
    --name neo4j-apoc \
    -e NEO4J_apoc_export_file_enabled=true \
    -e NEO4J_apoc_import_file_enabled=true \
    -e NEO4J_apoc_import_file_use__neo4j__config=true \
    neo4j
```

If you want to allow APOC’s procedures that use internal APIs, you need to amend `-e NEO4J_dbms_security_procedures_unrestricted=apoc.\\\*` to your `docker run …` command. The three backslashes are necessary to prevent wildcard expansions.

## [Overview of APOC Procedures & Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#overview)

Show 102550100entries

Search:

| type     | qualified name               | description                                                  |
| :------- | :--------------------------- | :----------------------------------------------------------- |
| function | apoc.temporal.format         | apoc.temporal.format(input, format) \| Format a temporal value |
| function | apoc.temporal.formatDuration | apoc.temporal.formatDuration(input, format) \| Format a Duration |
| function | apoc.trigger.nodesByLabel    |                                                              |
| function | apoc.trigger.propertiesByKey |                                                              |
| function | apoc.static.get              | apoc.static.get(name) - returns statically stored value from config (apoc.static.<key>) or server lifetime storage |
| function | apoc.static.getAll           | apoc.static.getAll(prefix) - returns statically stored values from config (apoc.static.<prefix>.*) or server lifetime storage |
| function | apoc.util.sha1               | apoc.util.sha1([values]) \| computes the sha1 of the concatenation of all string values of the list |
| function | apoc.util.sha256             | apoc.util.sha256([values]) \| computes the sha256 of the concatenation of all string values of the list |
| function | apoc.util.sha384             | apoc.util.sha384([values]) \| computes the sha384 of the concatenation of all string values of the list |
| function | apoc.util.sha512             | apoc.util.sha512([values]) \| computes the sha512 of the concatenation of all string values of the list |

Showing 1 to 10 of 517 entries

Previous12345…52Next

## [Configuration Options](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#config)

Set these config options in `$NEO4J_HOME/neo4j.conf`

All boolean options have default value set to **false**. This means that they are **disabled**, unless mentioned otherwise.

| `apoc.trigger.enabled=false/true`                            | Enable triggers                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.ttl.enabled=false/true`                                | Enable time to live background task                          |
| `apoc.ttl.schedule=5 (default 60)`                           | Set frequency in seconds to run ttl background task          |
| `apoc.import.file.use_neo4j_config=true/false (default true)` | the procedures check whether file system access is allowed and possibly constrained to a specific directory by reading the two configuration parameters`dbms.security.allow_csv_import_from_file_urls` and `dbms.directories.import` respectively |
| `apoc.import.file.enabled=false/true`                        | Enable reading local files from disk                         |
| `apoc.export.file.enabled=false/true`                        | Enable writing local files to disk                           |
| `apoc.jdbc.<key>.uri=jdbc-url-with-credentials`              | store jdbc-urls under a key to be used by apoc.load.jdbc     |
| `apoc.es.<key>.uri=es-url-with-credentials`                  | store es-urls under a key to be used by elasticsearch procedures |
| `apoc.mongodb.<key>.uri=mongodb-url-with-credentials`        | store mongodb-urls under a key to be used by mongodb procedures |
| `apoc.couchbase.<key>.uri=couchbase-url-with-credentials`    | store couchbase-urls under a key to be used by couchbase procedures |
| `apoc.jobs.scheduled.num_threads=number-of-threads`          | Many periodic procedures rely on a scheduled executor that has a pool of threads with a default fixed size. You can configure the pool size using this configuration property |
| `apoc.jobs.pool.num_threads=number-of-threads`               | Number of threads in the default APOC thread pool used for background executions. |

## [User Defined Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_user_defined_functions)

Introduced in Neo4j 3.1.0-M10

Neo4j 3.1 brings some really neat improvements in Cypher alongside other cool features

If you used or wrote procedures in the past, you most probably came across instances where it felt quite unwieldy to call a procedure just to compute something, convert a value or provide a boolean decision.

For example:

```cypher
CREATE (v:Value {id:{id}, data:{data}})
WITH v
CALL apoc.date.format(timestamp(), "ms") YIELD value as created
SET v.created = created
```

You’d rather write it as a function:

```cypher
CREATE (v:Value {id:{id}, data:{data}, created: apoc.date.format(timestamp()) })
```

Now in 3.1 that’s possible, and you can also leave off the `"ms"` and use a single function name, because the `unit` and `format` parameters have a default value.

Functions are more limited than procedures: they can’t execute writes or schema operations and are expected to return a single value, not a stream of values. But this makes it also easier to write and use them.

By having information about their types, the Cypher Compiler can also check for applicability.

The signature of the procedure above changed from:

```java
@Procedure("apoc.date.format")
public Stream<StringResult> formatDefault(@Name("time") long time, @Name("unit") String unit) {
   return Stream.of(format(time, unit, DEFAULT_FORMAT));
}
```

to the much simpler function signature (ignoring the parameter name and value annotations):

```java
@UserFunction("apoc.date.format")
public String format(@Name("time") long time,
                     @Name(value="unit", defaultValue="ms") String unit,
                     @Name(value="format", defaultValue=DEFAULT_FORMAT) String format) {
   return getFormatter().format(time, unit, format);
}
```

This can then be called in the manner outlined above.

In our APOC procedure library we already converted about [50 procedures into functions](https://github.com/neo4j-contrib/neo4j-apoc-procedures/issues/144) from the following areas:

| package                       | # of functions | example function                               |
| :---------------------------- | :------------- | :--------------------------------------------- |
| date & time conversion        | 3              | `apoc.date.parse("time",["unit"],["format"])`  |
| number conversion             | 3              | `apoc.number.parse("number",["format"])`       |
| general type conversion       | 8              | `apoc.convert.toMap(value)`                    |
| type information and checking | 4              | `apoc.meta.type(value)`                        |
| collection and map functions  | 25             | `apoc.map.fromList(["k1",v1,"k2",v2,"k3",v3])` |
| JSON conversion               | 4              | `apoc.convert.toJson(value)`                   |
| string functions              | 7              | `apoc.text.join(["s1","s2","s3"],"delim")`     |
| hash functions                | 2              | `apoc.util.md5(value)`                         |

You can list user defined functions with `call dbms.functions()`

![dbms.functions](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/dbms.functions.jpg)

## [Export / Import](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#export-import)

|      | In case you have the default configuration with `apoc.import.file.use_neo4j_config=true` the export consider as root the directory defined into the `dbms.directories.import` property |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Loading Data from Web-APIs](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_loading_data_from_web_apis)

Supported protocols are `file`, `http`, `https`, `s3`, `hdfs` with redirect allowed.

In case no protocol is passed, this procedure set will try to check whether the url is actually a file.

|      | As `apoc.import.file.use_neo4j_config` is enabled, the procedures check whether file system access is allowed and possibly constrained to a specific directory by reading the two configuration parameters `dbms.security.allow_csv_import_from_file_urls` and `dbms.directories.import` respectively. If you want to remove these constraints please set `apoc.import.file.use_neo4j_config=false` |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

| `CALL apoc.load.json('http://example.com/map.json', [path], [config]) YIELD value as person CREATE (p:Person) SET p = person` | load from JSON URL (e.g. web-api) to import JSON as stream of values if the JSON was an array or a single value if it was a map |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.load.xml('http://example.com/test.xml', ['xPath'], [config]) YIELD value as doc CREATE (p:Person) SET p.name = doc.name` | load from XML URL (e.g. web-api) to import XML as single nested map with attributes and `_type`, `_text` and `_children` fields. |
| `CALL apoc.load.xmlSimple('http://example.com/test.xml') YIELD value as doc CREATE (p:Person) SET p.name = doc.name` | load from XML URL (e.g. web-api) to import XML as single nested map with attributes and `_type`, `_text` fields and `_<childtype>` collections per child-element-type. |
| `CALL apoc.load.csv('url',{sep:";"}) YIELD lineNo, list, strings, map, stringMap` | load CSV fom URL as stream of values config contains any of: `{skip:1,limit:5,header:false,sep:'TAB',ignore:['aColumn'],arraySep:';',results:['map','list','strings','stringMap'],nullValues:[''],mapping:{years:{type:'int',arraySep:'-',array:false,name:'age',ignore:false,nullValues:['n.A.']}}` |
| `CALL apoc.load.xls('url','Sheet'/'Sheet!A2:B5',{config}) YIELD lineNo, list, map` | load XLS fom URL as stream of values config contains any of: `{skip:1,limit:5,header:false,ignore:['aColumn'],arraySep:';'+ nullValues:[''],mapping:{years:{type:'int',arraySep:'-',array:false,name:'age',ignore:false,nullValues:['n.A.']}}` |

### [Load JSON](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-json)

#### [Load JSON](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_json)

Web APIs are a huge opportunity to access and integrate data from any sources with your graph. Most of them provide the data as JSON.

With `apoc.load.json` you can retrieve data from URLs and turn it into map value(s) for Cypher to consume. Cypher is pretty good at deconstructing nested documents with dot syntax, slices, `UNWIND` etc. so it is easy to turn nested data into graphs.

Sources with multiple JSON objects (JSONL,JSON Lines) in a stream are also supported, like the [streaming Twitter format](https://dev.twitter.com/streaming/overview/processing)or the Yelp Kaggle dataset.

<iframe width="560" height="315" src="https://www.youtube.com/embed/M1P1IlQdb5M" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

#### [Json-Path](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_json_path)

Most of the `apoc.load.json` and `apoc.convert.*Json` procedures and functions now accept a json-path as last argument.

The json-path uses the [Java implementation by Jayway](https://github.com/jayway/JsonPath#operators) of [Stefan Gössners JSON-Path](http://goessner.net/articles/JsonPath/)

Here is some syntax, there are more examples at the links above.

```
$.store.book[0].title
```

| Operator                 | Description                                                  |
| :----------------------- | :----------------------------------------------------------- |
| `$`                      | The root element to query. This starts all path expressions. |
| `@`                      | The current node being processed by a filter predicate.      |
| `*`                      | Wildcard. Available anywhere a name or numeric are required. |
| `..`                     | Deep scan. Available anywhere a name is required.            |
| `.<name>`                | Dot-notated child                                            |
| `['<name>' (,'<name>')]` | Bracket-notated child or children                            |
| `[<number> (,<number>)]` | Array index or indexes                                       |
| `[start:end]`            | Array slice operator                                         |
| `[?(<expression>)]`      | Filter expression. Expression must evaluate to a boolean value. |

If used, this path is applied to the json and can be used to extract sub-documents and -values before handing the result to Cypher, resulting in shorter statements with complex nested JSON.

There is also a direct `apoc.json.path(json,path)` function.

To simplify the JSON URL syntax, you can configure aliases in `conf/neo4j.conf`:

```
apoc.json.myJson.url=https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf
CALL apoc.load.json('https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf')

becomes

CALL apoc.load.json('myJson')
```

The 3rd value in the `apoc.json.<alias>.url=` effectively defines an alias to be used in `apoc.load.json('<alias>',….`

#### [Load JSON StackOverflow Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_json_stackoverflow_example)

There have been articles before about [loading JSON from Web-APIs like StackOverflow](http://neo4j.com/blog/cypher-load-json-from-url/).

With `apoc.load.json` it’s now very easy to load JSON data from any file or URL.

If the result is a JSON object is returned as a singular map. Otherwise if it was an array is turned into a stream of maps.

The URL for retrieving the last questions and answers of the [neo4j tag](http://stackoverflow.com/questions/tagged/neo4j) is this:

https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf

Now it can be used from within Cypher directly, let’s first introspect the data that is returned.

JSON data from StackOverflow

```cypher
WITH "https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf" AS url
CALL apoc.load.json(url) YIELD value
UNWIND value.items AS item
RETURN item.title, item.owner, item.creation_date, keys(item)
```

![apoc.load.json.so](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.json.so.png)

Question authors from StackOverflow using json-path

```cypher
WITH "https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf" AS url
CALL apoc.load.json(url,'$.items.owner.name') YIELD value
RETURN name, count(*);
```

Combined with the cypher query from the original blog post it’s easy to create the full Neo4j graph of those entities. We filter the original poster last, b/c deleted users have no `user_id` anymore.

Graph data created via loading JSON from StackOverflow

```cypher
WITH "https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf" AS url
CALL apoc.load.json(url) YIELD value
UNWIND value.items AS q
MERGE (question:Question {id:q.question_id}) ON CREATE
  SET question.title = q.title, question.share_link = q.share_link, question.favorite_count = q.favorite_count

FOREACH (tagName IN q.tags | MERGE (tag:Tag {name:tagName}) MERGE (question)-[:TAGGED]->(tag))
FOREACH (a IN q.answers |
   MERGE (question)<-[:ANSWERS]-(answer:Answer {id:a.answer_id})
   MERGE (answerer:User {id:a.owner.user_id}) ON CREATE SET answerer.display_name = a.owner.display_name
   MERGE (answer)<-[:PROVIDED]-(answerer)
)
WITH * WHERE NOT q.owner.user_id IS NULL
MERGE (owner:User {id:q.owner.user_id}) ON CREATE SET owner.display_name = q.owner.display_name
MERGE (owner)-[:ASKED]->(question)
```

![apoc.load.json so result](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.json-so-result.png)

#### [Load JSON from Twitter (with additional parameters)](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_json_from_twitter_with_additional_parameters)

With `apoc.load.jsonParams` you can send additional headers or payload with your JSON GET request, e.g. for the Twitter API:

Configure Bearer and Twitter Search Url token in `neo4j.conf`

```
apoc.static.twitter.bearer=XXXX
apoc.static.twitter.url=https://api.twitter.com/1.1/search/tweets.json?count=100&result_type=recent&lang=en&q=
```

Twitter Search via Cypher

```cypher
CALL apoc.static.getAll("twitter") yield value AS twitter
CALL apoc.load.jsonParams(twitter.url + "oscon+OR+neo4j+OR+%23oscon+OR+%40neo4j",{Authorization:"Bearer "+twitter.bearer},null) yield value
UNWIND value.statuses as status
WITH status, status.user as u, status.entities as e
RETURN status.id, status.text, u.screen_name, [t IN e.hashtags | t.text] as tags, e.symbols, [m IN e.user_mentions | m.screen_name] as mentions, [u IN e.urls | u.expanded_url] as urls
```

#### [GeoCoding Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_geocoding_example)

Example for reverse geocoding and determining the route from one to another location.

```cypher
WITH
        "21 rue Paul Bellamy 44000 NANTES FRANCE" AS fromAddr,
        "125 rue du docteur guichard 49000 ANGERS FRANCE" AS toAddr

call apoc.load.json("http://www.yournavigation.org/transport.php?url=http://nominatim.openstreetmap.org/search&format=json&q=" + replace(fromAddr, ' ', '%20')) YIELD value AS from

WITH from, toAddr  LIMIT 1

call apoc.load.json("http://www.yournavigation.org/transport.php?url=http://nominatim.openstreetmap.org/search&format=json&q=" + replace(toAddr, ' ', '%20')) YIELD value AS to

CALL apoc.load.json("https://router.project-osrm.org/viaroute?instructions=true&alt=true&z=17&loc=" + from.lat + "," + from.lon + "&loc=" + to.lat + "," + to.lon ) YIELD value AS doc

UNWIND doc.route_instructions as instruction

RETURN instruction
```

### [Load CSV](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-csv)

Many existing applications and data integrations use CSV as the minimal denominator format.

In Cypher it is supported by `LOAD CSV` and with the `neo4j-import` (`neo4j-admin import`) for bulk imports.

Usually a CSV file is text with delimiters (most often comma, but also tab (TSV) and colon (DSV)) separating columns and newlines for rows. Fields are possibly quoted to handle stray quotes, newlines, and the use of the delimeter within a field.

The existing `LOAD CSV` works ok for most uses, but there were a few features missing, that `apoc.load.csv` and `apoc.load.xls` add.

- provide a line number
- provide both a map and a list representation of each line
- automatic data conversion (including split into arrays)
- option to keep the original string formatted values
- ignoring fields (makes it easier to assign a full line as properties)
- headerless files
- replacing certain values with null

The apoc procedures also support reading compressed files.

The data conversion is useful for setting properties directly, but for computation within Cypher it’s problematic as Cypher doesn’t know the type of map values so they default to `Any`.

To use them correctly, you’ll have to indicate their type to Cypher by using the built-in (e.g. `toInteger`) or apoc (e.g. `apoc.convert.toBoolean`) conversion functions on the value.

For reading from files you’ll have to enable the config option:

```
apoc.import.file.enabled=true
```

By default file paths are global, for paths relative to the `import` directory set:

```
apoc.import.file.use_neo4j_config=true
```

#### [Examples for apoc.load.csv](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_for_apoc_load_csv)

test.csv

```
name,age,beverage
Selma,9,Soda
Rana,12,Tea;Milk
Selina,19,Cola
CALL apoc.load.csv('/tmp/test.csv') yield lineNo, map, list
RETURN *;
+---------------------------------------------------------------------------------------+
| lineNo | list                       | map                                             |
+---------------------------------------------------------------------------------------+
| 0      | ["Selma", "9", "Soda"]     | {name: "Selma", age: "9", beverage: "Soda"}     |
| 1      | ["Rana", "12", "Tea;Milk"] | {name: "Rana", age: "12", beverage: "Tea;Milk"} |
| 2      | ["Selina", "19", "Cola"]   | {name: "Selina", age: "19", beverage: "Cola"}   |
+---------------------------------------------------------------------------------------+
```

#### [Configuration Options](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_configuration_options)

Besides the file you can pass in a config map:

| name         | default | description                                                  |
| :----------- | :------ | :----------------------------------------------------------- |
| `skip`       | `none`  | skip result rows                                             |
| `limit`      | `none`  | limit result rows                                            |
| `header`     | `true`  | indicates if file has a header                               |
| `sep`        | `','`   | separator character or 'TAB'                                 |
| `quoteChar`  | `'"'`   | the char to use for quoted elements                          |
| `arraySep`   | `';'`   | array separator                                              |
| `ignore`     | `[]`    | which columns to ignore                                      |
| `nullValues` | `[]`    | which values to treat as null, e.g. `['na',false]`           |
| `mapping`    | `{}`    | per field mapping, entry key is field name, .e.g `{years:{….}` see below |

| name         | default | description                                        |
| :----------- | :------ | :------------------------------------------------- |
| `type`       | `none`  | 'int', 'string' etc.                               |
| `array`      | `false` | indicates if field is an array                     |
| `arraySep`   | `';'`   | separator for array                                |
| `name`       | `none`  | rename field                                       |
| `ignore`     | `false` | ignore/remove this field                           |
| `nullValues` | `[]`    | which values to treat as null, e.g. `['na',false]` |

```
CALL apoc.load.csv('/tmp/test.csv',
  {skip:1,limit:1,header:true,ignore:'name',
   mapping:{age:{type:'int'},beverage:{array:true,arraySep:';',name:'drinks'}) yield lineNo, map, list
RETURN *;
+---------------------------------------------------------------------------------------+
| lineNo | list                       | map                                             |
+---------------------------------------------------------------------------------------+
| 0      | ["Selma", "9", "Soda"]     | {name: "Selma", age: "9", beverage: "Soda"}     |
| 1      | ["Rana", "12", "Tea;Milk"] | {name: "Rana", age: "12", beverage: "Tea;Milk"} |
| 2      | ["Selina", "19", "Cola"]   | {name: "Selina", age: "19", beverage: "Cola"}   |
+---------------------------------------------------------------------------------------+
```

#### [Transaction Batching](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_transaction_batching)

To handle large files, `USING PERIODIC COMMIT` can be prepended to `LOAD CSV`, you’ll have to watch out though for **Eager**operations which might break that behavior.

In apoc you can combine any data source with `apoc.periodic.iterate` to achieve the same.

```cypher
CALL apoc.periodic.iterate('
CALL apoc.load.csv({url}) yield map as row return row
','
CREATE (p:Person) SET p = row
', {batchSize:10000, iterateList:true, parallel:true});
```

|      | Please note that the parallel operation only works well for non-conflicting updates otherwise you might run into deadlocks. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

To make these datastructures available to Cypher, you can use `apoc.load.xml`. It takes a file or http URL and parses the XML into a map datastructure.

|      | in previous releases we’ve had `apoc.load.xmlSimple`. This is now deprecated and got superseeded by`apoc.load.xml(url, [xPath], [config], true)`.Simple XML Format |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

See the following usage-examples for the procedures.

### [Import CSV](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#import-csv)

CSV files that comply with the [Neo4j import tool’s header format](https://neo4j.com/docs/operations-manual/current/tools/import/file-header-format/) can be imported using the `apoc.import.csv` procedure. This procedure is intended to load small- to medium-sized data sets in an online database. For importing larger data sets, it is recommended to perform a batch import using the ([import tool](https://neo4j.com/docs/operations-manual/current/tools/import/), which loads data in bulk to an offline (initially empty) database.

#### [Usage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_usage)

The parameters of the `apoc.import.csv(<nodes>, <relationships>, <config>)` procedure are as follows.

The `<nodes>` parameter is a list, where each element is a map defining a source file (`fileName`) to be loaded with a set of labels (`labels`):

| name       | description   | example                 |
| :--------- | :------------ | :---------------------- |
| `fileName` | filename      | `'file:/students.csv'`  |
| `labels`   | set of labels | `['Person', 'Student']` |

The `<relationships>` parameter is also a list, where each element is a map defining a source file (`fileName`) to be loaded with a given relationship type (`type`):

| name       | description       | example                |
| :--------- | :---------------- | :--------------------- |
| `fileName` | filename          | `'file:/works_at.csv'` |
| `type`     | relationship type | `'WORKS_AT'`           |

The `<config>` parameter is a map

| name                   | description                                                  | default | [import tool counterpart](https://neo4j.com/docs/operations-manual/current/tools/import/options/) |
| :--------------------- | :----------------------------------------------------------- | :------ | :----------------------------------------------------------- |
| `delimiter`            | delimiter character between columns                          | `,`     | `--delimiter=,`                                              |
| `arrayDelimiter`       | delimiter character in arrays                                | `;`     | `--array-delimiter=;`                                        |
| `ignoreDuplicateNodes` | for duplicate nodes, only load the first one and skip the rest (true) or fail the import (false) | `false` | `--ignore-duplicate-nodes=false`                             |
| `quotationCharacter`   | quotation character                                          | `"`     | `--quote='"'`                                                |
| `stringIds`            | treat ids as strings                                         | `true`  | `--id-type=STRING`                                           |
| `skipLines`            | lines to skip (incl. header)                                 | `1`     | `N/A`                                                        |

#### [Examples for apoc.import.csv](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_for_apoc_import_csv)

##### [Loading nodes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_loading_nodes)

Given the following CSV file and procedure call, the database loads two `Person` nodes with their `name` properties set:

persons.csv

```
name:STRING
John
Jane
CALL apoc.import.csv([{fileName: 'file:/persons.csv', labels: ['Person']}], [], {})
```

##### [Loading nodes and relationships](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_loading_nodes_and_relationships)

Given the following CSV files and procedure call, the database loads two `Person` nodes and a `KNOWS` relationship between them (with the value of the `since` property set). Note that both the field terminators and the array delimiters are changed from the default value, and the CSVs use numeric ids.

persons.csv

```
:ID|name:STRING|speaks:STRING[]
1|John|en,fr
2|Jane|en,de
```

knows.csv

```
:START_ID|:END_ID|since:INT
1|2|2016
CALL apoc.import.csv(
  [{fileName: 'file:/persons.csv', labels: ['Person']}],
  [{fileName: 'file:/knows.csv', type: 'KNOWS'}],
  {delimiter: '|', arrayDelimiter: ',', stringIds: false}
)
```

The loader supports advanced features of the import tool:

- *ID spaces* are supported, using the [import tool’s syntax](https://neo4j.com/docs/operations-manual/current/tools/import/file-header-format/#import-tool-id-spaces).
- Node labels can be specified with the [`:LABEL`](https://neo4j.com/docs/operations-manual/current/tools/import/file-header-format/#import-tool-header-format-nodes) field.
- Relationship types can be specified with the [`:TYPE`](https://neo4j.com/docs/operations-manual/current/tools/import/file-header-format/#import-tool-header-format-rels) field.

### [Loading Excel (XLS)](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-xls)

#### [Library Requirements](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_library_requirements)

For loading XLS we’re using the Apache POI library, which works well with old and new Excel formats, but is quite large. That’s why we decided not to include it into the apoc jar, but make it an optional dependency.

Please download these jars and put them into your `plugins` directory:

For XLS files:

- [poi-3.17.jar](http://repo1.maven.org/maven2/org/apache/poi/poi/3.17/poi-3.17.jar)

Additional for XLSX files:

- [commons-collections4-4.1.jar](http://repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.1/commons-collections4-4.1.jar)
- [poi-ooxml-3.17.jar](http://repo1.maven.org/maven2/org/apache/poi/poi-ooxml/3.17/poi-ooxml-3.17.jar)
- [poi-ooxml-schemas-3.17.jar](http://repo1.maven.org/maven2/org/apache/poi/poi-ooxml-schemas/3.17/poi-ooxml-schemas-3.17.jar)
- [xmlbeans-2.6.0.jar](http://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/2.6.0/xmlbeans-2.6.0.jar)
- [curvesapi-1.04.jar](http://repo1.maven.org/maven2/com/github/virtuald/curvesapi/1.04/curvesapi-1.04.jar)

#### [Usage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_usage_2)

The usage of `apoc.load.xls` is similar to apoc.load.csv with the main difference the ability to select a worksheet or a range from a sheet to load.

You can either select the sheet by name like `'Kids'`, or offset like `'Results!B2:F3'`

```
CALL apoc.load.xls({url}, {Name of sheet}, {config})
```

The `{config}` parameter is a map

| name                     | description                                                  |
| :----------------------- | :----------------------------------------------------------- |
| `mapping`                | `{mapping:{'<sheet>':{type:'<type>', dateFormat: '<format>', dateParse: [<formats>]}}}` |
| `<sheet>`                | `name of the sheet`                                          |
| `<type>`                 | `Default String, The type of the conversion requested (STRING, INTEGER, FLOAT, BOOLEAN, NULL, LIST,DATE, DATE_TIME, LOCAL_DATE, LOCAL_DATE_TIME,LOCAL_TIME, TIME)` |
| `dateFormat: <format>`   | `Convert the Date into String (only String is allowed)`      |
| `dateParse: [<formats>]` | `Convert the String into Date (Array of strings are allowed)` |

##### [Note](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_note)

In dateParse the first format matched return the date formatted, otherwise it will return an error

In `format` config you can use the pattern describe as the Temporal functions: [temporal funcionts](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_temporal)

#### [Examples for apoc.load.xls](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_for_apoc_load_xls)

```cypher
CALL apoc.load.xls('file:///path/to/file.xls','Full',{mapping:{Integer:{type:'int'}, Array:{type:'int',array:true,arraySep:';'}}})
```

![apoc.load.xls](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xls.png)

```cypher
CALL apoc.load.xls('http://bit.ly/2nXgHA2','Kids')
```

Some examples with type/dateFormat and dateParse:

```cypher
CALL apoc.load.xls('test_date.xlsx','sheet',{mapping:{Date:{type:'String'}}})
```

![apoc.load.xls 1](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xls_1.png)

Figure 1. results

```cypher
CALL apoc.load.xls('test_date.xlsx','sheet',{mapping:{Date:{type:'String',dateFormat:'iso_date'}}})
```

![apoc.load.xls 2](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xls_2.png)

Figure 2. results

```cypher
CALL apoc.load.xls('test_date.xlsx','sheet',{mapping:{Date:{type:'String',dateParse:["wrongPath", "dd-MM-yyyy", "dd/MM/yyyy", "yyyy/MM/dd", "yyyy/dd/MM", "yyyy-dd-MM'T'hh:mm:ss"]}}})
```

![apoc.load.xls 3](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xls_3.png)

Figure 3. results

### [Load XML](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-xml)

#### [Load XML Introduction](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_xml_introduction)

Many existing (enterprise) applications, endpoints and files use XML as data exchange format.

To make these datastructures available to Cypher, you can use `apoc.load.xml`. It takes a file or http URL and parses the XML into a map datastructure.

|      | in previous releases we’ve had `apoc.load.xmlSimple`. This is now deprecated and got superseeded by`apoc.load.xml(url, [xPath], [config], true)`.Simple XML Format |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

See the following usage-examples for the procedures.

#### [Example File](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_file)

"How do you access XML doc attributes in children fields ?"

(Thanks Nicolas Rouyer)

For example, if my XML file is the example [book.xml provided by Microsoft](https://msdn.microsoft.com/en-us/library/ms762271(v=vs.85).aspx).

```xml
<?xml version="1.0"?>
<catalog>
   <book id="bk101">
      <author>Gambardella, Matthew</author>
      <title>XML Developer's Guide</title>
      <genre>Computer</genre>
      <price>44.95</price>
      <publish_date>2000-10-01</publish_date>
      <description>An in-depth look at creating applications
      with XML.</description>
   </book>
   <book id="bk102">
      <author>Ralls, Kim</author>
      <title>Midnight Rain</title>
      <genre>Fantasy</genre>
      <price>5.95</price>
      <publish_date>2000-12-16</publish_date>
      <description>A former architect battles corporate zombies,
...
```

We have the file here, [on GitHub](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml).

#### [Simple XML Format](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_simple_xml_format)

In a simpler XML representation, each type of children gets it’s own entry within the parent map. The element-type as key is prefixed with "_" to prevent collisions with attributes.

If there is a single element, then the entry will just have that element as value, not a collection. If there is more than one element there will be a list of values.

Each child will still have its `_type` field to discern them.

Here is the example file from above loaded with `apoc.load.xmlSimple`

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml", '', {}, true)
{_type: "catalog", _book: [
  {_type: "book", id: "bk101",
    _author: [{_type: "author", _text: "Gambardella, Matthew"},{_type: author, _text: "Arciniegas, Fabio"}],
    _title: {_type: "title", _text: "XML Developer's Guide"},
    _genre: {_type: "genre", _text: "Computer"},
    _price: {_type: "price", _text: "44.95"},
    _publish_date: {_type: "publish_date", _text: "2000-10-01"},
    _description: {_type: description, _text: An in-depth look at creating applications ....
```

##### [Simple XML Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_simple_xml_examples)

Example 1

```cypher
WITH "https://maps.googleapis.com/maps/api/directions/xml?origin=Mertens%20en%20Torfsstraat%2046,%202018%20Antwerpen&destination=Rubensstraat%2010,%202300%20Turnhout&sensor=false&mode=bicycling&alternatives=false&key=AIzaSyAPPIXGudOyHD_KAa2f_1l_QVNbsd_pMQs" AS url
CALL apoc.load.xmlSimple(url) YIELD value
RETURN value._route._leg._distance._value, keys(value), keys(value._route), keys(value._route._leg), keys(value._route._leg._distance._value)
```

![apoc.load.xmlSimple.ex1](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xmlSimple.ex1.png)

Example 2

```cypher
WITH "https://maps.googleapis.com/maps/api/directions/xml?origin=Mertens%20en%20Torfsstraat%2046,%202018%20Antwerpen&destination=Rubensstraat%2010,%202300%20Turnhout&sensor=false&mode=bicycling&alternatives=false&key=AIzaSyAPPIXGudOyHD_KAa2f_1l_QVNbsd_pMQs" AS url
CALL apoc.load.xmlSimple(url) YIELD value
UNWIND keys(value) AS key
RETURN key, apoc.meta.type(value[key]);
```

![apoc.load.xmlSimple.ex2](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xmlSimple.ex2.png)

##### [HTTP Headers](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_http_headers)

You can provide a map of HTTP headers to the config property.

```cypher
WITH { `X-API-KEY`: 'abc123' } as headers,
WITH "https://myapi.com/api/v1/" AS url
CALL apoc.load.xml(url, '', { headers: headers }) YIELD value
UNWIND keys(value) AS key
RETURN key, apoc.meta.type(value[key]);
```

#### [xPath](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_xpath)

It’s possible to define a xPath (optional) to selecting nodes from the XML document.

##### [xPath Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_xpath_example)

From the Microsoft’s book.xml file we can get only the books that have as `genre` Computer

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml", '/catalog/book[genre=\"Computer\"]') yield value as book
WITH book.id as id, [attr IN book._children WHERE attr._type IN ['title','price'] | attr._text] as pairs
RETURN id, pairs[0] as title, pairs[1] as price
```

![apoc.load.xml.xpath](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xml.xpath.png)

In this case we return only `id`, `title` and `prize` but we can return any other elements

We can also return just a single specific element. For example the `author` of the book with `id = bg102`

```cypher
call apoc.load.xml('https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml', '/catalog/book[@id="bk102"]/author') yield value as result
WITH result._text as author
RETURN author
```

![apoc.load.xml.xpath2](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.xml.xpath2.png)

#### [Load XML and Introspect](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_xml_and_introspect)

Let’s just load it and see what it looks like. It’s returned as value map with nested `_type` and `_children` fields, per group of elements. Attributes are turned into map-entries. And each element into their own little map with `_type`, attributes and `_children` if applicable.

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml")
{_type: catalog, _children: [
  {_type: book, id: bk101, _children: [
    {_type: author, _text: Gambardella, Matthew},
    {_type: title, _text: XML Developer's Guide},
    {_type: genre, _text: Computer},
    {_type: price, _text: 44.95},
    {_type: publish_date, _text: 2000-10-01},
    {_type: description, _text: An in-depth look at creating applications ....
```

##### [For each book, how do I access book id ?](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_for_each_book_how_do_i_access_book_id)

You can access attributes per element directly.

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml") yield value as catalog
UNWIND catalog._children as book
RETURN book.id
╒═══════╕
│book.id│
╞═══════╡
│bk101  │
├───────┤
│bk102  │
```

##### [For each book, how do I access book author and title ?](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_for_each_book_how_do_i_access_book_author_and_title)

###### [Filter into collection](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_filter_into_collection)

You have to filter over the sub-elements in the `_childrens` array in this case.

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml") yield value as catalog
UNWIND catalog._children as book
RETURN book.id, [attr IN book._children WHERE attr._type IN ['author','title'] | [attr._type, attr._text]] as pairs
╒═══════╤════════════════════════════════════════════════════════════════════════╕
│book.id│pairs                                                                   │
╞═══════╪════════════════════════════════════════════════════════════════════════╡
│bk101  │[[author, Gambardella, Matthew], [title, XML Developer's Guide]]        │
├───────┼────────────────────────────────────────────────────────────────────────┤
│bk102  │[[author, Ralls, Kim], [title, Midnight Rain]]                          │
```

###### [How do I return collection elements?](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_how_do_i_return_collection_elements)

This is not too nice, we could also just have returned the values and then grabbed them out of the list, but that relies on element-order.

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml") yield value as catalog
UNWIND catalog._children as book
WITH book.id as id, [attr IN book._children WHERE attr._type IN ['author','title'] | attr._text] as pairs
RETURN id, pairs[0] as author, pairs[1] as title
╒═════╤════════════════════╤══════════════════════════════╕
│id   │author              │title                         │
╞═════╪════════════════════╪══════════════════════════════╡
│bk101│Gambardella, Matthew│XML Developer's Guide         │
├─────┼────────────────────┼──────────────────────────────┤
│bk102│Ralls, Kim          │Midnight Rain                 │
```

#### [Extracting Datastructures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_extracting_datastructures)

##### [Turn Pairs into Map](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_turn_pairs_into_map)

So better is to turn them into a map with `apoc.map.fromPairs`

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml") yield value as catalog
UNWIND catalog._children as book
WITH book.id as id, [attr IN book._children WHERE attr._type IN ['author','title'] | [attr._type, attr._text]] as pairs
CALL apoc.map.fromPairs(pairs) yield value
RETURN id, value
╒═════╤════════════════════════════════════════════════════════════════════╕
│id   │value                                                               │
╞═════╪════════════════════════════════════════════════════════════════════╡
│bk101│{author: Gambardella, Matthew, title: XML Developer's Guide}        │
├─────┼────────────────────────────────────────────────────────────────────┤
│bk102│{author: Ralls, Kim, title: Midnight Rain}                          │
├─────┼────────────────────────────────────────────────────────────────────┤
│bk103│{author: Corets, Eva, title: Maeve Ascendant}                       │
```

###### [Return individual Columns](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_return_individual_columns)

And now we can cleanly access the attributes from the map.

```cypher
call apoc.load.xml("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml") yield value as catalog
UNWIND catalog._children as book
WITH book.id as id, [attr IN book._children WHERE attr._type IN ['author','title'] | [attr._type, attr._text]] as pairs
CALL apoc.map.fromPairs(pairs) yield value
RETURN id, value.author, value.title
╒═════╤════════════════════╤══════════════════════════════╕
│id   │value.author        │value.title                   │
╞═════╪════════════════════╪══════════════════════════════╡
│bk101│Gambardella, Matthew│XML Developer's Guide         │
├─────┼────────────────────┼──────────────────────────────┤
│bk102│Ralls, Kim          │Midnight Rain                 │
├─────┼────────────────────┼──────────────────────────────┤
│bk103│Corets, Eva         │Maeve Ascendant               │
```

#### [import xml directly](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_import_xml_directly)

In case you don’t want to transform your xml (like you do with `apoc.load.xml/apoc.load.xmlSimple` before you create nodes and relationships and you want to have a 1:1 mapping of xml into the graph you can use `apoc.xml.import`.

##### [usage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_usage_3)

```cypher
CALL apoc.xml.import(<url>, <config-map>?) YIELD node
```

The procedure will return a node representing the xml document containing nodes/rels underneath mapping to the xml structure. The following mapping rules are applied:

| xml                    | label                    | properties                               |
| :--------------------- | :----------------------- | :--------------------------------------- |
| document               | XmlDocument              | _xmlVersion, _xmlEncoding                |
| processing instruction | XmlProcessingInstruction | _piData, _piTarget                       |
| Element/Tag            | XmlTag                   | _name                                    |
| Attribute              | n/a                      | property in the XmlTag node              |
| Text                   | XmlWord                  | for each word a separate node is created |

The nodes for the xml document are connected:

| relationship type | description                                                  |
| :---------------- | :----------------------------------------------------------- |
| :IS_CHILD_OF      | pointing to a nested xml element                             |
| :FIRST_CHILD_OF   | pointing to the first child                                  |
| :NEXT_SIBLING     | pointing to the next xml element on the same nesting level   |
| :NEXT             | produces a linear chain through the full document            |
| :NEXT_WORD        | only produced if config map has `createNextWordRelationships:true`. Connects words in xml to a text flow. |

The following options are available for the `config` map:

| config option           | default value           | description                                                  |
| :---------------------- | :---------------------- | :----------------------------------------------------------- |
| connectCharacters       | false                   | if `true` the xml text elements are child nodes of their tags, interconnected by relationships of type `relType` (see below) |
| filterLeadingWhitespace | false                   | if `true` leading whitespace is skipped for each line        |
| delimiter               | `\s` (regex whitespace) | if given, split text elements with the delimiter into separate nodes |
| label                   | XmlCharacter            | label to use for text element representation                 |
| relType                 | `NE`                    | relationship type to be used for connecting the text elements into one linked list |
| charactersForTag        | {}                      | map of tagname → string. For the given tag names an additional text element is added containing the value as `text`property. Useful e.g. for `<lb/>` tags in TEI-XML to be represented as `<lb> </lb>`. |

##### [example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example)

```cypher
call
apoc.xml.import("https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/src/test/resources/xml/books.xml",{createNextWordRelationships:
true})
yield node
return node;

call apoc.xml.import('https://seafile.rlp.net/f/6282a26504cc4f079ab9/?dl=1', {connectCharacters: true, charactersForTag:{lb:' '}, filterLeadingWhitespace: true}) yield node
return node;
```

#### [Load HTML](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-html)

Scraping Data from Html Pages.

| `apoc.load.html('url',{name: jquery, name2: jquery}, config) YIELD value` | Load Html page and return the result as a Map |
| ------------------------------------------------------------ | --------------------------------------------- |
|                                                              |                                               |

This procedures provides a very convenient API for acting using DOM, CSS and jquery-like methods. It relies on [jsoup library](http://jsoup.org/).

```cypher
CALL apoc.load.html(url, {name: <css/dom query>, name2: <css/dom query>}, {config}) YIELD value
```

The result is a stream of DOM elements represented by a map

The result is a map i.e.

```javascript
{name: <list of elements>, name2: <list of elements>}
```

#### [Config](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_config)

Config param is optional, the default value is an empty map.

| `charset`  | Default: UTF-8                                   |
| ---------- | ------------------------------------------------ |
| `baserUri` | Default: "", it is use to resolve relative paths |

#### [Example with real data](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_with_real_data)

For these example we use the wikipedia home page "https://en.wikipedia.org/"

##### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples)

```cypher
CALL apoc.load.html("https://en.wikipedia.org/",{metadata:"meta", h2:"h2"})
```

You will get this result:

![apoc.load.htmlall](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.htmlall.png)

```cypher
CALL apoc.load.html("https://en.wikipedia.org/",{links:"link"})
```

You will get this result:

![apoc.load.htmllinks](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.htmllinks.png)

```cypher
CALL apoc.load.html("https://en.wikipedia.org/",{metadata:"meta", h2:"h2"}, {charset: "UTF-8})
```

You will get this result:

![apoc.load.htmlconfig](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.load.htmlconfig.png)

#### [Streaming Data to Gephi](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#gephi)

| `apoc.gephi.add(url-or-key, workspace, data, weightproperty, ['exportproperty'])` | streams provided data to Gephi |
| ------------------------------------------------------------ | ------------------------------ |
|                                                              |                                |

| type      | qualified name   | description                                                  |
| :-------- | :--------------- | :----------------------------------------------------------- |
| procedure | `apoc.gephi.add` | apoc.gephi.add(url-or-key, workspace, data, weightproperty, ['exportproperty']) \| streams passed in data to Gephi |

![apoc gephi](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc-gephi.gif)

##### [Notes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_notes)

Gephi has a [streaming plugin](https://marketplace.gephi.org/plugin/graph-streaming/), that can provide and accept [JSON-graph-data](https://github.com/gephi/gephi/wiki/GraphStreaming#Gephi_as_Master) in a streaming fashion.

Make sure to install the plugin firsrt and activate it for your workspace (there is a new "Streaming"-tab besides "Layout"), right-click "Master"→"start" to start the server.

You can provide your workspace name (you might want to rename it before you start thes streaming), otherwise it defaults to `workspace0`

The default Gephi-URL is [http://localhost:8080](http://localhost:8080/), resulting in `http://localhost:8080/workspace0?operation=updateGraph`

You can also configure it in `conf/neo4j.conf` via `apoc.gephi.url=url` or `apoc.gephi.<key>.url=url`

#### [Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_2)

You can export your graph as an unweighted network.

```cypher
match path = (:Person)-[:ACTED_IN]->(:Movie)
WITH path LIMIT 1000
with collect(path) as paths
call apoc.gephi.add(null,'workspace0', paths) yield nodes, relationships, time
return nodes, relationships, time
```

You can export your graph as a weighted network, by specifying the property of a relationship, that holds the weight value.

```cypher
match path = (:Person)-[r:ACTED_IN]->(:Movie) where exists r.weightproperty
WITH path LIMIT 1000
with collect(path) as paths
call apoc.gephi.add(null,'workspace0', paths, 'weightproperty') yield nodes, relationships, time
return nodes, relationships, time
```

You can also export with your graph other properties of your nodes and/or relationship by adding an optional array with the property names you want to export. Example for exporting `birthYear` and `role` property.

```cypher
match path = (:Person)-[r:ACTED_IN]->(:Movie) where exists r.weightproperty
WITH path LIMIT 1000
with collect(path) as paths
call apoc.gephi.add(null,'workspace0', paths, 'weightproperty',['birthYear', 'role']) yield nodes, relationships, time
return nodes, relationships, time
```

##### [Format](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_format)

We send all nodes and relationships of the passed in data convert into individual Gephi-Streaming JSON fragements, separated by `\r\n`.

```javascript
{"an":{"123":{"TYPE":"Person:Actor","label":"Tom Hanks",                           x:333,y:222,r:0.1,g:0.3,b:0.5}}}\r\n
{"an":{"345":{"TYPE":"Movie","label":"Forrest Gump",                               x:234,y:122,r:0.2,g:0.2,b:0.7}}}\r\n
{"ae":{"3344":{"TYPE":"ACTED_IN","label":"Tom Hanks",source:"123",target:"345","directed":true,"weight":1.0,r:0.1,g:0.3,b:0.5}}}
```

#### [Specifics Details](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_specifics_details)

Gephi doesn’t render the graph data unless you also provide x,y coordinates in the payload, so we just send random ones within a 1000x1000 grid.

We also generate colors per label combination and relationship-type, both of which are also transferred as `TYPE`property.

You can have your weight property stored as a number (integer,float) or a string. If the weight property is invalid or null, it will use the default 1.0 value.

#### [Load Single File From Compressed File (zip/tar/tar.gz/tgz)](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_single_file_from_compressed_file_zip_tar_tar_gz_tgz)

For load file from compressed file the url right syntax is:

```
apoc.load.csv("pathToFile!csv/fileName.csv")
apoc.load.json("https://github.com/neo4j-contrib/neo4j-apoc-procedures/tree/3.4/src/test/resources/testload.tgz?raw=true!person.json");
```

You have to put the ! character before the filename.

#### [Using S3 protocol](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_s3_protocol)

For using S3 protocol you have to copy these jars into the plugins directory:

- aws-java-sdk-core-1.11.250.jar (https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-core/1.11.250)
- aws-java-sdk-s3-1.11.250.jar (https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-s3/1.11.250)
- httpclient-4.4.8.jar (https://mvnrepository.com/artifact/org.apache.httpcomponents/httpclient/4.5.4)
- httpcore-4.5.4.jar (https://mvnrepository.com/artifact/org.apache.httpcomponents/httpcore/4.4.8)
- joda-time-2.9.9.jar (https://mvnrepository.com/artifact/joda-time/joda-time/2.9.9)

S3 Url must be:

- s3://accessKey:secretKey@endpoint:port/bucket/key or
- s3://endpoint:port/bucket/key?accessKey=accessKey&secretKey=secretKey

#### [failOnError](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_failonerror)

Adding on config the parameter `failOnError:false` (by default `true`), in case of error the procedure don’t fail but just return zero rows.

### [Export to CSV](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#export-csv)

```
YIELD file, source, format, nodes, relationships, properties, time, rows, data
```

| `apoc.export.csv.query(query,file,config)`     | exports results from the Cypher statement as CSV to the provided file |
| ---------------------------------------------- | ------------------------------------------------------------ |
| `apoc.export.csv.all(file,config)`             | exports whole database as CSV to the provided file           |
| `apoc.export.csv.data(nodes,rels,file,config)` | exports given nodes and relationships as CSV to the provided file |
| `apoc.export.csv.graph(graph,file,config)`     | exports given graph object as CSV to the provided file       |

If the file name is passed as `null` and the config `stream:true` the results are streamed back in the `data` column, e.g.

#### [Note:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_note_2)

For `apoc.export.csv.all/data/graph` nodes and relationships properties are ordered alphabetically, following this general structure:

`_id,_labels,<list_nodes_properties_naturally_sorted>,_start,_end,_type,<list_rel_properties_naturally_sorted>`, so for instance:

```
_id,_labels,age,city,kids,male,name,street,_start,_end,_type,bar,foo
```

The labels exported are ordered alphabetically. The output of `labels()` function is not sorted, use it in combination with `apoc.coll.sort()`.

```cypher
CALL apoc.export.csv.all(null, {stream:true,batchSize:100}) YIELD data RETURN data
```

### [Export to Json File](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#export-json)

Make sure to set the config options in your `neo4j.conf`

Neo4j.conf

```
apoc.export.file.enabled=true
YIELD file, source, format, nodes, relationships, properties, time, rows
```

| `apoc.export.json.query(query,file,config)`     | exports results from the Cypher statement as Json to the provided file |
| ----------------------------------------------- | ------------------------------------------------------------ |
| `apoc.export.json.all(file,config)`             | exports whole database as Json to the provided file          |
| `apoc.export.json.data(nodes,rels,file,config)` | exports given nodes and relationships as Json to the provided file |
| `apoc.export.json.graph(graph,file,config)`     | exports given graph object as Json to the provided file      |

| writeNodeProperties | true/false, if true export properties too. |
| ------------------- | ------------------------------------------ |
|                     |                                            |

|      | The labels exported are ordered alphabetically. The output of `labels()` function is not sorted, use it in combination with `apoc.coll.sort()`. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_2)

For the examples below we create the following dataset:

```cypher
CREATE (f:User {name:'Adam',age:42,male:true,kids:['Sam','Anna','Grace'], born:localdatetime('2015185T19:32:24'), place:point({latitude: 13.1, longitude: 33.46789})})-[:KNOWS {since: 1993}]->(b:User {name:'Jim',age:42}),(c:User {age:12})
```

Export query

```cypher
CALL apoc.export.json.query("MATCH (u:User) WHERE age > {age} return u","/tmp/query.json",{params:{age:10}})
```

result:

```json
{"u":{"type":"node","id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}}}
{"u":{"type":"node","id":"1","labels":["User"],"properties":{"name":"Jim","age":42}}}
{"u":{"type":"node","id":"2","labels":["User"],"properties":{"age":12}}}
```

Export query Complex

```cypher
CALL apoc.export.json.query("RETURN {value:1, data:[10,'car',null, point({ longitude: 56.7, latitude: 12.78 }), point({ longitude: 56.7, latitude: 12.78, height: 8 }), point({ x: 2.3, y: 4.5 }), point({ x: 2.3, y: 4.5, z: 2 }),date('2018-10-10'), datetime('2018-10-18T14:21:40.004Z'), localdatetime({ year:1984, week:10, dayOfWeek:3, hour:12, minute:31, second:14, millisecond: 645 }), {x:1, y:[1,2,3,{age:10}]}]} as key","/tmp/complex.json")
```

result:

```json
{"key":{"data":[10,"car",null,{"crs":"wgs-84","latitude":56.7,"longitude":12.78,"height":null},{"crs":"wgs-84-3d","latitude":56.7,"longitude":12.78,"height":8.0},{"crs":"cartesian","x":2.3,"y":4.5,"z":null},{"crs":"cartesian-3d","x":2.3,"y":4.5,"z":2.0},"2018-10-10","2018-10-18T14:21:40.004Z","1984-03-07T12:31:14.645",{"x":1,"y":[1,2,3,{"age":10}]}],"value":1}}
```

Export queryList

```cypher
CALL apoc.export.json.query("MATCH (u:User) RETURN COLLECT(u) as list","/tmp/list.json",{params:{age:10}})
```

result:

```json
{"list":[{"type":"node","id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}},{"type":"node","id":"1","labels":["User"],"properties":{"name":"Jim","age":42}},{"type":"node","id":"2","labels":["User"],"properties":{"age":12}}]}
```

Export queryMap

```cypher
CALL apoc.export.json.query("MATCH (u:User)-[r:KNOWS]->(d:User) RETURN u {.*}, d {.*}, r {.*}","/tmp/map.json",{params:{age:10}})
```

result:

```json
{"u":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]},"d":{"name":"Jim","age":42},"r":{"since":1993}}
```

Export all

```cypher
CALL apoc.export.json.all("/tmp/all.json",{useTypes:true})
```

result:

```json
{"type":"node","id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}}
{"type":"node","id":"1","labels":["User"],"properties":{"name":"Jim","age":42}}
{"type":"node","id":"2","labels":["User"],"properties":{"age":12}}
{"id":"0","type":"relationship","label":"KNOWS","properties":{"since":1993},"start":{"id":"0","labels":["User"]},"end":{"id":"1","labels":["User"]}}
```

Export graph

```cypher
CALL apoc.graph.fromDB('test',{}) yield graph
CALL apoc.export.json.graph(graph,"tmp/graph.json",{})
YIELD nodes, relationships, properties, file, source,format, time
RETURN *
```

result:

```json
{"type":"node","id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}}
{"type":"node","id":"1","labels":["User"],"properties":{"name":"Jim","age":42}}
{"type":"node","id":"2","labels":["User"],"properties":{"age":12}}
{"id":"0","type":"relationship","label":"KNOWS","properties":{"since":1993},"start":{"id":"0","labels":["User"]},"end":{"id":"1","labels":["User"]}}
```

Export data

```cypher
MATCH (nod:User)
MATCH ()-[rels:KNOWS]->()
WITH collect(nod) as a, collect(rels) as b
CALL apoc.export.json.data(a, b, "tmp/data.json", null)
YIELD nodes, relationships, properties, file, source,format, time
RETURN *
```

result:

```json
{"type":"node","id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}}
{"type":"node","id":"1","labels":["User"],"properties":{"name":"Jim","age":42}}
{"type":"node","id":"2","labels":["User"],"properties":{"age":12}}
{"id":"0","type":"relationship","label":"KNOWS","properties":{"since":1993},"start":{"id":"0","labels":["User"]},"end":{"id":"1","labels":["User"]}}
```

Export query with config `writeNodeProperties`

```cypher
CALL apoc.export.json.query("MATCH p = (u:User)-[rel:KNOWS]->(u2:User) RETURN rel","/tmp/writeNodeProperties.json",{writeNodeProperties:true}})
```

result:

```json
{"rel":{"id":"0","type":"relationship","label":"KNOWS","properties":{"since":1993},"start":{"id":"0","labels":["User"],"properties":{"born":"2015-07-04T19:32:24","name":"Adam","place":{"crs":"wgs-84","latitude":33.46789,"longitude":13.1,"height":null},"age":42,"male":true,"kids":["Sam","Anna","Grace"]}},"end":{"id":"1","labels":["User"],"properties":{"name":"Jim","age":42}}}}
```

### [Export to Cypher Script](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#export-cypher)

If you are experimenting with imports that are failing you can add the `--debug` command line parameter, to see which statement was executed last and cause the failure.

Also check the memory configuration of your Neo4j instance, you might want to up the HEAP to **2–4GB** with the `dbms.memory.heap.max_size=2G` setting in `neo4j.conf`.

And provide more memory to cypher-shell itself by prefixing the command with: `JAVA_OPTS=-Xmx4G bin/cypher-shell …`

Make sure to set the config options in your `neo4j.conf`

neo4j.conf

```
apoc.export.file.enabled=true
apoc.import.file.enabled=true
```

Data is exported as Cypher statements to the given file.

It is possible to choose between three export formats:

- `neo4j-shell`: for Neo4j Shell and partly `apoc.cypher.runFile`
- `cypher-shell`: for Cypher shell
- `plain`: doesn’t output begin / commit / await just plain Cypher

You can also use the Optimizations like: `useOptimizations: {config}` Config could have this params:

- `unwindBatchSize`: (default 100)
- `type`: possible values ('NONE', 'UNWIND_BATCH', 'UNWIND_BATCH_PARAMS') (default 'UNWIND_BATCH')

With `NONE` it will export the file with `CREATE` statement;

With 'UNWIND_BATCH` it will export the file by batching the entities with the `UNWIND` method as explained in this [article](https://medium.com/neo4j/5-tips-tricks-for-fast-batched-updates-of-graph-structures-with-neo4j-and-cypher-73c7f693c8cc).

To change the export format, you have to set it on the config params like `{format : "cypher-shell"}`.

By default the format is `neo4j-shell`.

If you want to export to separate files, e.g. to later use the `apoc.cypher.runFiles/runSchemaFiles` procedures, you can add `separateFiles:true`.

It is possible to choose between four cypher update operation types: To change the cypher update operation, you have to set it on the config params like `{cypherFormat: "updateAll"}`

- `create`: all CREATE
- `updateAll`: MERGE instead of CREATE
- `addStructure`: MATCH for nodes + MERGE for rels
- `updateStructure`: MERGE + MATCH for nodes and rels

Format and cypherFormat can be used both in the same query giving you complete control over the exact export format:

```cypher
call apoc.export.cypher.query(
"MATCH (p1:Person)-[r:KNOWS]->(p2:Person) RETURN p1,r,p2",
"/tmp/friendships.cypher",
{format:'plain',cypherFormat:'updateStructure'})`
YIELD file, source, format, nodes, relationships, properties, time
```

| `apoc.export.cypher.all(file,config)`             | exports whole database incl. indexes as Cypher statements to the provided file |
| ------------------------------------------------- | ------------------------------------------------------------ |
| `apoc.export.cypher.data(nodes,rels,file,config)` | exports given nodes and relationships incl. indexes as Cypher statements to the provided file |
| `apoc.export.cypher.graph(graph,file,config)`     | exports given graph object incl. indexes as Cypher statements to the provided file |
| `apoc.export.cypher.query(query,file,config)`     | exports nodes and relationships from the Cypher statement incl. indexes as Cypher statements to the provided file |
| `apoc.export.cypher.schema(file,config)`          | exports all schema indexes and constraints to cypher         |

|      | The labels exported are ordered alphabetically. The output of `labels()` function is not sorted, use it in combination with `apoc.coll.sort()`. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Roundtrip Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_roundtrip_example)

You can use this roundtrip example e.g. on the `:play movies` movie graph.

Make sure to set the config options in your `neo4j.conf`

neo4j.conf

```
apoc.export.file.enabled=true
apoc.import.file.enabled=true
```

Export the data in plain format and multiple files:

```cypher
call apoc.export.cypher.query("match (n)-[r]->(n2) return * limit 100",
 "/tmp/mysubset.cypher",
 {format:'plain',separateFiles:true});
```

This should result in 4 files in your directory.

```shell
ls -1 /tmp/mysubset.*
/tmp/mysubset.cleanup.cypher
/tmp/mysubset.nodes.cypher
/tmp/mysubset.relationships.cypher
/tmp/mysubset.schema.cypher
```

Import the data in 4 steps, first the schema, then nodes and relationships, then cleanup.

------

call apoc.cypher.runSchemaFile('/tmp/mysubset.schema.cypher'); call apoc.cypher.runFiles(['/tmp/mysubset.nodes.cypher','/tmp/mysubset.relationships.cypher']);

call apoc.cypher.runFile('/tmp/mysubset.cleanup.cypher'); call apoc.cypher.runSchemaFile('/tmp/mysubset.cleanup.cypher'); ---

The `run*` procedures have some optional config:

- `{statistics:true/false}` to output a row of update-stats per statement, default is true
- `{timeout:1 or 10}` for how long the stream waits for new data, default is 10

#### [Stream back Exported Cypher Script as columns](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_stream_back_exported_cypher_script_as_columns)

If you leave off the file-name as `null` the export will instead be streamed back.

In general there will be a `cypherStatements` column with the script.

If you use multi-file-splitting as configuration parameter, there will be extra columns with content for

- nodeStatements
- relationshipStatements
- cleanupStatements
- schemaStatements

If you also specify the `streamStatements:true` then each batch (by `batchSize` which defaults to 10k) of statements will be returned as a row. So you can use your client to reconstruct the cypher script.

Simple Example for Streaming

```cypher
echo "
CALL apoc.export.cypher.all(null,{streamStatements:true,batchSize:100}) YIELD cypherStatements RETURN cypherStatements;
" | ./bin/cypher-shell --non-interactive --format plain
```

#### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_3)

##### [Old method:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_old_method)

exportAll (neo4j-shell format)

Without the optimizations

```cypher
CALL apoc.export.cypher.all({fileName},{config})
```

Result:

```cypher
begin
CREATE (:Foo:`UNIQUE IMPORT LABEL` {name:"foo", `UNIQUE IMPORT ID`:0});
CREATE (:Bar {name:"bar", age:42});
CREATE (:Bar:`UNIQUE IMPORT LABEL` {age:12, `UNIQUE IMPORT ID`:2});
commit
begin
CREATE INDEX ON :Foo(name);
CREATE CONSTRAINT ON (node:Bar) ASSERT node.name IS UNIQUE;
CREATE CONSTRAINT ON (node:`UNIQUE IMPORT LABEL`) ASSERT node.`UNIQUE IMPORT ID` IS UNIQUE;
commit
schema await
begin
MATCH (n1:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`:0}), (n2:Bar{name:"bar"}) CREATE (n1)-[:KNOWS]->(n2);
commit
begin
MATCH (n:`UNIQUE IMPORT LABEL`)  WITH n LIMIT 20000 REMOVE n:`UNIQUE IMPORT LABEL` REMOVE n.`UNIQUE IMPORT ID`;
commit
begin
DROP CONSTRAINT ON (node:`UNIQUE IMPORT LABEL`) ASSERT node.`UNIQUE IMPORT ID` IS UNIQUE;
commit
```

exportSchema (neo4j-shell format)

```cypher
CALL apoc.export.cypher.schema({fileName},{config})
```

Result:

```cypher
begin
CREATE INDEX ON :Foo(name);
CREATE CONSTRAINT ON (node:Bar) ASSERT node.name IS UNIQUE;
commit
schema await
```

##### [New method:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_new_method)

With the optimizations

```cypher
CALL apoc.export.cypher.all({fileName},{config})
```

Result:

```cypher
BEGIN
CREATE INDEX ON :Bar(first_name,last_name);
CREATE INDEX ON :Foo(name);
CREATE CONSTRAINT ON (node:Bar) ASSERT node.name IS UNIQUE;
CREATE CONSTRAINT ON (node:`UNIQUE IMPORT LABEL`) ASSERT node.`UNIQUE IMPORT ID` IS UNIQUE;
COMMIT
SCHEMA AWAIT
BEGIN
UNWIND [{_id:3, properties:{age:12}}] as row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:Bar;
UNWIND [{_id:2, properties:{age:12}}] as row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:Bar:Person;
UNWIND [{_id:0, properties:{born:date('2018-10-31'), name:"foo"}}, {_id:4, properties:{born:date('2017-09-29'), name:"foo2"}}] as row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:Foo;
UNWIND [{name:"bar", properties:{age:42}}, {name:"bar2", properties:{age:44}}] as row
CREATE (n:Bar{name: row.name}) SET n += row.properties;
UNWIND [{_id:6, properties:{age:99}}] as row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties;
COMMIT
BEGIN
UNWIND [{start: {_id:0}, end: {name:"bar"}, properties:{since:2016}}, {start: {_id:4}, end: {name:"bar2"}, properties:{since:2015}}] as row
MATCH (start:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.start._id})
MATCH (end:Bar{name: row.end.name})
CREATE (start)-[r:KNOWS]->(end) SET r += row.properties;
COMMIT
BEGIN
MATCH (n:`UNIQUE IMPORT LABEL`)  WITH n LIMIT 20000 REMOVE n:`UNIQUE IMPORT LABEL` REMOVE n.`UNIQUE IMPORT ID`;
COMMIT
BEGIN
DROP CONSTRAINT ON (node:`UNIQUE IMPORT LABEL`) ASSERT (node.`UNIQUE IMPORT ID`) IS UNIQUE;
COMMIT
```

### [GraphML Import / Export](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#graphml)

GraphML is used by other tools, like Gephi and CytoScape to read graph data.

```
YIELD file, source, format, nodes, relationships, properties, time
```

| `apoc.import.graphml(file-or-url,{batchSize: 10000, readLabels: true, storeNodeIds: false, defaultRelationshipType:"RELATED"})` | imports graphml into the graph                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.export.graphml.all(file,config)`                       | exports whole database as graphml to the provided file       |
| `apoc.export.graphml.data(nodes,rels,file,config)`           | exports given nodes and relationships as graphml to the provided file |
| `apoc.export.graphml.graph(graph,file,config)`               | exports given graph object as graphml to the provided file   |
| `apoc.export.graphml.query(query,file,config)`               | exports nodes and relationships from the Cypher statement as graphml to the provided file |

All `Point` or `Temporal` data types are exported formatted as a String

e.g:

| `Point 3d`      | {"crs":"wgs-84-3d","latitude":56.7,"longitude":12.78,"height":100.0} |
| --------------- | ------------------------------------------------------------ |
| `Point 2d`      | {"crs":"wgs-84-3d","latitude":56.7,"longitude":12.78,"height":null} |
| `Date`          | 2018-10-10                                                   |
| `LocalDateTime` | 2018-10-10T00:00                                             |

| param    | default | description                                                  |
| :------- | :------ | :----------------------------------------------------------- |
| format   |         | In export to Graphml script define the export format. Possible value is: "gephi" |
| caption  |         | It’s an array of string (i.e. ['name','title']) that define an ordered set of properties eligible as value for the `Label` value, if no match is found the there is a fallback to the node label, if the node label is missing the then the ID is used |
| useTypes | false   | Write the attribute type information to the graphml output   |

#### [Note:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_note_3)

The labels exported are ordered alphabetically. The output of `labels()` function is not sorted, use it in combination with `apoc.coll.sort()`.

| param                   | default       | description                                                  |
| :---------------------- | :------------ | :----------------------------------------------------------- |
| batchSize               | 20000         | define the batch size                                        |
| delim                   | ","           | define the delimiter character (export csv)                  |
| arrayDelim              | ";"           | define the delimiter character for arrays (used in the bulk import) |
| quotes                  | 'always'      | quote-character used for CSV, possible values are: 'always', 'none', 'ifNeeded' |
| useTypes                | false         | add type on file header (export csv and graphml export)      |
| format                  | "neo4j-shell" | In export to Cypher script define the export format. Possible values are: "cypher-shell","neo4j-shell" and "plain" |
| nodesOfRelationships    | false         | if enabled add relationship between nodes (export Cypher)    |
| storeNodeIds            | false         | set nodes' ids (import/export graphml)                       |
| readLabels              | false         | read nodes' labels (import/export graphml)                   |
| defaultRelationshipType | "RELATED"     | set relationship type (import/export graphml)                |
| separateFiles           | false         | export results in separated file by type (nodes, relationships..) |
| cypherFormat            | create        | In export to cypher script, define the cypher format (for example use `MERGE`instead of `CREATE`). Possible values are: "create", "updateAll", "addStructure", "updateStructure". |
| bulkImport              | true          | In export it creates files for Neo4j Admin import            |
| separateHeader          | false         | In export it creates two file one for header and one for data |

Values for the `quotes` configuration: * `none`: the same behaviour of the current `false` * `always`: the same behaviour of the current `true` * `ifNeeded`: it applies quotes only when it’s necessary;

When the config `bulkImport` is enable it create a list of file that can be used for Neo4j Bulk Import.

**This config can be used only with apoc.export.csv.all and apoc.export.csv.graph**

All file create are named as follow:

- Nodes file are construct with the name of the input file append with `.nodes.[LABEL_NAME].csv`
- Rel file are construct with the name of the input file append with `.relationships.[TYPE_NAME].csv`

If Node or Relationship have more than one Label/Type it will create one file for Label/Type.

## [Database Integration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#database-integration)

- [Load JDBC](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-jdbc)
- [Database Modeling](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#database-modeling)
- [ElasticSearch Integration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#elasticsearch)
- [Interacting with MongoDB](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#mongodb)
- [Interacting with Couchbase](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#couchbase)
- [Bolt](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#bolt-neo4j)
- [Load LDAP](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-ldap)

### [Load JDBC](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-jdbc)

#### [Overview: Database Integration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_overview_database_integration)

Data Integration is an important topic. Reading data from relational databases to create and augment data models is a very helpful exercise.

With `apoc.load.jdbc` you can access any database that provides a JDBC driver, and execute queries whose results are turned into streams of rows. Those rows can then be used to update or create graph structures.

<iframe width="560" height="315" src="https://www.youtube.com/embed/e8UfOHJngQA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

| type      | qualified name  | description                                                  |
| :-------- | :-------------- | :----------------------------------------------------------- |
| procedure | `apoc.load.xls` | apoc.load.xls('url','selector',{config}) YIELD lineNo, list, map - load XLS fom URL as stream of row values, config contains any of: {skip:1,limit:5,header:false,ignore:['tmp'],arraySep:';',mapping:{years:{type:'int',arraySep:'-',array:false,name:'age',ignore:false, dateFormat:'iso_date', dateParse:['dd-MM-yyyy']}} |
| procedure | `apoc.load.csv` | apoc.load.csv('url',{config}) YIELD lineNo, list, map - load CSV fom URL as stream of values, |

![apoc jdbc northwind load](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc-jdbc-northwind-load.jpg)

To simplify the JDBC URL syntax and protect credentials, you can configure aliases in `conf/neo4j.conf`:

```
apoc.jdbc.myDB.url=jdbc:derby:derbyDB
CALL apoc.load.jdbc('jdbc:derby:derbyDB','PERSON')

becomes

CALL apoc.load.jdbc('myDB','PERSON')
```

The 3rd value in the `apoc.jdbc.<alias>.url=` effectively defines an alias to be used in `apoc.load.jdbc('<alias>',….`

#### [MySQL Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_mysql_example)

Northwind is a common example set for relational databases, which is also covered in our import guides, e.g. :play northwind graph in the Neo4j browser.

##### [MySQL Northwind Data](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_mysql_northwind_data)

```
select count(*) from products;
+----------+
| count(*) |
+----------+
|       77 |
+----------+
1 row in set (0,00 sec)
describe products;
+-----------------+---------------+------+-----+---------+----------------+
| Field           | Type          | Null | Key | Default | Extra          |
+-----------------+---------------+------+-----+---------+----------------+
| ProductID       | int(11)       | NO   | PRI | NULL    | auto_increment |
| ProductName     | varchar(40)   | NO   | MUL | NULL    |                |
| SupplierID      | int(11)       | YES  | MUL | NULL    |                |
| CategoryID      | int(11)       | YES  | MUL | NULL    |                |
| QuantityPerUnit | varchar(20)   | YES  |     | NULL    |                |
| UnitPrice       | decimal(10,4) | YES  |     | 0.0000  |                |
| UnitsInStock    | smallint(2)   | YES  |     | 0       |                |
| UnitsOnOrder    | smallint(2)   | YES  |     | 0       |                |
| ReorderLevel    | smallint(2)   | YES  |     | 0       |                |
| Discontinued    | bit(1)        | NO   |     | b'0'    |                |
+-----------------+---------------+------+-----+---------+----------------+
10 rows in set (0,00 sec)
```

#### [Load JDBC Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_jdbc_examples)

Load the JDBC driver

```cypher
CALL apoc.load.driver("com.mysql.jdbc.Driver");
```

Count rows in products table

```cypher
with "jdbc:mysql://localhost:3306/northwind?user=root" as url
CALL apoc.load.jdbc(url,"products") YIELD row
RETURN count(*);
+----------+
| count(*) |
+----------+
| 77       |
+----------+
1 row
23 ms
```

Return row from products table

```cypher
with "jdbc:mysql://localhost:3306/northwind?user=root" as url
CALL apoc.load.jdbc(url,"products") YIELD row
RETURN row limit 1;
+--------------------------------------------------------------------------------+
| row                                                                            |
+--------------------------------------------------------------------------------+
| {UnitPrice -> 18.0000, UnitsOnOrder -> 0, CategoryID -> 1, UnitsInStock -> 39} |
+--------------------------------------------------------------------------------+
1 row
10 ms
```

![apoc load jdbc](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc-load-jdbc.jpg)

#### [Load JDBC with params Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_jdbc_with_params_examples)

```
with "select firstname, lastname from employees where firstname like ? and lastname like ?" as sql
call apoc.load.jdbcParams("northwind", sql, ['F%', '%w']) yield row
return row
```

JDBC pretends positional "?" for parameters, so the third apoc parameter has to be an array with values coherent with that positions. In case of 2 parameters, firstname and lastname ['firstname-position','lastname-position']

#### [Load data in transactional batches](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_data_in_transactional_batches)

You can load data from jdbc and create/update the graph using the query results in batches (and in parallel).

```cypher
CALL apoc.periodic.iterate('
call apoc.load.jdbc("jdbc:mysql://localhost:3306/northwind?user=root","company")',
'CREATE (p:Person) SET p += value', {batchSize:10000, parallel:true})
RETURN batches, total
```

#### [Cassandra Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_cassandra_example)

Setup Song database as initial dataset

```
curl -OL https://raw.githubusercontent.com/neo4j-contrib/neo4j-cassandra-connector/master/db_gen/playlist.cql
curl -OL https://raw.githubusercontent.com/neo4j-contrib/neo4j-cassandra-connector/master/db_gen/artists.csv
curl -OL https://raw.githubusercontent.com/neo4j-contrib/neo4j-cassandra-connector/master/db_gen/songs.csv
$CASSANDRA_HOME/bin/cassandra
$CASSANDRA_HOME/bin/cqlsh -f playlist.cql
```

Download the [Cassandra JDBC Wrapper](https://github.com/adejanovski/cassandra-jdbc-wrapper#installing), and put it into your `$NEO4J_HOME/plugins` directory. Add this config option to `$NEO4J_HOME/conf/neo4j.conf` to make it easier to interact with the cassandra instance.

Add to conf/neo4j.conf

```
apoc.jdbc.cassandra_songs.url=jdbc:cassandra://localhost:9042/playlist
```

Restart the server.

Now you can inspect the data in Cassandra with.

```cypher
CALL apoc.load.jdbc('cassandra_songs','artists_by_first_letter') yield row
RETURN count(*);
╒════════╕
│count(*)│
╞════════╡
│3605    │
└────────┘
CALL apoc.load.jdbc('cassandra_songs','artists_by_first_letter') yield row
RETURN row LIMIT 5;
CALL apoc.load.jdbc('cassandra_songs','artists_by_first_letter') yield row
RETURN row.first_letter, row.artist LIMIT 5;
╒════════════════╤═══════════════════════════════╕
│row.first_letter│row.artist                     │
╞════════════════╪═══════════════════════════════╡
│C               │C.W. Stoneking                 │
├────────────────┼───────────────────────────────┤
│C               │CH2K                           │
├────────────────┼───────────────────────────────┤
│C               │CHARLIE HUNTER WITH LEON PARKER│
├────────────────┼───────────────────────────────┤
│C               │Calvin Harris                  │
├────────────────┼───────────────────────────────┤
│C               │Camané                         │
└────────────────┴───────────────────────────────┘
```

Let’s create some graph data, we have a look at the track_by_artist table, which contains about 60k records.

```cypher
CALL apoc.load.jdbc('cassandra_songs','track_by_artist') yield row RETURN count(*);
CALL apoc.load.jdbc('cassandra_songs','track_by_artist') yield row
RETURN row LIMIT 5;
CALL apoc.load.jdbc('cassandra_songs','track_by_artist') yield row
RETURN row.track_id, row.track_length_in_seconds, row.track, row.music_file, row.genre, row.artist, row.starred LIMIT 2;
╒════════════════════════════════════╤══════╤════════════════╤══════════════════╤═════════╤════════════════════════════╤═══════════╕
│row.track_id                        │length│row.track       │row.music_file    │row.genre│row.artist                  │row.starred│
╞════════════════════════════════════╪══════╪════════════════╪══════════════════╪═════════╪════════════════════════════╪═══════════╡
│c0693b1e-0eaa-4e81-b23f-b083db303842│219   │1913 Massacre   │TRYKHMD128F934154C│folk     │Woody Guthrie & Jack Elliott│false      │
├────────────────────────────────────┼──────┼────────────────┼──────────────────┼─────────┼────────────────────────────┼───────────┤
│7d114937-0bc7-41c7-8e0c-94b5654ac77f│178   │Alabammy Bound  │TRMQLPV128F934152B│folk     │Woody Guthrie & Jack Elliott│false      │
└────────────────────────────────────┴──────┴────────────────┴──────────────────┴─────────┴────────────────────────────┴───────────┘
```

Let’s create some indexes and constraints, note that other indexes and constraints will be dropped by this.

```cypher
CALL apoc.schema.assert(
  {Track:['title','length']},
  {Artist:['name'],Track:['id'],Genre:['name']});
╒════════════╤═══════╤══════╤═══════╕
│label       │key    │unique│action │
╞════════════╪═══════╪══════╪═══════╡
│Track       │title  │false │CREATED│
├────────────┼───────┼──────┼───────┤
│Track       │length │false │CREATED│
├────────────┼───────┼──────┼───────┤
│Artist      │name   │true  │CREATED│
├────────────┼───────┼──────┼───────┤
│Genre       │name   │true  │CREATED│
├────────────┼───────┼──────┼───────┤
│Track       │id     │true  │CREATED│
└────────────┴───────┴──────┴───────┘
CALL apoc.load.jdbc('cassandra_songs','track_by_artist') yield row
MERGE (a:Artist {name:row.artist})
MERGE (g:Genre {name:row.genre})
CREATE (t:Track {id:toString(row.track_id), title:row.track, length:row.track_length_in_seconds})
CREATE (a)-[:PERFORMED]->(t)
CREATE (t)-[:GENRE]->(g);
Added 63213 labels, created 63213 nodes, set 182413 properties, created 119200 relationships, statement executed in 40076 ms.
```

#### [Support for Hive with Kerberos Auth](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_support_for_hive_with_kerberos_auth)

Support for Hive especially with Kerberos is more involved.

First of all the required configuration is more detailed, make sure to get this information:

- kerberos user / password
- kerberos realm / kdc
- hive hostname + port (10000)

Create this `login.conf` file at a known location:

login.conf

```
KerberosClient {
  com.sun.security.auth.module.Krb5LoginModule required
  debug=true debugNative=true;
};
```

Add these options to your `conf/neo4j.conf`

neo4j.conf

```
dbms.jvm.additional=-Djava.security.auth.login.config=/path/to/login.conf
dbms.jvm.additional=-Djava.security.auth.login.config.client=KerberosClient
dbms.jvm.additional=-Djava.security.krb5.realm=KRB.REALM.COM
dbms.jvm.additional=-Djava.security.krb5.kdc=krb-kdc.host.com
```

Unlike other JDBC drivers, Hive comes with a bunch of dependencies, you can download these from the Hadoop providers

- [Cloudera Hive Drivers](https://www.cloudera.com/downloads/connectors/hive/jdbc/2-5-20.html)
- [Hortonworks Hive Drivers](https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.3/bk_data-access/content/hive-jdbc-odbc-drivers.html)
- [Apache Hive Driver](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBC)

or grab them from [maven central](https://search.maven.org/).

The versions might vary, use what comes with your Hive driver.

- hadoop-common-2.7.3.2.6.1.0-129.jar
- hive-exec-1.2.1000.2.6.1.0-129.jar
- hive-jdbc-1.2.1000.2.6.1.0-129.jar
- hive-metastore-1.2.1000.2.6.1.0-129.jar
- hive-service-1.2.1000.2.6.1.0-129.jar
- httpclient-4.4.jar
- httpcore-4.4.jar
- libfb303-0.9.2.jar
- libthrift-0.9.3.jar

Now you can use a JDBC URL like this from APOC.

|      | This has no newlines, it’s just wrapped because it is too long. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

```
jdbc:hive2://username%40krb-realm:password@hive-hostname:10000/default;principal=hive/hostname@krb-realm;auth=kerberos;kerberosAuthType=fromSubject
```

And then call:

```cypher
WITH 'jdbc:hive2://username%40krb-realm:password@hive-hostname:10000/default;principal=hive/hostname@krb-realm;auth=kerberos;kerberosAuthType=fromSubject' AS url
CALL apoc.load.jdbc(url,'PRODUCTS') YIELD row
RETURN row.name, row.price;
```

You can also set it in your `conf/neo4j.conf` as a key:

neo4j.conf

```
apoc.jdbc.my-hive.url=jdbc:hive2://username%40krb-realm:password@hive-hostname:10000/default;principal=hive/hostname@krb-realm;auth=kerberos;kerberosAuthType=fromSubject
```

And then use the more compact call:

```cypher
CALL apoc.load.jdbc('my-hive','SELECT * PRODUCTS');
```

#### [LOAD JDBC - Resources](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_jdbc_resources)

To use other JDBC drivers use these download links and JDBC URL. Put the JDBC driver into the `$NEO4J_HOME/plugins`directory and configure the JDBC-URL in `$NEO4J_HOME/conf/neo4j.conf` with `apoc.jdbc.<alias>.url=<jdbc-url>`

Credentials can be passed in two ways:

- into url

```
CALL apoc.load.jdbc('jdbc:derby:derbyDB;user=apoc;password=Ap0c!#Db;create=true', 'PERSON')
```

- by config parameter.

```
CALL apoc.load.jdbc('jdbc:derby:derbyDB', 'PERSON',[],{credentials:{user:'apoc',password:'Ap0c!#Db'}})
```

| Database                  | JDBC-URL                                                     | Driver Source                                                |
| :------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| MySQL                     | `jdbc:mysql://<hostname>:<port/3306>/<database>?user=<user>&password=<pass>` | [MySQL Driver](http://dev.mysql.com/downloads/connector/j/)  |
| Postgres                  | `jdbc:postgresql://<hostname>/<database>?user=<user>&password=<pass>` | [PostgresSQL JDBC Driver](https://jdbc.postgresql.org/download.html) |
| Oracle                    | `jdbc:oracle:thin:<user>/<pass>@<host>:<port>/<service_name>` | [Oracle JDBC Driver](http://www.oracle.com/technetwork/database/features/jdbc/index.html) |
| MS SQLServer              | `jdbc:sqlserver://;servername=<servername>;databaseName=<database>;user=<user>;password=<pass>` | [SQLServer Driver](https://www.microsoft.com/en-us/download/details.aspx?id=11774) |
| IBM DB2                   | `jdbc:db2://<host>:<port/5021>/<database>:user=<user>;password=<pass>;` | [DB2 Driver](http://www-01.ibm.com/support/docview.wss?uid=swg21363866) |
| Derby                     | `jdbc:derby:derbyDB`                                         | Included in JDK6-8                                           |
| Cassandra                 | `jdbc:cassandra://<host>:<port/9042>/<database>`             | [Cassandra JDBC Wrapper](https://github.com/adejanovski/cassandra-jdbc-wrapper#installing) |
| SAP Hana                  | `jdbc:sap://<host>:<port/39015>/?user=<user>&password=<pass>` | [SAP Hana ngdbc Driver](https://www.sap.com/developer/topics/sap-hana-express.html) |
| Apache Hive (w/ Kerberos) | `jdbc:hive2://username%40krb-realm:password@hostname:10000/default;principal=hive/hostname@krb-realm;auth=kerberos;kerberosAuthType=fromSubject` | [Apache Hive Driver](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBC)[(Cloudera)](https://www.cloudera.com/downloads/connectors/hive/jdbc/2-5-20.html)[(Hortonworks)](https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.3/bk_data-access/content/hive-jdbc-odbc-drivers.html)There are several jars (hadoop-common-xxx.jar hive-exec-xxx.jar hive-jdbc-xxx.jar hive-metastore-xxx.jar hive-service-xxx.jar httpclient-4.4.jar httpcore-4.4.jar libfb303-0.9.2.jar libthrift-0.9.3.jar) |

There are a number of blog posts / examples that details usage of apoc.load.jdbc

- [Explore your browser history in Neo4j](https://jesusbarrasa.wordpress.com/2016/09/30/quickgraph4-explore-your-browser-history-in-neo4j/)
- [Neo4j With Scala : Migrate Data From Other Database to Neo4j](https://blog.knoldus.com/2016/09/12/neo4j-with-scala-migrate-data-from-other-database-to-neo4j/)
- [APOC: Database Integration, Import and Export with Awesome Procedures On Cypher](https://neo4j.com/blog/apoc-database-integration-import-export-cypher/)

#### [LOAD JDBC - UPDATE](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_jdbc_update)

The jdbcUpdate is use for update relational database, from a SQL statement with optional parameters

```cypher
CALL apoc.load.jdbcUpdate(jdbc-url,statement, params, config) YIELD  row;
```

With this set of data you can call the procedure in two different mode:

```cypher
MATCH (u:User)-[:BOUGHT]->(p:Product)<-[:BOUGHT]-(o:User)-[:BOUGHT]->(reco)
WHERE u <> o AND NOT (u)-[:BOUGHT]->(reco)
WITH u, reco, count(*) as score
WHERE score > 1000
```

You can call the procedure with param:

```cypher
CALL apoc.load.jdbcUpdate('jdbc:mysql:....','INSERT INTO RECOMMENDATIONS values(?,?,?)',[user.id, reco.id, score]) YIELD row;
```

You can call the procedure without param:

```cypher
CALL apoc.load.jdbcUpdate('jdbc:mysql:....','INSERT INTO RECOMMENDATIONS values(user.id, reco.id, score)') YIELD row;
```

##### [Load JDBC format date](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_jdbc_format_date)

Starting from Neo4j 3.4 there is the support for [Temporal Values](https://neo4j.com/docs/developer-manual/current/cypher/syntax/temporal/)

If the returning JdbcType, from the load operation, is TIMESTAMP or TIMESTAMP_WITH_TIMEZONE you could provide the configuration parameter **timezone** with type [java.time.ZoneId](https://docs.oracle.com/javase/8/docs/api/java/time/ZoneId.html)

```cypher
CALL apoc.load.jdbc('key or url','table or statement', config) YIELD row
```

##### [Config](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_config_2)

Config param is optional, the default value is an empty map.

| `timezone`    | default value: null |
| ------------- | ------------------- |
| `credentials` | default value: {}   |

Example:

with timezone

```cypher
CALL apoc.load.jdbc('jdbc:derby:derbyDB','SELECT * FROM PERSON WHERE NAME = ?',['John'], {timezone: "Asia/Tokyo"})
2018-10-31T01:32:25.012+09:00[Asia/Tokyo]
```

with credentials

```cypher
CALL apoc.load.jdbcUpdate('jdbc:derby:derbyDB','UPDATE PERSON SET NAME = ? WHERE NAME = ?',['John','John'],{credentials:{user:'apoc',password:'Ap0c!#Db'}})
CALL apoc.load.jdbc('jdbc:derby:derbyDB', 'PERSON',[],{credentials:{user:'apoc',password:'Ap0c!#Db'}})
```

### [Database Modeling](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#database-modeling)

This new package provides a set of function in order to extract metadata information from different data sources such as RDBMS, JSON file etc

- `apoc.model.jdbc('key or url', {schema:'<schema>', write: <true/false>, filters: { tables:[], views: [], columns: []}) YIELD nodes, relationships`: load schema from relational databases

#### [`apoc.model.jdbc`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_code_apoc_model_jdbc_code)

The procedure allows to extract metadata information by any JDBC compatible db.

##### [Configuration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_configuration)

| Config   | Type                                        | Description                                                  |
| :------- | :------------------------------------------ | :----------------------------------------------------------- |
| `schema` | `String. Default empty`                     | The schema name.                                             |
| `write`  | `boolean. Default false`                    | If you want persist the data on Neo4j                        |
| filters  | `map<String, Array<String>>. Default empty` | A set of filters for each object type `tables`, `views`, `columns` |

###### [Filters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_filters)

| Config    | Type            | Description                                                  |
| :-------- | :-------------- | :----------------------------------------------------------- |
| `tables`  | `Array<String>` | A set of regex patterns that, if matched, exclude the tables |
| `views`   | `Array<String>` | A set of regex patterns that, if matched, exclude the views  |
| `columns` | `Array<String>` | A set of regex patterns that, if matched, exclude the columns |

##### [Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_3)

Starting from the following schema:

```sql
 CREATE TABLE "country" (
   "Code" CHAR(3) NOT NULL DEFAULT '',
   "Name" CHAR(52) NOT NULL DEFAULT '',
   "Continent" enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
   "Region" CHAR(26) NOT NULL DEFAULT '',
   "SurfaceArea" FLOAT(10,2) NOT NULL DEFAULT '0.00',
   "IndepYear" SMALLINT(6) DEFAULT NULL,
   "Population" INT(11) NOT NULL DEFAULT '0',
   "LifeExpectancy" FLOAT(3,1) DEFAULT NULL,
   "GNP" FLOAT(10,2) DEFAULT NULL,
   "GNPOld" FLOAT(10,2) DEFAULT NULL,
   "LocalName" CHAR(45) NOT NULL DEFAULT '',
   "GovernmentForm" CHAR(45) NOT NULL DEFAULT '',
   "HeadOfState" CHAR(60) DEFAULT NULL,
   "Capital" INT(11) DEFAULT NULL,
   "Code2" CHAR(2) NOT NULL DEFAULT '',
   PRIMARY KEY ("Code")
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 CREATE TABLE "city" (
   "ID" INT(11) NOT NULL AUTO_INCREMENT,
   "Name" CHAR(35) NOT NULL DEFAULT '',
   "CountryCode" CHAR(3) NOT NULL DEFAULT '',
   "District" CHAR(20) NOT NULL DEFAULT '',
   "Population" INT(11) NOT NULL DEFAULT '0',
   PRIMARY KEY ("ID"),
   KEY "CountryCode" ("CountryCode"),
   CONSTRAINT "city_ibfk_1" FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code")
 ) ENGINE=InnoDB AUTO_INCREMENT=4080 DEFAULT CHARSET=latin1;

 CREATE TABLE "countrylanguage" (
   "CountryCode" CHAR(3) NOT NULL DEFAULT '',
   "Language" CHAR(30) NOT NULL DEFAULT '',
   "IsOfficial" enum('T','F') NOT NULL DEFAULT 'F',
   "Percentage" FLOAT(4,1) NOT NULL DEFAULT '0.0',
   PRIMARY KEY ("CountryCode","Language"),
   KEY "CountryCode" ("CountryCode"),
   CONSTRAINT "countryLanguage_ibfk_1" FOREIGN KEY ("CountryCode") REFERENCES "country" ("Code")
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
```

By doing this procedure call:

```
call apoc.model.jdbc('jdbc:mysql://mysql:3306', {schema: 'test', credentials: {user: 'root', password: 'andrea'}})
```

You’ll get the following result:

![apoc.model](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.model.jdbc)

### [ElasticSearch Integration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#elasticsearch)

#### [Interacting with Elastic Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_interacting_with_elastic_search)

| `apoc.es.stats(host-url-Key)`                                | elastic search statistics    |
| ------------------------------------------------------------ | ---------------------------- |
| `apoc.es.get(host-or-port,index-or-null,type-or-null,id-or-null,query-or-null,payload-or-null) yield value` | perform a GET operation      |
| `apoc.es.query(host-or-port,index-or-null,type-or-null,query-or-null,payload-or-null) yield value` | perform a SEARCH operation   |
| `apoc.es.getRaw(host-or-port,path,payload-or-null) yield value` | perform a raw GET operation  |
| `apoc.es.postRaw(host-or-port,path,payload-or-null) yield value` | perform a raw POST operation |
| `apoc.es.post(host-or-port,index-or-null,type-or-null,query-or-null,payload-or-null) yield value` | perform a POST operation     |
| `apoc.es.put(host-or-port,index-or-null,type-or-null,query-or-null,payload-or-null) yield value` | perform a PUT operation      |

| type      | qualified name    | description                                                  |
| :-------- | :---------------- | :----------------------------------------------------------- |
| procedure | `apoc.es.stats`   | apoc.es.stats(host-url-Key) - elastic search statistics      |
| procedure | `apoc.es.get`     | apoc.es.get(host-or-port,index-or-null,type-or-null,id-or-null,query-or-null,payload-or-null) yield value - perform a GET operation on elastic search |
| procedure | `apoc.es.query`   | apoc.es.query(host-or-port,index-or-null,type-or-null,query-or-null,payload-or-null) yield value - perform a SEARCH operation on elastic search |
| procedure | `apoc.es.getRaw`  | apoc.es.getRaw(host-or-port,path,payload-or-null) yield value - perform a raw GET operation on elastic search |
| procedure | `apoc.es.postRaw` | apoc.es.postRaw(host-or-port,path,payload-or-null) yield value - perform a raw POST operation on elastic search |
| procedure | `apoc.es.post`    | apoc.es.post(host-or-port,index-or-null,type-or-null,query-or-null,payload-or-null) yield value - perform a POST operation on elastic search |
| procedure | `apoc.es.put`     | apoc.es.put(host-or-port,index-or-null,type-or-null,id-or-null,query-or-null,payload-or-null) yield value - perform a PUT operation on elastic search |

#### [Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_4)

```cypher
call apoc.es.post("localhost","tweets","users",null,{name:"Chris"})
call apoc.es.put("localhost","tweets","users","1",null,{name:"Chris"})
call apoc.es.get("localhost","tweets","users","1",null,null)
call apoc.es.stats("localhost")
```

![qHAj9ma](http://i.imgur.com/qHAj9ma.png)

##### [Pagination](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_pagination)

To use the pagination feature of Elasticsearch you have to follow these steps:

1. Call **apoc.es.query** to get the first chunk of data and obtain also the scroll_id (in order to enable the pagination).
2. Do your merge/create etc. operations with the first N hits
3. Use the **range(start,end,step)** function to repeat a second call to get all the other chunks until the end. For example, if you have 1000 documents and you want to retrieve 10 documents for each request, you cand do **range(11,1000,10)**. You start from 11 because the first 10 documents are already processed. If you don’t know the exact upper bound (the total size of your documents) you can set a number that is bigger than the real total size.
4. The second call to repeat is **apoc.es.get**. Remember to set the **scroll_id** as a parameter.
5. Then process the result of each chunk of data as the first one.

Here an example:

```cypher
// It's important to create an index to improve performance
CREATE INDEX ON :Document(id)
// First query: get first chunk of data + the scroll_id for pagination
CALL apoc.es.query('localhost','test-index','test-type','name:Neo4j&size=1&scroll=5m',null) yield value with value._scroll_id as scrollId, value.hits.hits as hits
// Do something with hits
UNWIND hits as hit
// Here we simply create a document and a relation to a company
MERGE (doc:Document {id: hit._id, description: hit._source.description, name: hit._source.name})
MERGE (company:Company {name: hit._source.company})
MERGE (doc)-[:IS_FROM]->(company)
// Then call for the other docs and use the scrollId value from previous query
// Use a range to count our chunk of data (i.e. i want to get chunks from 2 to 10)
WITH range(2,10,1) as list, scrollId
UNWIND list as count
CALL apoc.es.get("localhost","_search","scroll",null,{scroll:"5m",scroll_id:scrollId},null) yield value with value._scoll_id as scrollId, value.hits.hits as nextHits
// Again, do something with hits
UNWIND nextHits as hit
MERGE (doc:Document {id: hit._id, description: hit._source.description, name: hit._source.name})
MERGE (company:Company {name: hit._source.company})
MERGE (doc)-[:IS_FROM]->(company) return scrollId, doc, company
```

This example was tested on a Mac Book Pro with 16GB of RAM. Loading 20000 documents from ES to Neo4j (100 documents for each request) took 1 minute.

#### [General Structure and Parameters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_general_structure_and_parameters)

```cypher
call apoc.es.post(host-or-port,index-or-null,type-or-null,id-or-null,query-or-null,payload-or-null) yield value

// GET/PUT/POST url/index/type/id?query -d payload
```

##### [host or port parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_host_or_port_parameter)

The parameter can be a direct host or url, or an entry to be lookup up in neo4j.conf

- host
- host:port
- [http://host:port](http://host:port/)
- lookup via key to apoc.es.<key>.url
- lookup via key apoc.es.<key>.host
- lookup apoc.es.url
- lookup apoc.es.host

##### [index parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_index_parameter)

Main ES index, will be sent directly, if null then "_all" multiple indexes can be separated by comma in the string.

##### [type parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_type_parameter)

Document type, will be sent directly, if null then "_all" multiple types can be separated by comma in the string.

##### [id parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_id_parameter)

Document id, will be left off when null.

##### [query parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_query_parameter)

Query can be a map which is turned into a query string, a direct string or null then it is left off.

##### [payload parameter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_payload_parameter)

Payload can be a **map** which will be turned into a json payload or a string which will be sent directly or null.

##### [Results](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_results)

Results are stream of map in value.

### [Interacting with MongoDB](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#mongodb)

| `CALL apoc.mongodb.get(host-or-port,db-or-null,collection-or-null,query-or-null,[compatibleValues=true|false],skip-or-null,limit-or-null) yield value` | perform a find operation on mongodb collection               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.mongodb.count(host-or-port,db-or-null,collection-or-null,query-or-null) yield value` | perform a find operation on mongodb collection               |
| `CALL apoc.mongodb.first(host-or-port,db-or-null,collection-or-null,query-or-null,[compatibleValues=true|false]) yield value` | perform a first operation on mongodb collection              |
| `CALL apoc.mongodb.find(host-or-port,db-or-null,collection-or-null,query-or-null,projection-or-null,sort-or-null,[compatibleValues=true|false],skip-or-null) yield value` | perform a find,project,sort operation on mongodb collection  |
| `CALL apoc.mongodb.insert(host-or-port,db-or-null,collection-or-null,list-of-maps)` | inserts the given documents into the mongodb collection      |
| `CALL apoc.mongodb.delete(host-or-port,db-or-null,collection-or-null,list-of-maps) yield value` | deletes the given documents from the mongodb collection and returns the number of affected documents |
| `CALL apoc.mongodb.update(host-or-port,db-or-null,collection-or-null,list-of-maps) yield value` | updates the given documents from the mongodb collection and returns the number of affected documents |

If your documents have date fields or any other type that can be automatically converted by Neo4j, you need to set **compatibleValues** to true. These values will be converted according to Jackson databind default mapping.

Copy these jars into the plugins directory:

- bson-3.4.2.jar
- mongo-java-driver-3.4.2.jar
- mongodb-driver-3.4.2.jar
- mongodb-driver-core-3.4.2.jar

You should be able to get them from [here](https://mongodb.github.io/mongo-java-driver/), and [here (BSON)](https://mvnrepository.com/artifact/org.mongodb/bson/3.4.2) (via Download)

Or you get them locally from your gradle build of apoc.

```
gradle copyRuntimeLibs
cp lib/mongodb*.jar lib/bson*.jar $NEO4J_HOME/plugins/
CALL apoc.mongodb.first('mongodb://localhost:27017','test','test',{name:'testDocument'})
```

If you need automatic conversion of **unpackable** values then the cypher query will be:

```cypher
CALL apoc.mongodb.first('mongodb://localhost:27017','test','test',{name:'testDocument'},true)
```

### [Interacting with Couchbase](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#couchbase)

| `CALL apoc.couchbase.get(hostOrKey, bucket, documentId) yield id, expiry, cas, mutationToken, content` | Retrieves a couchbase json document by its unique ID         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.couchbase.exists(hostOrKey, bucket, documentId) yield value` | Check whether a couchbase json document with the given ID does exist |
| `CALL apoc.couchbase.insert(hostOrKey, bucket, documentId, jsonDocument) yield id, expiry, cas, mutationToken, content` | Insert a couchbase json document with its unique ID          |
| `CALL apoc.couchbase.upsert(hostOrKey, bucket, documentId, jsonDocument) yield id, expiry, cas, mutationToken, content` | Insert or overwrite a couchbase json document with its unique ID |
| `CALL apoc.couchbase.append(hostOrKey, bucket, documentId, jsonDocument) yield id, expiry, cas, mutationToken, content` | Append a couchbase json document to an existing one          |
| `CALL apoc.couchbase.prepend(hostOrKey, bucket, documentId, jsonDocument) yield id, expiry, cas, mutationToken, content` | Prepend a couchbase json document to an existing one         |
| `CALL apoc.couchbase.remove(hostOrKey, bucket, documentId) yield id, expiry, cas, mutationToken, content` | Remove the couchbase json document identified by its unique ID |
| `CALL apoc.couchbase.replace(hostOrKey, bucket, documentId, jsonDocument) yield id, expiry, cas, mutationToken, content` | Replace the content of the couchbase json document identified by its unique ID. |
| `CALL apoc.couchbase.query(hostOrKey, bucket, statement) yield queryResult` | Executes a plain un-parameterized N1QL statement.            |
| `CALL apoc.couchbase.posParamsQuery(hostOrKey, bucket, statement, params) yield queryResult` | Executes a N1QL statement with positional parameters.        |
| `CALL apoc.couchbase.namedParamsQuery(hostOrKey, bucket, statement, paramNames, paramValues) yield queryResult` | Executes a N1QL statement with named parameters.             |

Copy these jars into the plugins directory:

(Tested with CB Enterprise 5.5.3, note that CB 6 is not yet supported)

```shell
mvn dependency:copy-dependencies
cp target/dependency/java-client-2.5.9.jar target/dependency/core-io-1.5.2.jar target/dependency/rxjava-1.3.8.jar $NEO4J_HOME/plugins/
```

To interact with Couchbase you can define the host on which to connect to as the first parameter of the procedure (with bucket as second parameter, document_id as third parameter):

```cypher
CALL apoc.couchbase.get('couchbase://Administrator:password@localhost', 'default', 'artist:vincent_van_gogh')
```

Otherwise you can use configuration properties in the same way as MongoDB. For example, you can add the following properties to the neo4j.conf file:

```
apoc.couchbase.mykey.username=Administrator
apoc.couchbase.mykey.password=password
apoc.couchbase.mykey.uri=host1,host2,host3 // here you can define more than one hostname if you're using a cluster
apoc.couchbase.mykey.port=8091 // the bootstrapHttpDirectPort (optional)
CALL apoc.couchbase.get('mykey', 'default', 'artist:vincent_van_gogh')
```

You can also define some CouchbaseEnvironment parameters in the neo4j.conf:

```
apoc.couchbase.connectTimeout=<default=5000>
apoc.couchbase.socketConnectTimeout=<default=1500>
apoc.couchbase.kvTimeout=<default=2500>
apoc.couchbase.ioPoolSize=<default=3>
apoc.couchbase.computationPoolSize=<default=3>
```

In order to get an in-depth description of these configuration params please refer to the [Official Couchbase Documentation](https://docs.couchbase.com/java-sdk/2.7/client-settings.html)

### [Bolt](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#bolt-neo4j)

Bolt procedures allows to accessing other databases via bolt protocol.

| `CALL apoc.bolt.execute(urlOrKey, statement, params, config) YIELD row` | access to other databases via bolt for read and write |
| ------------------------------------------------------------ | ----------------------------------------------------- |
| `CALL apoc.bolt.load(urlOrKey, statement, params, config) YIELD row` | access to other databases via bolt for read           |

**urlOrKey** param allows users to decide if send url by apoc or if put it into neo4j.conf file.

- **apoc** : write the complete url in his right position on the apoc.

```cypher
call apoc.bolt.load("bolt://user:password@localhost:7687","match(p:Person {name:{name}}) return p", {name:'Michael'})
```

- **neo4j.conf** : here the are two choices:

1) **complete url**: write the complete url with the param apoc.bolt.url;

apoc

```cypher
call apoc.bolt.load("","match(p:Person {name:{name}}) return p", {name:'Michael'})
```

neo4jConf

```txt
//simple url
apoc.bolt.url=bolt://user:password@localhost:7687
```

2) **by key**: set the url with a personal key apoc.bolt.yourKey.url; in this case in the apoc on the url param user has to insert the key.

apoc

```cypher
call apoc.bolt.load("test","match(p:Person {name:{name}}) return p", {name:'Michael'})
```

neo4jConf

```txt
//with key
apoc.bolt.test.url=bolt://user:password@localhost:7687
apoc.bolt.production.url=bolt://password:test@localhost:7688
```

Config available are:

- `statistics`: possible values are true/false, the default value is false. This config print the execution statistics;
- `virtual`: possible values are true/false, the default value is false. This config return result in virtual format and not in map format, in apoc.bolt.load.

#### [Driver configuration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_driver_configuration)

To set the configuration of the Driver, you can add the parameter `driverConfig` in the config. Is’s a map of values, the values that we don’t pass to the config, are set to the default value.

```cypher
{logging='INFO', encryption=true, logLeakedSessions:true, maxIdleConnectionPoolSize:10, idleTimeBeforeConnectionTest:-1, trustStrategy:'TRUST_ALL_CERTIFICATES',
 routingFailureLimit: 1, routingRetryDelayMillis:5000, connectionTimeoutMillis:5000, maxRetryTimeMs:30000 }
```

| param                        | description                                                  | possible values/ types                                       |
| :--------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| logging                      | logging provider to use                                      | INFO, WARNING, OFF, SEVERE, CONFIG, FINE, FINER              |
| encryption                   | Disable or enabled encryption                                | true, false                                                  |
| logLeakedSessions            | Disable or enable logging of leaked sessions                 | true, false                                                  |
| maxIdleConnectionPoolSize    | Max number of connections                                    | number                                                       |
| idleTimeBeforeConnectionTest | Pooled connections that have been idle in the pool for longer than this timeout | Milliseconds                                                 |
| trustStrategy                | Specify how to determine the authenticity of an encryption certificate provided by the Neo4j instance we are connecting to | TRUST_ALL_CERTIFICATES, TRUST_SYSTEM_CA_SIGNED_CERTIFICATES, or directly a custom certificate |
| routingFailureLimit          | the number of times to retry each server in the list of routing servers | number                                                       |
| routingRetryDelayMillis      | Specify how long to wait before retrying to connect to a routing server | Milliseconds                                                 |
| connectionTimeoutMillis      | Specify socket connection timeout                            | Milliseconds                                                 |
| maxRetryTimeMs               | Specify the maximum time transactions are allowed to retry   | Milliseconds                                                 |

You can find all the values in the documentation [Config.ConfigBuilder](http://neo4j.com/docs/api/java-driver/current/org/neo4j/driver/v1/Config.ConfigBuilder.html)

#### [Bolt Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_bolt_examples)

**Return node in map format**

```cypher
call apoc.bolt.execute("bolt://user:password@localhost:7687",
"match(p:Person {name:{name}}) return p", {name:'Michael'})
```

![apoc.bolt.execute.nodemap](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.execute.nodemap.PNG)

**Return node in virtual Node format**

```cypher
call apoc.bolt.load("bolt://user:password@localhost:7687",
"match(p:Person {name:{name}}) return p", {name:'Michael'}, {virtual:true})
```

![apoc.bolt.load.virtualnode](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.load.virtualnode.PNG)

**Create node and return statistic**

```cypher
call apoc.bolt.execute("bolt://user:password@localhost:7687",
"create(n:Node {name:{name}})", {name:'Node1'}, {statistics:true})
```

![apoc.bolt.execute.createandstatistics](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.execute.createandstatistics.PNG)

**Return more scalar values**

```cypher
call apoc.bolt.execute("bolt://user:password@localhost:7687",
"match (n:Person {name:{name}}) return n.age as age, n.name as name, n.surname as surname", {name:'Michael'})
```

![apoc.bolt.execute.scalarmulti](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.execute.scalarmulti.PNG)

**Return relationship in a map format**

```cypher
call apoc.bolt.load("bolt://user:password@localhost:7687",
"MATCH (n:Person{name:{name}})-[r:KNOWS]->(p) return r as rel", {name:'Anne'})
```

![apoc.bolt.load.relmap](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.load.relmap.PNG)

**Return virtual path**

```cypher
call apoc.bolt.load("bolt://user:password@localhost:7687",
"START n=node({idNode}) MATCH path= (n)-[r:REL_TYPE*..3]->(o) return path", {idNode:200}, {virtual:true})
```

![apoc.bolt.load.returnvirtualpath](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.load.returnvirtualpath.PNG)

**Create a Node with params in input**

```cypher
call apoc.bolt.execute("bolt://user:password@localhost:7687",
"CREATE (n:Car{brand:{brand},model:{model},year:{year}}) return n", {brand:'Ferrari',model:'California',year:2016})
```

![apoc.bolt.execute.createwithparams](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.bolt.execute.createwithparams.PNG)

### [Load LDAP](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#load-ldap)

With 'apoc.load.ldap' you can execute queries on any LDAP v3 enabled directory, the results are turned into a streams of entries. The entries can then be used to update or create graph structures.

Note this utility requires to have the [jldap](https://mvnrepository.com/artifact/com.novell.ldap/jldap/2009-10-07) library to be placed the plugin directory.

| procedure | apoc.load.jdbcParams | deprecated - please use: apoc.load.jdbc('key or url','',[params]) YIELD row - load from relational database, from a sql statement with parameters |
| :-------- | :------------------- | :----------------------------------------------------------- |
|           |                      |                                                              |

#### [Parameters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_parameters)

| Parameter       | Property       | Description                                                  |
| :-------------- | :------------- | :----------------------------------------------------------- |
| {connectionMap} | `ldapHost`     | the ldapserver:port if port is omitted the default port 389 will be used |
|                 | `loginDN`      | This is the dn of the ldap server user who has read access on the ldap server |
|                 | `loginPW`      | This is the password used by the loginDN                     |
| {searchMap}     | `searchBase`   | From this entry a search is executed                         |
|                 | `searchScope`  | SCOPE_ONE (one level) or SCOPE_SUB (all sub levels) or SCOPE_BASE (only the base node) |
|                 | `searchFilter` | Place here a standard ldap search filter for example: (objectClass=*) means that the ldap entry must have an objectClass attribute. |
|                 | `attributes`   | optional. If omitted all the attributes of the entries will be returned. When specified only the specified attributes will be returned. Regardless the attributes setting a returned entry will always have a "dn" property. |

##### [Load LDAP Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_load_ldap_example)

Retrieve group member information from the ldap server

```cypher
---
call apoc.load.ldap({ldapHost : "ldap.forumsys.com", loginDN : "cn=read-only-admin,dc=example,dc=com", loginPW : "password"},
{searchBase : "dc=example,dc=com",searchScope : "SCOPE_SUB"
,attributes : ["uniqueMember","cn","uid","objectClass"]
,searchFilter: "(&(objectClass=*)(uniqueMember=*))"}) yield entry
return entry.dn,  entry.uniqueMember
---
```

| entry.dn                                                     | entry.uniqueMember                            |
| :----------------------------------------------------------- | :-------------------------------------------- |
|                                                              | "ou=mathematicians,dc=example,dc=com"         |
| `["uid=euclid,dc=example,dc=com", "uid=riemann,dc=example,dc=com", "uid=euler,dc=example,dc=com", "uid=gauss,dc=example,dc=com", "uid=test,dc=example,dc=com"]` |                                               |
| `"ou=scientists,dc=example,dc=com"`                          |                                               |
|                                                              | "ou=italians,ou=scientists,dc=example,dc=com" |
| `"uid=tesla,dc=example,dc=com"`                              |                                               |
| `"ou=chemists,dc=example,dc=com"`                            |                                               |

------

Retrieve group member information from the ldap server and create structure in Neo4j

```cypher
---
call apoc.load.ldap({ldapHost : "ldap.forumsys.com", loginDN : "cn=read-only-admin,dc=example,dc=com", loginPW : "password"},
{searchBase : "dc=example,dc=com",searchScope : "SCOPE_SUB"
,attributes : ["uniqueMember","cn","uid","objectClass"]
,searchFilter: "(&(objectClass=*)(uniqueMember=*))"}) yield entry
merge (g:Group {dn : entry.dn})
on create set g.cn = entry.cn
foreach (member in entry.uniqueMember |
  merge (p:Person { dn : member })
  merge (p)-[:IS_MEMBER]->(g)
)
---
```

##### [Credentials](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_credentials)

To protect credentials, you can configure aliases in `conf/neo4j.conf`:

neo4j.conf Syntax

```
apoc.loadldap.myldap.config=<host>:<port> <loginDN> <loginPW>
```

neo4j.conf:

```
apoc.loadldap.myldap.config=ldap.forumsys.com:389 cn=read-only-admin,dc=example,dc=com password
```

Then

```
call apoc.load.ldap({ldapHost : "ldap.forumsys.com", loginDN : "cn=read-only-admin,dc=example,dc=com", loginPW : "password"}
, {searchBase : "dc=example,dc=com"
  ,searchScope : "SCOPE_SUB"
  ,attributes : ["cn","uid","objectClass"]
  ,searchFilter: "(&(objectClass=*))"
  }) yield entry
return entry.dn,  entry
```

becomes

```
call apoc.load.ldap("myldap"
,{searchBase : "dc=example,dc=com"
 ,searchScope : "SCOPE_SUB"
 ,attributes : ["cn","uid","objectClass"]
 ,searchFilter: "(&(objectClass=*))"
 }) yield entry
return entry.dn,  entry
```

## [Schema Information and Operations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#schema)

### [Meta Graph](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#meta-graph)

![apoc.meta.graph](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.meta.graph.jpg)

Returns a virtual graph that represents the labels and relationship-types available in your database and how they are connected.

| `CALL apoc.meta.graphSample()`                               | examines the database statistics to build the meta graph, very fast, might report extra relationships |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.meta.graph`                                       | examines the database statistics to create the meta-graph, post filters extra relationships by sampling |
| `CALL apoc.meta.subGraph({labels:[labels],rels:[rel-types],excludes:[label,rel-type,…]})` | examines a sample sub graph to create the meta-graph         |
| `CALL apoc.meta.data`                                        | examines a subset of the graph to provide a tabular meta information |
| `CALL apoc.meta.schema`                                      | examines a subset of the graph to provide a map-like meta information |
| `CALL apoc.meta.stats yield labelCount, relTypeCount, propertyKeyCount, nodeCount, relCount, labels, relTypes, stats` | returns the information stored in the transactional database statistics |

| `apoc.meta.cypher.type(value)`                        | type name of a value (`INTEGER,FLOAT,STRING,BOOLEAN,RELATIONSHIP,NODE,PATH,NULL,MAP,LIST OF <TYPE>,POINT,DATE,DATE_TIME,LOCAL_TIME,LOCAL_DATE_TIME,TIME,DURATION`) |
| ----------------------------------------------------- | ------------------------------------------------------------ |
| `apoc.meta.cypher.isType(value,type)`                 | returns a row if type name matches none if not               |
| `apoc.meta.cypher.types(node or relationship or map)` | returns a a map of property-keys to their names              |

In the case of `LIST` you may have many results, depending on the content. In the event that all contents are of the same type, will you have the `LIST OF <TYPE>`, otherwise if the type is different, will you get `LIST OF ANY`

If no type was found, the function return name of the class.

| `apoc.meta.type(value)`                        | type name of a value (`INTEGER,FLOAT,STRING,BOOLEAN,RELATIONSHIP,NODE,PATH,NULL,MAP,LIST`) |
| ---------------------------------------------- | ------------------------------------------------------------ |
| `apoc.meta.isType(value,type)`                 | returns a row if type name matches none if not               |
| `apoc.meta.types(node or relationship or map)` | returns a a map of property-keys to their names              |

If no type was found, the function return name of the class.

<iframe width="560" height="315" src="https://www.youtube.com/embed/yEN6TCL8WGk" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

isType example

```cypher
MATCH (n:Person)
RETURN apoc.meta.isType(n.age,"INTEGER") as ageType
```

## [Utility Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#utilities)

Cypher brings along some basic functions for math, text, collections and maps.

- [Conversion Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#conversion-functions)
- [Map Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#map-functions)
- [Collection Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#collection-list-functions)
- [Text Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#text-functions)
- [Math Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#math-functions)
- [Extract Domain](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#data-extraction-functions)
- [Date and Time Conversions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#datetime-conversions)
- [Temporal Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#temporal-conversions)
- [Number Format Conversions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#number-conversions)
- [Exact Math](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#exact-math-functions)
- [Phonetic Text Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#phonetic-functions)
- [Diff](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-difference)
- [Spatial](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#spatial)
- [Static Value Storage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#static-values)
- [Utilities](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#utility-functions)
- [Bitwise operations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#bitwise-operations)
- [Atomic](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#atomic-updates)
- [Log Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#log)

### [Conversion Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#conversion-functions)

Sometimes type information gets lost, these functions help you to coerce an "Any" value to the concrete type

| `apoc.convert.toString(value)`       | tries it’s best to convert the value to a string             |
| ------------------------------------ | ------------------------------------------------------------ |
| `apoc.convert.toMap(value)`          | tries it’s best to convert the value to a map                |
| `apoc.convert.toList(value)`         | tries it’s best to convert the value to a list               |
| `apoc.convert.toBoolean(value)`      | tries it’s best to convert the value to a boolean            |
| `apoc.convert.toNode(value)`         | tries it’s best to convert the value to a node               |
| `apoc.convert.toRelationship(value)` | tries it’s best to convert the value to a relationship       |
| `apoc.convert.toSet(value)`          | tries it’s best to convert the value to a set                |
| `apoc.convert.toFloat(value)`        | tries it’s best to convert the value to a floating point value |
| `apoc.convert.toInteger(value)`      | tries it’s best to convert the value to a integer value      |

### [Map Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#map-functions)

<iframe width="560" height="315" src="https://www.youtube.com/embed/_Qdhouvx-Qw" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

| `apoc.map.fromNodes(label, property)`                        | creates map from nodes with this label grouped by property   |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.map.fromPairs([[key,value],[key2,value2],…])`          | creates map from list with key-value pairs                   |
| `apoc.map.fromLists([keys],[values])`                        | creates map from a keys and a values list                    |
| `apoc.map.fromValues([key,value,key1,value1])`               | creates map from alternating keys and values in a list       |
| `apoc.map.merge({first},{second}) yield value`               | creates map from merging the two source maps                 |
| `apoc.map.mergeList([{maps}]) yield value`                   | merges all maps in the list into one                         |
| `apoc.map.setKey(map,key,value)`                             | returns the map with the value for this key added or replaced |
| `apoc.map.removeKey(map,key)`                                | returns the map with the key removed                         |
| `apoc.map.removeKeys(map,[keys])`                            | returns the map with the keys removed                        |
| `apoc.map.clean(map,[keys],[values]) yield value`            | removes the keys and values (e.g. null-placeholders) contained in those lists, good for data cleaning from CSV/JSON |
| `apoc.map.groupBy([maps/nodes/relationships],'key') yield value` | creates a map of the list keyed by the given property, with single values |
| `apoc.map.groupByMulti([maps/nodes/relationships],'key') yield value` | creates a map of the list keyed by the given property, with list values |
| `apoc.map.sortedProperties(map, ignoreCase:true)`            | returns a list of key/value list pairs, with pairs sorted by keys alphabetically, with optional case sensitivity |
| `apoc.map.updateTree(tree,key,)`                             | returns map - adds the {data} map on each level of the nested tree, where the key-value pairs match |
| `apoc.map.values(map, [key1,key2,key3,…],[addNullsForMissing]) returns list of values indicated by the keys` | apoc.map.submap(map,keys,,[fail=true])                       |
| `returns submap for keys or throws exception if one of the key doesn’t exist and no default value given at that position` | apoc.map.mget(map,keys,,[fail=true])                         |
| `returns list of values for keys or throws exception if one of the key doesn’t exist and no default value given at that position` | apoc.map.get(map,key,[default],[fail=true])                  |

### [Collection Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#collection-list-functions)

APOC has a wide variety of Collection and List functions.

<iframe width="560" height="315" src="https://www.youtube.com/embed/qgeEbI8gqe4" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

| `apoc.coll.sum([0.5,1,2.3])`                                 | sum of all values in a list                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.coll.avg([0.5,1,2.3])`                                 | avg of all values in a list                                  |
| `apoc.coll.min([0.5,1,2.3])`                                 | minimum of all values in a list                              |
| `apoc.coll.max([0.5,1,2.3])`                                 | maximum of all values in a list                              |
| `apoc.coll.sumLongs([1,3,3])`                                | sums all numeric values in a list                            |
| `apoc.coll.partition(list,batchSize)`                        | partitions a list into sublists of `batchSize`               |
| `apoc.coll.zip([list1],[list2])`                             | all values in a list                                         |
| `apoc.coll.pairs([1,2,3]) YIELD value`                       | [1,2],[2,3],[3,null]                                         |
| `apoc.coll.pairsMin([1,2,3]) YIELD value`                    | [1,2],[2,3]                                                  |
| `apoc.coll.toSet([list])`                                    | returns a unique list backed by a set                        |
| `apoc.coll.sort(coll)`                                       | sort on Collections                                          |
| `apoc.coll.sortNodes([nodes], 'name')`                       | sort nodes by property, ascending sorting by adding ^ in front of the sorting field |
| `apoc.coll.sortMaps([maps], 'key')`                          | sort maps by map key, ascending sorting by adding ^ in front of the sorting field |
| `apoc.coll.reverse(coll)`                                    | returns the reversed list                                    |
| `apoc.coll.contains(coll, value)`                            | returns true if collection contains the value                |
| `apoc.coll.containsAll(coll, values)`                        | optimized contains-all operation (using a HashSet) returns true or false |
| `apoc.coll.containsSorted(coll, value)`                      | optimized contains on a sorted list operation (Collections.binarySearch) (returns true or false) |
| `apoc.coll.containsAllSorted(coll, value)`                   | optimized contains-all on a sorted list operation (Collections.binarySearch) (returns true or false) |
| `apoc.coll.union(first, second)`                             | creates the distinct union of the 2 lists                    |
| `apoc.coll.subtract(first, second)`                          | returns unique set of first list with all elements of second list removed |
| `apoc.coll.removeAll(first, second)`                         | returns first list with all elements of second list removed  |
| `apoc.coll.intersection(first, second)`                      | returns the unique intersection of the two lists             |
| `apoc.coll.disjunction(first, second)`                       | returns the disjunct set of the two lists                    |
| `apoc.coll.unionAll(first, second)`                          | creates the full union with duplicates of the two lists      |
| `apoc.coll.split(list,value)`                                | splits collection on given values rows of lists, value itself will not be part of resulting lists |
| `apoc.coll.indexOf(coll, value)`                             | position of value in the list                                |
| `apoc.coll.shuffle(coll)`                                    | returns the shuffled list                                    |
| `apoc.coll.randomItem(coll)`                                 | returns a random item from the list                          |
| `apoc.coll.randomItems(coll, itemCount, allowRepick: false)` | returns a list of `itemCount` random items from the list, optionally allowing picked elements to be picked again |
| `apoc.coll.containsDuplicates(coll)`                         | returns true if a collection contains duplicate elements     |
| `apoc.coll.duplicates(coll)`                                 | returns a list of duplicate items in the collection          |
| `apoc.coll.duplicatesWithCount(coll)`                        | returns a list of duplicate items in the collection and their count, keyed by `item` and `count` (e.g., `[{item: xyz, count:2}, {item:zyx, count:5}]`) |
| `apoc.coll.occurrences(coll, item)`                          | returns the count of the given item in the collection        |
| `apoc.coll.frequencies(coll)`                                | returns a list of frequencies of the items in the collection, keyed by `item` and `count` (e.g., `[{item: xyz, count:2}, {item:zyx, count:5}, {item:abc, count:1}]`) |
| `apoc.coll.frequenciesAsMap(coll)`                           | return a map of frequencies of the items in the collection, keyed by `item` and `count` (e.g., `{1: 2, 3: 2}`) |
| `apoc.coll.sortMulti`                                        | sort list of maps by several sort fields (ascending with ^ prefix) and optionally applies limit and skip |
| `apoc.coll.flatten`                                          | flattens a nested list                                       |
| `apoc.coll.combinations(coll, minSelect, maxSelect:minSelect)` | Returns collection of all combinations of list elements of selection size between minSelect and maxSelect (default:minSelect), inclusive |
| `CALL apoc.coll.elements(list,limit,offset) yield _1,_2,..,_10,_1s,_2i,_3f,_4m,_5l,_6n,_7r,_8p` | deconstruct subset of mixed list into identifiers of the correct type |
| `apoc.coll.set(coll, index, value)`                          | set index to value                                           |
| `apoc.coll.insert(coll, index, value)`                       | insert value at index                                        |
| `apoc.coll.insertAll(coll, index, values)`                   | insert values at index                                       |
| `apoc.coll.remove(coll, index, [length=1])`                  | remove range of values from index to length                  |
| `apoc.coll.different(values)`                                | returns true if value are different                          |

### [Text Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#text-functions)

Cypher has some basic functions to work with text like:

- `split(string, delim)`
- `toLower` and `toUpper`
- concatenation with `+`
- and predicates like `CONTAINS, STARTS WITH, ENDS WITH` and regular expression matches via `=~`

A lot of useful functions for string manipulation, comparison, filtering are missing though. APOC tries to add many of them.

#### [Overview Text Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_overview_text_functions)

| `apoc.text.indexOf(text, lookup, offset=0, to=-1==len)`      | find the first occurence of the lookup string in the text, from inclusive, to exclusive,, -1 if not found, null if text is null. |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.text.indexesOf(text, lookup, from=0, to=-1==len)`      | finds all occurences of the lookup string in the text, return list, from inclusive, to exclusive, empty list if not found, null if text is null. |
| `apoc.text.replace(text, regex, replacement)`                | replace each substring of the given string that matches the given regular expression with the given replacement. |
| `apoc.text.regexGroups(text, regex)`                         | returns an array containing a nested array for each match. The inner array contains all match groups. |
| `apoc.text.join(['text1','text2',…], delimiter)`             | join the given strings with the given delimiter.             |
| `apoc.text.format(text,[params],language)`                   | sprintf format the string with the params given, and optional param language (default value is 'en'). |
| `apoc.text.lpad(text,count,delim)`                           | left pad the string to the given width                       |
| `apoc.text.rpad(text,count,delim)`                           | right pad the string to the given width                      |
| `apoc.text.random(length, [valid])`                          | returns a random string to the specified length              |
| `apoc.text.capitalize(text)`                                 | capitalise the first letter of the word                      |
| `apoc.text.capitalizeAll(text)`                              | capitalise the first letter of every word in the text        |
| `apoc.text.decapitalize(text)`                               | decapitalize the first letter of the word                    |
| `apoc.text.decapitalizeAll(text)`                            | decapitalize the first letter of all words                   |
| `apoc.text.swapCase(text)`                                   | Swap the case of a string                                    |
| `apoc.text.camelCase(text)`                                  | Convert a string to camelCase                                |
| `apoc.text.upperCamelCase(text)`                             | Convert a string to UpperCamelCase                           |
| `apoc.text.snakeCase(text)`                                  | Convert a string to snake-case                               |
| `apoc.text.toUpperCase(text)`                                | Convert a string to UPPER_CASE                               |
| `apoc.text.charAt(text, index)`                              | Returns the decimal value of the character at the given index |
| `apoc.text.code(codepoint)`                                  | Returns the unicode character of the given codepoint         |
| `apoc.text.hexCharAt(text, index)`                           | Returns the hex value string of the character at the given index |
| `apoc.text.hexValue(value)`                                  | Returns the hex value string of the given value              |
| `apoc.text.byteCount(text,[charset])`                        | return size of text in bytes                                 |
| `apoc.text.bytes(text,[charset]) - return bytes of the text` | apoc.text.toCypher(value, {skipKeys,keepKeys,skipValues,keepValues,skipNull,node,relationship,start,end}) |
| `tries it’s best to convert the value to a cypher-property-string` | apoc.text.base64Encode(text) - Encode a string with Base64   |
| `apoc.text.base64Decode(text) - Decode Base64 encoded string` | apoc.text.base64UrlEncode(url) - Encode a url with Base64    |

The `replace`, `split` and `regexGroups` functions work with regular expressions.

#### [Data Extraction](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_data_extraction)

| `apoc.data.url('url') as {protocol,user,host,port,path,query,file,anchor}` | turn URL into map structure                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.data.email('email_address') as {personal,user,domain}` | extract the personal name, user and domain as a map (needs javax.mail jar) |
| `apoc.data.domain(email_or_url)`                             | **deprecated** returns domain part of the value              |

#### [Text Similarity Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_text_similarity_functions)

| `apoc.text.distance(text1, text2)`                           | compare the given strings with the Levenshtein distance algorithm |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.text.levenshteinDistance(text1, text2)`                | compare the given strings with the Levenshtein distance algorithm |
| `apoc.text.levenshteinSimilarity(text1, text2)`              | calculate the similarity (a value within 0 and 1) between two texts based on Levenshtein distance. |
| `apoc.text.hammingDistance(text1, text2)`                    | compare the given strings with the Hamming distance algorithm |
| `apoc.text.jaroWinklerDistance(text1, text2)`                | compare the given strings with the Jaro-Winkler distance algorithm |
| `apoc.text.sorensenDiceSimilarity(text1, text2)`             | compare the given strings with the Sørensen–Dice coefficient formula, assuming an English locale |
| `apoc.text.sorensenDiceSimilarityWithLanguage(text1, text2, languageTag)` | compare the given strings with the Sørensen–Dice coefficient formula, with the provided IETF language tag |
| `apoc.text.fuzzyMatch(text1, text2)`                         | check if 2 words can be matched in a fuzzy way. Depending on the length of the String it will allow more characters that needs to be edited to match the second String. |

#### [Phonetic Comparison Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_phonetic_comparison_functions)

| `apoc.text.phonetic(value)`              | Compute the US_ENGLISH phonetic soundex encoding of all words of the text value which can be a single string or a list of strings |
| ---------------------------------------- | ------------------------------------------------------------ |
| `apoc.text.doubleMetaphone(value)`       | Compute the Double Metaphone phonetic encoding of all words of the text value which can be a single string or a list of strings |
| `apoc.text.clean(text)`                  | strip the given string of everything except alpha numeric characters and convert it to lower case. |
| `apoc.text.compareCleaned(text1, text2)` | compare the given strings stripped of everything except alpha numeric characters converted to lower case. |

| `apoc.text.phoneticDelta(text1, text2) yield phonetic1, phonetic2, delta` | Compute the US_ENGLISH soundex character difference between two given strings |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

#### [Formatting Text](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_formatting_text)

Format the string with the params given, and optional param language.

without language param ('en' default)

```cypher
RETURN apoc.text.format('ab%s %d %.1f %s%n',['cd',42,3.14,true]) AS value // abcd 42 3.1 true
```

with language param

```cypher
RETURN apoc.text.format('ab%s %d %.1f %s%n',['cd',42,3.14,true],'it') AS value // abcd 42 3,1 true
```

#### [String Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_string_search)

The `indexOf` function, provides the fist occurrence of the given `lookup` string within the `text`, or -1 if not found. It can optionally take `from` (inclusive) and `to` (exclusive) parameters.

```cypher
RETURN apoc.text.indexOf('Hello World!', 'World') // 6
```

The `indexesOf` function, provides all occurrences of the given lookup string within the text, or empty list if not found. It can optionally take `from` (inclusive) and `to` (exclusive) parameters.

```cypher
RETURN apoc.text.indexesOf('Hello World!', 'o',2,9) // [4,7]
```

If you want to get a substring starting from your index match, you can use this

returns `World!`

```cypher
WITH 'Hello World!' as text, length(text) as len
WITH text, len, apoc.text.indexOf(text, 'World',3) as index
RETURN substring(text, case index when -1 then len-1 else index end, len);
```

#### [Regular Expressions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_regular_expressions)

will return 'HelloWorld'

```cypher
RETURN apoc.text.replace('Hello World!', '[^a-zA-Z]', '')
RETURN apoc.text.regexGroups('abc <link xxx1>yyy1</link> def <link xxx2>yyy2</link>','<link (\\w+)>(\\w+)</link>') AS result

// [["<link xxx1>yyy1</link>", "xxx1", "yyy1"], ["<link xxx2>yyy2</link>", "xxx2", "yyy2"]]
```

#### [Split and Join](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_split_and_join)

will split with the given regular expression return ['Hello', 'World']

```cypher
RETURN apoc.text.split('Hello   World', ' +')
```

will return 'Hello World'

```cypher
RETURN apoc.text.join(['Hello', 'World'], ' ')
```

#### [Data Cleaning](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_data_cleaning)

will return 'helloworld'

```cypher
RETURN apoc.text.clean('Hello World!')
```

will return `true`

```cypher
RETURN apoc.text.compareCleaned('Hello World!', '_hello-world_')
```

will return only 'Hello World!'

```cypher
UNWIND ['Hello World!', 'hello worlds'] as text
RETURN apoc.text.filterCleanMatches(text, 'hello_world') as text
```

The clean functionality can be useful for cleaning up slightly dirty text data with inconsistent formatting for non-exact comparisons.

Cleaning will strip the string of all non-alphanumeric characters (including spaces) and convert it to lower case.

#### [Case Change Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_case_change_functions)

##### [Capitalise the first letter of the word with `capitalize`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_capitalise_the_first_letter_of_the_word_with_code_capitalize_code)

```cypher
RETURN apoc.text.capitalize("neo4j") // "Neo4j"
```

##### [Capitalise the first letter of every word in the text with `capitalizeAll`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_capitalise_the_first_letter_of_every_word_in_the_text_with_code_capitalizeall_code)

```cypher
RETURN apoc.text.capitalizeAll("graph database") // "Graph Database"
```

##### [Decapitalize the first letter of the string with `decapitalize`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_decapitalize_the_first_letter_of_the_string_with_code_decapitalize_code)

```cypher
RETURN apoc.text.decapitalize("Graph Database") // "graph Database"
```

##### [Decapitalize the first letter of all words with `decapitalizeAll`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_decapitalize_the_first_letter_of_all_words_with_code_decapitalizeall_code)

```cypher
RETURN apoc.text.decapitalizeAll("Graph Databases") // "graph databases"
```

##### [Swap the case of a string with `swapCase`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_swap_the_case_of_a_string_with_code_swapcase_code)

```cypher
RETURN apoc.text.swapCase("Neo4j") // nEO4J
```

##### [Convert a string to lower camelCase with `camelCase`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_convert_a_string_to_lower_camelcase_with_code_camelcase_code)

```cypher
RETURN apoc.text.camelCase("FOO_BAR");    // "fooBar"
RETURN apoc.text.camelCase("Foo bar");    // "fooBar"
RETURN apoc.text.camelCase("Foo22 bar");  // "foo22Bar"
RETURN apoc.text.camelCase("foo-bar");    // "fooBar"
RETURN apoc.text.camelCase("Foobar");     // "foobar"
RETURN apoc.text.camelCase("Foo$$Bar");   // "fooBar"
```

##### [Convert a string to UpperCamelCase with `upperCamelCase`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_convert_a_string_to_uppercamelcase_with_code_uppercamelcase_code)

```cypher
RETURN apoc.text.upperCamelCase("FOO_BAR");   // "FooBar"
RETURN apoc.text.upperCamelCase("Foo bar");   // "FooBar"
RETURN apoc.text.upperCamelCase("Foo22 bar"); // "Foo22Bar"
RETURN apoc.text.upperCamelCase("foo-bar");   // "FooBar"
RETURN apoc.text.upperCamelCase("Foobar");    // "Foobar"
RETURN apoc.text.upperCamelCase("Foo$$Bar");  // "FooBar"
```

##### [Convert a string to snake-case with `snakeCase`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_convert_a_string_to_snake_case_with_code_snakecase_code)

```cypher
RETURN apoc.text.snakeCase("test Snake Case"); // "test-snake-case"
RETURN apoc.text.snakeCase("FOO_BAR");         // "foo-bar"
RETURN apoc.text.snakeCase("Foo bar");         // "foo-bar"
RETURN apoc.text.snakeCase("fooBar");          // "foo-bar"
RETURN apoc.text.snakeCase("foo-bar");         // "foo-bar"
RETURN apoc.text.snakeCase("Foo bar");         // "foo-bar"
RETURN apoc.text.snakeCase("Foo  bar");        // "foo-bar"
```

##### [Convert a string to UPPER_CASE with `toUpperCase](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_convert_a_string_to_upper_case_with_touppercase)

```cypher
RETURN apoc.text.toUpperCase("test upper case"); // "TEST_UPPER_CASE"
RETURN apoc.text.toUpperCase("FooBar");          // "FOO_BAR"
RETURN apoc.text.toUpperCase("fooBar");          // "FOO_BAR"
RETURN apoc.text.toUpperCase("foo-bar");         // "FOO_BAR"
RETURN apoc.text.toUpperCase("foo--bar");        // "FOO_BAR"
RETURN apoc.text.toUpperCase("foo$$bar");        // "FOO_BAR"
RETURN apoc.text.toUpperCase("foo 22 bar");      // "FOO_22_BAR"
```

#### [Base64 De- and Encoding](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_base64_de_and_encoding)

Encode or decode a string in base64 or base64Url

EncodeBase64

```cypher
RETURN apoc.text.base64Encode("neo4j") // bmVvNGo=
```

DecodeBase64

```cypher
RETURN apoc.text.base64Decode("bmVvNGo=") // neo4j
```

EncodeBase64Url

```cypher
RETURN apoc.text.base64EncodeUrl("http://neo4j.com/?test=test") // aHR0cDovL25lbzRqLmNvbS8_dGVzdD10ZXN0
```

DecodeBase64Url

```cypher
RETURN apoc.text.base64DecodeUrl("aHR0cDovL25lbzRqLmNvbS8_dGVzdD10ZXN0") // http://neo4j.com/?test=test
```

#### [Random String](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_random_string)

You can generate a random string to a specified length by calling `apoc.text.random` with a length parameter and optional string of valid characters.

The `valid` parameter will accept the following regex patterns, alternatively you can provide a string of letters and/or characters.

| `Pattern` | Description           |
| --------- | --------------------- |
| `A-Z`     | A-Z in uppercase      |
| `a-z`     | A-Z in lowercase      |
| `0-9`     | Numbers 0-9 inclusive |

The following call will return a random string including uppercase letters, numbers and `.` and `$` characters.

```cypher
RETURN apoc.text.random(10, "A-Z0-9.$")
```

#### [Text Similarity Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_text_similarity_functions_2)

##### [Compare the strings with the Levenshtein distance](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_compare_the_strings_with_the_levenshtein_distance)

Compare the given strings with the `StringUtils.distance(text1, text2)` method (Levenshtein).

```cypher
RETURN apoc.text.distance("Levenshtein", "Levenstein") // 1
```

##### [Compare the given strings with the Sørensen–Dice coefficient formula.](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_compare_the_given_strings_with_the_sørensen_dice_coefficient_formula)

computes the similarity assuming Locale.ENGLISH

```cypher
RETURN apoc.text.sorensenDiceSimilarity("belly", "jolly") // 0.5
```

computes the similarity with an explicit locale

```cypher
RETURN apoc.text.sorensenDiceSimilarityWithLanguage("halım", "halim", "tr-TR") // 0.5
```

##### [Check if 2 words can be matched in a fuzzy way with `fuzzyMatch`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_check_if_2_words_can_be_matched_in_a_fuzzy_way_with_code_fuzzymatch_code)

Depending on the length of the String it will allow more characters that needs to be edited to match the second String.

```cypher
RETURN apoc.text.fuzzyMatch("The", "the") // true
```

### [Math Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#math-functions)

| `apoc.math.round(value,[precision=0],mode=[HALF_UP,CEILING,FLOOR,UP,DOWN,HALF_EVEN,HALF_DOWN,DOWN,UNNECESSARY])` | rounds value with optionally given precision (default 0) and optional rounding mode (default HALF_UP) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.math.maxLong()`                                        | return the maximum value a long can have                     |
| `apoc.math.minLong()`                                        | return the minimum value a long can have                     |
| `apoc.math.maxDouble()`                                      | return the largest positive finite value of type double      |
| `apoc.math.minDouble()`                                      | return the smallest positive nonzero value of type double    |
| `apoc.math.maxInt()`                                         | return the maximum value a int can have                      |
| `apoc.math.minInt()`                                         | return the minimum value a int can have                      |
| `apoc.math.maxByte()`                                        | return the maximum value a byte can have                     |
| `apoc.math.minByte()`                                        | return the minimum value a byte can have                     |
| `apoc.number.romanToArabic(romanNumber)`                     | convert roman numbers to arabic                              |
| `apoc.number.arabicToRoman(number)`                          | convert arabic numbers to roman                              |

### [Spatial](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#spatial)

| `CALL apoc.spatial.geocode('address') YIELD location, latitude, longitude, description, osmData` | look up geographic location of location from a geocoding service (the default one is OpenStreetMap) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.spatial.reverseGeocode(latitude,longitude) YIELD location, latitude, longitude, description` | look up address from latitude and longitude from a geocoding service (the default one is OpenStreetMap) |
| `CALL apoc.spatial.sortPathsByDistance(Collection<Path>) YIELD path, distance` | sort a given collection of paths by geographic distance based on lat/long properties on the path nodes |

#### [Spatial Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_spatial_functions)

The spatial procedures are intended to enable geographic capabilities on your data.

##### [Geocode](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_geocode)

The first procedure *geocode* which will convert a textual address into a location containing *latitude*, *longitude* and *description*. Despite being only a single function, together with the built-in functions *point* and *distance* we can achieve quite powerful results.

First, how can we use the procedure:

```cypher
CALL apoc.spatial.geocodeOnce('21 rue Paul Bellamy 44000 NANTES FRANCE') YIELD location
RETURN location.latitude, location.longitude // will return 47.2221667, -1.5566624
```

There are three forms of the procedure:

- geocodeOnce(address) returns zero or one result.
- geocode(address,maxResults) returns zero, one or more up to maxResults.
- reverseGeocode(latitude,longitude) returns zero or one result.

This is because the backing geocoding service (OSM, Google, OpenCage or other) might return multiple results for the same query. GeocodeOnce() is designed to return the first, or highest ranking result.

The third procedure *reverseGeocode* will convert a location containing *latitude* and *longitude* into a textual address.

```
CALL apoc.spatial.reverseGeocode(47.2221667,-1.5566625) YIELD location
RETURN location.description; // will return 21, Rue Paul Bellamy, Talensac - Pont Morand,
//Hauts-Pavés - Saint-Félix, Nantes, Loire-Atlantique, Pays de la Loire,
//France métropolitaine, 44000, France
```

##### [Configuring Geocode](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_configuring_geocode)

There are a few options that can be set in the neo4j.conf file to control the service:

- apoc.spatial.geocode.provider=osm (osm, google, opencage, etc.)
- apoc.spatial.geocode.osm.throttle=5000 (ms to delay between queries to not overload OSM servers)
- apoc.spatial.geocode.google.throttle=1 (ms to delay between queries to not overload Google servers)
- apoc.spatial.geocode.google.key=xxxx (API key for google geocode access)
- apoc.spatial.geocode.google.client=xxxx (client code for google geocode access)
- apoc.spatial.geocode.google.signature=xxxx (client signature for google geocode access)

For google, you should use either a key or a combination of client and signature. Read more about this on the google page for geocode access at https://developers.google.com/maps/documentation/geocoding/get-api-key#key

##### [Configuring Custom Geocode Provider](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_configuring_custom_geocode_provider)

**Geocode**

For any provider that is not 'osm' or 'google' you get a configurable supplier that requires two additional settings, 'url' and 'key'. The 'url' must contain the two words 'PLACE' and 'KEY'. The 'KEY' will be replaced with the key you get from the provider when you register for the service. The 'PLACE' will be replaced with the address to geocode when the procedure is called.

**Reverse Geocode**

The 'url' must contain the three words 'LAT', 'LNG' and 'KEY'. The 'LAT' will be replaced with the latitude and 'LNG' will be replaced with the the longitude to reverse geocode when the procedure is called.

For example, to get the service working with OpenCage, perform the following steps:

- Register your own application key at https://geocoder.opencagedata.com/
- Once you have a key, add the following three lines to neo4j.conf

```
apoc.spatial.geocode.provider=opencage
apoc.spatial.geocode.opencage.key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
apoc.spatial.geocode.opencage.url=http://api.opencagedata.com/geocode/v1/json?q=PLACE&key=KEY
apoc.spatial.geocode.opencage.reverse.url=http://api.opencagedata.com/geocode/v1/json?q=LAT+LNG&key=KEY
```

- make sure that the 'XXXXXXX' part above is replaced with your actual key
- Restart the Neo4j server and then test the geocode procedures to see that they work
- If you are unsure if the provider is correctly configured try verify with:

```cypher
CALL apoc.spatial.showConfig()
```

##### [Using Geocode within a bigger Cypher query](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_geocode_within_a_bigger_cypher_query)

A more complex, or useful, example which geocodes addresses found in properties of nodes:

```cypher
MATCH (a:Place)
WHERE exists(a.address)
CALL apoc.spatial.geocodeOnce(a.address) YIELD location
RETURN location.latitude AS latitude, location.longitude AS longitude, location.description AS description
```

##### [Calculating distance between locations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_calculating_distance_between_locations)

If we wish to calculate the distance between addresses, we need to use the point() function to convert latitude and longitude to Cyper Point types, and then use the distance() function to calculate the distance:

```cypher
WITH point({latitude: 48.8582532, longitude: 2.294287}) AS eiffel
MATCH (a:Place)
WHERE exists(a.address)
CALL apoc.spatial.geocodeOnce(a.address) YIELD location
WITH location, distance(point(location), eiffel) AS distance
WHERE distance < 5000
RETURN location.description AS description, distance
ORDER BY distance
LIMIT 100
```

###### [sortPathsByDistance](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_sortpathsbydistance)

The second procedure enables you to sort a given collection of paths by the sum of their distance based on lat/long properties on the nodes.

Sample data :

```cypher
CREATE (bruges:City {name:"bruges", latitude: 51.2605829, longitude: 3.0817189})
CREATE (brussels:City {name:"brussels", latitude: 50.854954, longitude: 4.3051786})
CREATE (paris:City {name:"paris", latitude: 48.8588376, longitude: 2.2773455})
CREATE (dresden:City {name:"dresden", latitude: 51.0767496, longitude: 13.6321595})
MERGE (bruges)-[:NEXT]->(brussels)
MERGE (brussels)-[:NEXT]->(dresden)
MERGE (brussels)-[:NEXT]->(paris)
MERGE (bruges)-[:NEXT]->(paris)
MERGE (paris)-[:NEXT]->(dresden)
```

Finding paths and sort them by distance

```cypher
MATCH (a:City {name:'bruges'}), (b:City {name:'dresden'})
MATCH p=(a)-[*]->(b)
WITH collect(p) as paths
CALL apoc.spatial.sortPathsByDistance(paths) YIELD path, distance
RETURN path, distance
```

##### [Graph Refactoring](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_graph_refactoring)

In order not to have to repeatedly geocode the same thing in multiple queries, especially if the database will be used by many people, it might be a good idea to persist the results in the database so that subsequent calls can use the saved results.

Geocode and persist the result

```cypher
MATCH (a:Place)
WHERE exists(a.address) AND NOT exists(a.latitude)
WITH a LIMIT 1000
CALL apoc.spatial.geocodeOnce(a.address) YIELD location
SET a.latitude = location.latitude
SET a.longitude = location.longitude
```

Note that the above command only geocodes the first 1000 ‘Place’ nodes that have not already been geocoded. This query can be run multiple times until all places are geocoded. Why would we want to do this? Two good reasons:

- The geocoding service is a public service that can throttle or blacklist sites that hit the service too heavily, so controlling how much we do is useful.
- The transaction is updating the database, and it is wise not to update the database with too many things in the same transaction, to avoid using up too much memory. This trick will keep the memory usage very low.

Now make use of the results in distance queries

```cypher
WITH point({latitude: 48.8582532, longitude: 2.294287}) AS eiffel
MATCH (a:Place)
WHERE exists(a.latitude) AND exists(a.longitude)
WITH a, distance(point(a), eiffel) AS distance
WHERE distance < 5000
RETURN a.name, distance
ORDER BY distance
LIMIT 100
```

##### [Combined Space and Time search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_combined_space_and_time_search)

Combining spatial and date-time functions can allow for more complex queries:

```cypher
WITH point({latitude: 48.8582532, longitude: 2.294287}) AS eiffel
MATCH (e:Event)
WHERE exists(e.address) AND exists(e.datetime)
CALL apoc.spatial.geocodeOnce(e.address) YIELD location
WITH e, location,
distance(point(location), eiffel) AS distance,
            (apoc.date.parse('2016-06-01 00:00:00','h') - apoc.date.parse(e.datetime,'h'))/24.0 AS days_before_due
WHERE distance < 5000 AND days_before_due < 14 AND apoc.date.parse(e.datetime,'h') < apoc.date.parse('2016-06-01 00:00:00','h')
RETURN e.name AS event, e.datetime AS date,
location.description AS description, distance
ORDER BY distance
```

### [Static Value Storage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#static-values)

| `apoc.static.get(name)`        | returns statically stored value from config (apoc.static.<key>) or server lifetime storage |
| ------------------------------ | ------------------------------------------------------------ |
| `apoc.static.getAll(prefix)`   | returns statically stored values from config (apoc.static.<prefix>) or server lifetime storage |
| `apoc.static.set(name, value)` | stores value under key for server livetime storage, returns previously stored or configured value |

|      | `apoc.static.get` and `apoc.static.getAll` have been migrated to be functions, the procedures have been deprecated. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Utilities](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#utility-functions)

| `apoc.util.sha1([values])`                        | computes the sha1 of the concatenation of all string values of the list |
| ------------------------------------------------- | ------------------------------------------------------------ |
| `apoc.util.md5([values])`                         | computes the md5 of the concatenation of all string values of the list |
| `apoc.util.sleep({duration})`                     | sleeps for <duration> millis, transaction termination is honored |
| `apoc.util.validate(predicate, message,[params])` | raises exception if prediate evaluates to true               |

### [Phonetic Text Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#phonetic-functions)

The phonetic text (soundex) functions allow you to compute the soundex encoding of a given string. There is also a procedure to compare how similar two strings sound under the soundex algorithm. All soundex procedures by default assume the used language is US English.

```cypher
// will return 'H436'
RETURN apoc.text.phonetic('Hello, dear User!')
// will return '4'  (very similar)
RETURn apoc.text.phoneticDelta('Hello Mr Rabbit', 'Hello Mr Ribbit')
```

### [Extract Domain](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#data-extraction-functions)

The User Function `apoc.data.domain` will take a url or email address and try to determine the domain name. This can be useful to make easier correlations and equality tests between differently formatted email addresses, and between urls to the same domains but specifying different locations.

```cypher
WITH 'foo@bar.com' AS email
RETURN apoc.data.domain(email) // will return 'bar.com'
WITH 'http://www.example.com/all-the-things' AS url
RETURN apoc.data.domain(url) // will return 'www.example.com'
```

### [Date and Time Conversions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#datetime-conversions)

#### [Conversion between formatted dates and timestamps](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_conversion_between_formatted_dates_and_timestamps)

| `apoc.date.parse('2015/03/25 03:15:59',['ms'/'s'], ['yyyy/MM/dd HH:mm:ss'])` | same as previous, but accepts custom datetime format         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.date.format(12345, ['ms'/'s'], ['yyyy/MM/dd HH:mm:ss'])` | the same as previous, but accepts custom datetime format     |
| `apoc.date.systemTimezone()`                                 | return the system timezone display format string             |
| `apoc.date.currentTimestamp()`                               | provides current time millis with changing values over a transaction |

- possible unit values: `ms,s,m,h,d` and their long forms `millis,milliseconds,seconds,minutes,hours,days`.
- possible time zone values: Either an abbreviation such as `PST`, a full name such as `America/Los_Angeles`, or a custom ID such as `GMT-8:00`. Full names are recommended. You can view a list of full names in [this Wikipedia page](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

#### [Current timestamp](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_current_timestamp)

`apoc.date.currentTimestamp()` provides the System.currentTimeMillis which is current throughout transaction execution compared to Cypher’s timestamp() function which does not update within a transaction

#### [Conversion of timestamps between different time units](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_conversion_of_timestamps_between_different_time_units)

- `apoc.date.convert(12345, 'ms', 'd')` convert a timestamp in one time unit into one of a different time unit
- possible unit values: `ms,s,m,h,d` and their long forms.

#### [Adding/subtracting time unit values to timestamps](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_adding_subtracting_time_unit_values_to_timestamps)

- `apoc.date.add(12345, 'ms', -365, 'd')` given a timestamp in one time unit, adds a value of the specified time unit
- possible unit values: `ms,s,m,h,d` and their long forms.

#### [Reading separate datetime fields:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_reading_separate_datetime_fields)

Splits date (optionally, using given custom format) into fields returning a map from field name to its value.

```cypher
RETURN apoc.date.fields('2015-03-25 03:15:59')
```

##### [Reading single datetime field from UTC epoch](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_reading_single_datetime_field_from_utc_epoch)

Extracts the value of one field from a datetime epoch.

- `apoc.date.field(12345)`

Following fields are supported:

| Result field | Represents                                                   |
| :----------- | :----------------------------------------------------------- |
| 'years'      | year                                                         |
| 'months'     | month of year                                                |
| 'days'       | day of month                                                 |
| 'hours'      | hour of day                                                  |
| 'minutes'    | minute of hour                                               |
| 'seconds'    | second of minute                                             |
| 'zone'       | [time zone](https://dohcs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html#timezone) |

#### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_4)

```cypher
RETURN apoc.date.fields('2015-01-02 03:04:05 EET', 'yyyy-MM-dd HH:mm:ss zzz')
  {
    'weekdays': 5,
    'years': 2015,
    'seconds': 5,
    'zoneid': 'EET',
    'minutes': 4,
    'hours': 3,
    'months': 1,
    'days': 2
  }
RETURN apoc.date.fields('2015/01/02_EET', 'yyyy/MM/dd_z')
  {
    'weekdays': 5,
    'years': 2015,
    'zoneid': 'EET',
    'months': 1,
    'days': 2
  }
```

#### [Notes on formats:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_notes_on_formats)

- the default format is `yyyy-MM-dd HH:mm:ss`
- if the format pattern doesn’t specify timezone, formatter considers dates to belong to the UTC timezone
- if the timezone pattern is specified, the timezone is extracted from the date string, otherwise an error will be reported
- the `to/fromSeconds` timestamp values are in POSIX (Unix time) system, i.e. timestamps represent the number of seconds elapsed since [00:00:00 UTC, Thursday, 1 January 1970](https://en.wikipedia.org/wiki/Unix_time)
- the full list of supported formats is described in [SimpleDateFormat JavaDoc](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)

#### [Reading single datetime field from UTC Epoch:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_reading_single_datetime_field_from_utc_epoch_2)

Extracts the value of one field from a datetime epoch.

```cypher
RETURN apoc.date.field(12345)
```

Following fields are supported:

| Result field | Represents               |
| :----------- | :----------------------- |
| 'years'      | year                     |
| 'months'     | month of year            |
| 'days'       | day of month             |
| 'hours'      | hour of day              |
| 'minutes'    | minute of hour           |
| 'seconds'    | second of minute         |
| 'millis'     | milliseconds of a second |

#### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_5)

```cypher
RETURN apoc.date.field(12345, 'days')
    2
```

### [Temporal Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#temporal-conversions)

These functions can be used to format temporal values using a valid `DateTimeFormatter` pattern.

#### [Formatting Temporal Types](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_formatting_temporal_types)

You can pass through any temporal type (Date, Time, DateTime, LocalTime, LocalDateTime, Duration) along with a pattern. Please note that if the pattern is invalid for the value that you pass in (for example `HH` for hours on a Date value or `DD` for day on a Time value), an Exception will be thrown.

```cypher
apoc.temporal.format( date(), 'YYYY-MM-dd')
apoc.temporal.format( datetime(), 'YYYY-MM-dd HH:mm:ss.SSSSZ')
apoc.temporal.format( localtime(), 'HH:mm:ss.SSSS')
apoc.temporal.format( localtime(), 'HH:mm:ss.SSSS')
```

[View full pattern listing](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html)

You can also pass a ISO DATE TIME pattern, the list is available here [ISO_DATE](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/mapping-date-format.html#built-in-date-formats)

For example:

```cypher
apoc.temporal.format( date( { year: 2018, month: 12, day: 10 } ), 'date' ) as output
apoc.temporal.format( localdatetime( { year: 2018, month: 12, day: 10, hour: 12, minute: 34, second: 56, nanosecond: 123456789 } ), 'ISO_LOCAL_DATE_TIME' ) as output
apoc.temporal.format( date( { year: 2018, month: 12, day: 10 } ), 'ISO_DATE' ) as output
```

#### [Formatting Durations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_formatting_durations)

When attempting to format a duration, the procedure will attempt to create a date (01/01/0000) and add the duration. This allows you to provide a consistent format as above.

```cypher
apoc.temporal.format( duration.between( datetime.transaction(), datetime.realtime() ) , 'HH:mm:ss.SSSS')
```

### [Number Format Conversions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#number-conversions)

#### [Conversion between formatted decimals](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_conversion_between_formatted_decimals)

- `apoc.number.format(number)` format a long or double using the default system pattern and language to produce a string
- `apoc.number.format(number, pattern)` format a long or double using a pattern and the default system language to produce a string
- `apoc.number.format(number, lang)` format a long or double using the default system pattern pattern and a language to produce a string
- `apoc.number.format(number, pattern, lang)` format a long or double using a pattern and a language to produce a string
- `apoc.number.parseInt(text)` parse a text using the default system pattern and language to produce a long
- `apoc.number.parseInt(text, pattern)` parse a text using a pattern and the default system language to produce a long
- `apoc.number.parseInt(text, '', lang)` parse a text using the default system pattern and a language to produce a long
- `apoc.number.parseInt(text, pattern, lang)` parse a text using a pattern and a language to produce a long
- `apoc.number.parseFloat(text)` parse a text using the default system pattern and language to produce a double
- `apoc.number.parseFloat(text, pattern)` parse a text using a pattern and the default system language to produce a double
- `apoc.number.parseFloat(text,'',lang)` parse a text using the default system pattern and a language to produce a double
- `apoc.number.parseFloat(text, pattern, lang)` parse a text using a pattern and a language to produce a double
- The full list of supported values for `pattern` and `lang` params is described in [DecimalFormat JavaDoc](https://docs.oracle.com/javase/9/docs/api/java/text/DecimalFormat.html)

#### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_6)

```
  return apoc.number.format(12345.67) as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │12,345.67│
  └─────────┘
  return apoc.number.format(12345, '#,##0.00;(#,##0.00)', 'it') as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │12.345,00│
  └─────────
  return apoc.number.format(12345.67, '#,##0.00;(#,##0.00)', 'it') as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │12.345,67│
  └─────────┘
  return apoc.number.parseInt('12.345', '#,##0.00;(#,##0.00)', 'it') as value

  ╒═════╕
  │value│
  ╞═════╡
  │12345│
  └─────┘
  return apoc.number.parseFloat('12.345,67', '#,##0.00;(#,##0.00)', 'it') as value

  ╒════════╕
  │value   │
  ╞════════╡
  │12345.67│
  └────────┘
  return apoc.number.format('aaa') as value

  null beacuse 'aaa' isn't a number
  RETURN apoc.number.parseInt('aaa')

  Return null because 'aaa' is unparsable.
```

### [Exact Math](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#exact-math-functions)

#### [Handle BigInteger And BigDecimal](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_handle_biginteger_and_bigdecimal)

| Statement                                                    | Description                                             | Return type |
| :----------------------------------------------------------- | :------------------------------------------------------ | :---------- |
| RETURN apoc.number.exact.add(stringA,stringB)                | return the sum’s result of two large numbers            | string      |
| RETURN apoc.number.exact.sub(stringA,stringB)                | return the substraction’s of two large numbers          | string      |
| RETURN apoc.number.exact.mul(stringA,stringB,[prec],[roundingModel] | return the multiplication’s result of two large numbers | string      |
| RETURN apoc.number.exact.div(stringA,stringB,[prec],[roundingModel]) | return the division’s result of two large numbers       | string      |
| RETURN apoc.number.exact.toInteger(string,[prec],[roundingMode]) | return the Integer value of a large number              | Integer     |
| RETURN apoc.number.exact.toFloat(string,[prec],[roundingMode]) | return the Float value of a large number                | Float       |
| RETURN apoc.number.exact.toExact(number)                     | return the exact value                                  | Integer     |

- Possible 'roundingModel' options are `UP`, `DOWN`, `CEILING`, `FLOOR`, `HALF_UP`, `HALF_DOWN`, `HALF_EVEN`, `UNNECESSARY`

The `prec` parameter let us to set the precision of the operation result. The default value is 0 (unlimited precision arithmetic) while for 'roundingModel' the default value is `HALF_UP`. For other information abouth `prec` and `roundingModel` see the documentation of [MathContext](https://docs.oracle.com/javase/7/docs/api/java/math/MathContext.html)

For example if we set as `prec` 2:

```
  return apoc.number.exact.div('5555.5555','5', 2, 'HALF_DOWN') as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │  1100   │
  └─────────┘
```

As a result we have only the first two digits precise. If we set 8 we have all the result precise

```
  return apoc.number.exact.div('5555.5555','5', 8, 'HALF_DOWN') as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │1111.1111│
  └─────────┘
```

All the functions accept as input the **scientific notation** as `1E6`, for example:

```
  return apoc.number.exact.add('1E6','1E6') as value

  ╒═════════╕
  │value    │
  ╞═════════╡
  │ 2000000 │
  └─────────┘
```

For other information see the documentation about [BigDecimal](https://docs.oracle.com/javase/7/docs/api/java/math/BigDecimal.html#) and [BigInteger](https://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html#)

### [Fingerprinting](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#fingerprinting)

The following functions do calculate hashsums over nodes, relationship or the entire graph. It takes into account all properties, node labels and relationship types.

|      | be aware that the algorithm used for hashing might be changed from one apoc version to another. So you can only compare hashing results of two entities/graphs from the same or from different graph using the **very same** apoc version. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

The hashsum of a graph first calculates the hashsums for each node. This hashsum list is ordered and for each node the hashsum for all relationships and their endnode are added. This approach provides independence of internal ids.

Optionally you can supply a list of `propertyKeys` that should be ignored on all nodes. This is, e.g. useful if you store`created=timestamp()` properties that should be ignored.

| function name                                                | description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `apoc.hashing.fingerprint(object, <list_of_props_to_ignore>)` | calculates a md5 hashsum over the object. It deals gracefully with ordering (in case of maps), scalars, arrays. |
| `apoc.hashing.graph(<list_of_props_to_ignore>)`              | calculates a md5 hashsum over the full graph.                |

#### [Diff](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-difference)

Diff is a user function to return a detailed diff between two nodes.

```
apoc.diff.nodes([leftNode],[rightNode])
```

Example

```cypher
CREATE
    (n:Person{name:'Steve',age:34, eyes:'blue'}),
    (m:Person{name:'Jake',hair:'brown',age:34})
WITH n,m
return apoc.diff.nodes(n,m)
```

Resulting JSON body:

```json
{
  "leftOnly": {
    "eyes": "blue"
  },
  "inCommon": {
    "age": 34
  },
  "different": {
    "name": {
      "left": "Steve",
      "right": "Jake"
    }
  },
  "rightOnly": {
    "hair": "brown"
  }
}
```

### [Bitwise operations](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#bitwise-operations)

Provides a wrapper around the java bitwise operations.



examples

| operator | name                 | example                     | result |
| -------- | -------------------- | --------------------------- | ------ |
| a & b    | AND                  | apoc.bitwise.op(60,"&",13)  | 12     |
| a \| b   | OR                   | apoc.bitwise.op(60,"\|",13) | 61     |
| a ^ b    | XOR                  | apoc.bitwise.op(60,"&",13)  | 49     |
| ~a       | NOT                  | apoc.bitwise.op(60,"&",0)   | -61    |
| a << b   | LEFT SHIFT           | apoc.bitwise.op(60,"<<",2)  | 240    |
| a >> b   | RIGHT SHIFT          | apoc.bitwise.op(60,">>",2)  | 15     |
| a >>> b  | UNSIGNED RIGHT SHIFT | apoc.bitwise.op(60,">>>",2) | 15     |

### [Atomic](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#atomic-updates)

Atomic procedures handle the concurrency, it’s add a lock to the resource. If two users access to the same resource at the same time, with the parameter `times` (default value 5) we can determine how many time retry to modify the resource, until the lock is release.

| `CALL apoc.atomic.add(node/relationship, "property", number, [times]) YIELD oldValue, newValue` | adds the number to the value of the property               |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| `CALL apoc.atomic.subtract(node/relationship, "property", number, [times]) YIELD oldValue, newValue` | subtracts the number to the value of the property          |
| `CALL apoc.atomic.concat(node/relationship, "property", "string", [times]) YIELD oldValue, newValue` | concatenate the string to the property                     |
| `CALL apoc.atomic.insert(node/relationship, "property", position, object, [times]) YIELD oldValue, newValue` | inserts the object in the chosen position of the array     |
| `CALL apoc.atomic.remove(node/relationship, "property", position, [times]) YIELD oldValue, newValue` | remove from the array the element to the position selected |
| `CALL apoc.atomic.update(node/relationship, "property", "expression", [times]) YIELD oldValue, newValue` | update the property with the result of the expression      |

### [Atomic Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_atomic_examples)

add

Dataset

```cypher
CREATE (p:Person {name:'Tom',age: 40})
```

We can add 10 to the property `age`

```cypher
MATCH (n:Person {name:'Tom'})
CALL apoc.atomic.add(n,'age',10,5) YIELD oldValue, newValue
RETURN n
```

![apoc.atomic.add](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.add.png)

subtract

From the previous example we can go back to `age`: 40

```cypher
MATCH (n:Person {name:'Tom'})
CALL apoc.atomic.subtract(n,'age',10,5) YIELD oldValue, newValue
RETURN n
```

concat

Dataset

```cypher
CREATE (p:Person {name:'Will',age: 35})
MATCH (p:Person {name:'Will',age: 35})
CALL apoc.atomic.concat(p,"name",'iam',5) YIELD newValue
RETURN p
```

![apoc.atomic.concat](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.concat.png)

insert

Dataset

we add a propery `children` that is an array

```cypher
CREATE (p:Person {name:'Tom', children: ['Anne','Sam','Paul']})
```

![apoc.atomic.insert](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.insert.png)

Now we add `Mary` to propery children at the position 2

```cypher
MATCH (p:Person {name:'Tom'})
CALL apoc.atomic.insert(p,'children',2,'Mary',5) YIELD newValue
RETURN p
```

![apoc.atomic.insert.result](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.insert.result.png)

remove

Dataset

```cypher
CREATE (p:Person {name:'Tom', cars: ['Class A','X3','Focus']})
```

Now we remove the element `X3` which is at the position 1 from the array `cars`

```cypher
MATCH (p:Person {name:'Tom'})
CALL apoc.atomic.remove(p,'cars',1,5) YIELD newValue
RETURN p
```

![apoc.atomic.remove](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.remove.png)

update

Dataset

```
CREATE (p:Person {name:'Tom', salary1:1800, salary2:1500})
```

We want to update `salary1` with the result of an expression. The expression always have to be referenced with the `n.`that refers to the node/rel passed as parameter. If we rename our node/rel (as in the example above) we have anyway to refer to it in the expression as `n`.

```cypher
MATCH (p:Person {name:'Tom'})
CALL apoc.atomic.update(p,'salary1','n.salary1*3 + n.salary2',5) YIELD newValue
RETURN p
```

![apoc.atomic.update](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.atomic.update.png)

### [Log](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_log)

#### [Log Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#log)

APOC provide a set of store procedures in order to add log functionality:

- `apoc.log.info`: logs info message
- `apoc.log.error`: logs error message
- `apoc.log.warn`: logs warn message
- `apoc.log.debug`: logs debug message

Every log procedure has the following signature:

```
apoc.log.<name>(message, params)
```

Available configuration:

| property                    | type                                         | description                                                  |
| :-------------------------- | :------------------------------------------- | :----------------------------------------------------------- |
| `apoc.user.log.type`        | `enum[none, safe, raw] (default value safe)` | type of logging:`node`: disable the procedures`safe`: replace all `.` and whitespace (space and tab) with underscore and lowercase all characters`raw`: left the messages as-is |
| `apoc.user.log.window.ops`  | `int (default value 10)`                     | num of logs permitted in a time-window, exceeded this quota every log message will be skip |
| `apoc.user.log.window.time` | `long (default value 10000)`                 | the length (in milliseconds) of the time-window (default 10 seconds) |

Example:

The following call (with the default configuration):

```cypher
call apoc.log.info('Hello %s', ['World'])
```

produces the following output into the log:

```cypher
hello_world
```

## [Node, Relationship and Path Functions and Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#nodes-relationships)

Functions and procedures to efficiently find and navigate and dynamically create and update nodes and relationships.

- [Path Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#path-functions)
- [Lookup and Manipulation Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-lookup)
- [Node Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-functions)
- [Creating Data](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#data-creation)
- [Locking](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#locking)
- [Generating Graphs](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#graph-generators)
- [Parallel Node Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#parallel-node-search)

### [Path Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#path-functions)

Functions to create, combine and split paths

| `apoc.path.create(startNode,[rels])`        | creates a path instance of the given elements              |
| ------------------------------------------- | ---------------------------------------------------------- |
| `apoc.path.slice(path, [offset], [length])` | creates a sub-path with the given offset and length        |
| `apoc.path.combine(path1, path2)`           | combines the paths into one if the connecting node matches |
| `apoc.path.elements(path)`                  | returns a list of node-relationship-node-…                 |

### [Lookup and Manipulation Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-lookup)

| `CALL apoc.nodes.get(node|nodes|id|[ids])`    | quickly returns all nodes with these ids         |
| --------------------------------------------- | ------------------------------------------------ |
| `CALL apoc.get.rels(rel|id|[ids])`            | quickly returns all relationships with these ids |
| `CALL apoc.nodes.delete(node|nodes|id|[ids])` | quickly delete all nodes with these ids          |

### [Node Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#node-functions)

| `apoc.nodes.isDense(node)`                                   | returns true if it is a dense node                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.nodes.connected(start, end, rel-direction-pattern)`    | returns true when the node is connected to the other node, optimized for dense nodes |
| `apoc.node.relationship.exists(node, rel-direction-pattern)` | returns true when the node has the relationships of the pattern |
| `apoc.node.relationship.types(node, rel-direction-pattern)`  | returns a list of distinct relationship types                |
| `apoc.node.degree(node, rel-direction-pattern)`              | returns total degrees of the given relationships in the pattern, can use `'>'` or `'<'` for all outgoing or incoming relationships |
| `apoc.node.id(node)`                                         | returns id for (virtual) nodes                               |
| `apoc.node.degree.in(node, relationshipName)`                | returns total number of incoming relationship                |
| `apoc.node.degree.out(node, relationshipName)`               | returns total number of outgoing relationship                |
| `apoc.node.labels(node)`                                     | returns labels for (virtual) nodes                           |
| `apoc.rel.id(rel)`                                           | returns id for (virtual) relationships                       |
| `apoc.rel.type(rel)`                                         | returns type for (virtual) relationships                     |
| `apoc.any.properties(node/rel/map, )`                        | returns properties for virtual and real, nodes, rels and maps, optionally restrict via keys |
| `apoc.any.property(node/rel/map)`                            | returns property for virtual and real, nodes, rels and maps  |
| `apoc.create.uuid()`                                         | returns a UUID string                                        |
| `apoc.label.exists(element, label)`                          | returns true or false related to label existance             |

rel-direction-pattern syntax:

```
[<]RELATIONSHIP_TYPE1[>]|[<]RELATIONSHIP_TYPE2[>]|…
```

Example: `'FRIEND|MENTORS>|<REPORTS_TO'` will match to :FRIEND relationships in either direction, outgoing :MENTORS relationships, and incoming :REPORTS_TO relationships.

### [Creating Data](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#data-creation)

<iframe width="560" height="315" src="https://www.youtube.com/embed/KsAb8QHClNg" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

| `CALL apoc.create.node(['Label'], {key:value,…})`            | create node with dynamic labels                   |
| ------------------------------------------------------------ | ------------------------------------------------- |
| `CALL apoc.create.nodes(['Label'], [{key:value,…}])`         | create multiple nodes with dynamic labels         |
| `CALL apoc.create.addLabels( [node,id,ids,nodes], ['Label',…])` | adds the given labels to the node or nodes        |
| `CALL apoc.create.removeLabels( [node,id,ids,nodes], ['Label',…])` | removes the given labels from the node or nodes   |
| `CALL apoc.create.setProperty( [node,id,ids,nodes], key, value)` | sets the given property on the node(s)            |
| `CALL apoc.create.setProperties( [node,id,ids,nodes], [keys], [values])` | sets the given property on the nodes(s)           |
| `CALL apoc.create.setRelProperty( [rel,id,ids,rels], key, value)` | sets the given property on the relationship(s)    |
| `CALL apoc.create.setRelProperties( [rel,id,ids,rels], [keys], [values])` | sets the given property on the relationship(s)    |
| `CALL apoc.create.relationship(person1,'KNOWS',{key:value,…}, person2)` | create relationship with dynamic rel-type         |
| `CALL apoc.create.uuids(count) YIELD uuid, row`              | creates count UUIDs                               |
| `CALL apoc.nodes.link([nodes],'REL_TYPE')`                   | creates a linked list of nodes from first to last |

### [Locking](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#locking)

| `call apoc.lock.nodes([nodes])`               | acquires a write lock on the given nodes                   |
| --------------------------------------------- | ---------------------------------------------------------- |
| `call apoc.lock.rels([relationships])`        | acquires a write lock on the given relationship            |
| `call apoc.lock.all([nodes],[relationships])` | acquires a write lock on the given nodes and relationships |

### [Generating Graphs](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#graph-generators)

Generate undirected (random direction) graphs with semi-real random distributions based on theoretical models.

| `apoc.generate.er(noNodes, noEdges, 'label', 'type')`      | generates a graph according to Erdos-Renyi model (uniform)   |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| `apoc.generate.ws(noNodes, degree, beta, 'label', 'type')` | generates a graph according to Watts-Strogatz model (clusters) |
| `apoc.generate.ba(noNodes, edgesPerNode, 'label', 'type')` | generates a graph according to Barabasi-Albert model (preferential attachment) |
| `apoc.generate.complete(noNodes, 'label', 'type')`         | generates a complete graph (all nodes connected to all other nodes) |
| `apoc.generate.simple([degrees], 'label', 'type')`         | generates a graph with the given degree distribution         |

Example

```cypher
CALL apoc.generate.ba(1000, 2, 'TestLabel', 'TEST_REL_TYPE')
CALL apoc.generate.ws(1000, null, null, null)
CALL apoc.generate.simple([2,2,2,2], null, null)
```

### [Parallel Node Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#parallel-node-search)

Utility to find nodes in parallel (if possible). These procedures return a single list of nodes or a list of 'reduced' records with node id, labels, and the properties where the search was executed upon.

| `call apoc.search.node(labelPropertyMap, searchType, search ) yield node` | A distinct set of Nodes will be returned.                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `call apoc.search.nodeAll(labelPropertyMap, searchType, search ) yield node` | All the found Nodes will be returned.                        |
| `call apoc.search.nodeReduced(labelPropertyMap, searchType, search ) yield id, labels, values` | A merged set of 'minimal' Node information will be returned. One record per node (-id). |
| `call apoc.search.nodeAllReduced(labelPropertyMap, searchType, search ) yield id, labels, values` | All the found 'minimal' Node information will be returned. One record per label and property. |

| `labelPropertyMap` | `'{ label1 : "propertyOne", label2 :["propOne","propTwo"] }'` | (JSON or Map) For every Label-Property combination a search will be executed in parallel (if possible): Label1.propertyOne, label2.propOne and label2.propTwo. |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `searchType`       | 'exact' or 'contains' or 'starts with' or 'ends with'        | Case insensitive string search operators                     |
| `searchType`       | "<", ">", "=", "<>", "⇐", ">=", "=~"                         | Operators                                                    |
| `search`           | 'Keanu'                                                      | The actual search term (string, number, etc).                |

example

```cypher
CALL apoc.search.nodeAll('{Person: "name",Movie: ["title","tagline"]}','contains','her') YIELD node AS n RETURN n
call apoc.search.nodeReduced({Person: 'born', Movie: ['released']},'>',2000) yield id, labels, properties RETURN *
```

## [Path Finding](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#path-finding)

APOC exposes some built in path-finding functions that Neo4j brings along.

| `apoc.algo.dijkstra(startNode, endNode, 'KNOWS|<WORKS_WITH|IS_MANAGER_OF>', 'distance') YIELD path, weight` | run dijkstra with relationship property name as cost function |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.algo.dijkstraWithDefaultWeight(startNode, endNode, 'KNOWS|<WORKS_WITH|IS_MANAGER_OF>', 'distance', 10) YIELD path, weight` | run dijkstra with relationship property name as cost function and a default weight if the property does not exist |
| `apoc.algo.aStar(startNode, endNode, 'KNOWS|<WORKS_WITH|IS_MANAGER_OF>', 'distance','lat','lon') YIELD path, weight` | run A* with relationship property name as cost function      |
| `apoc.algo.aStar(startNode, endNode, 'KNOWS|<WORKS_WITH|IS_MANAGER_OF>', {weight:'dist',default:10, x:'lon',y:'lat'}) YIELD path, weight` | run A* with relationship property name as cost function      |
| `apoc.algo.allSimplePaths(startNode, endNode, 'KNOWS|<WORKS_WITH|IS_MANAGER_OF>', 5) YIELD path, weight` | run allSimplePaths with relationships given and maxNodes     |
| `apoc.stats.degrees(relTypesDirections) yield type, direction, total, min, max, mean, p50, p75, p90, p95, p99, p999` | compute degree distribution in parallel                      |

Example: find the weighted shortest path based on relationship property `d` from `A` to `B` following just `:ROAD`relationships

```cypher
MATCH (from:Loc{name:'A'}), (to:Loc{name:'D'})
CALL apoc.algo.dijkstra(from, to, 'ROAD', 'd') yield path as path, weight as weight
RETURN path, weight
```

### [Path Expander](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#path-expander)

Thanks to Andrew Bowman (@inversefalcon) and Kees Vegter (@keesvegter)

The apoc.path.expand procedure makes it possible to do variable length path traversals where you can specify the direction of the relationship per relationship type and a list of Label names which act as a "whitelist" or a "blacklist" or define end nodes for the expansion. The procedure will return a list of Paths in a variable name called "path".

| `call apoc.path.expand(startNode <id>|Node, relationshipFilter, labelFilter, minDepth, maxDepth ) yield path as <identifier>` | expand from given nodes(s) taking the provided restrictions into account |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

Variations allow more configurable expansions, and expansions for more specific use cases:

| `call apoc.path.expandConfig(startNode <id>Node/list, {minLevel, maxLevel, relationshipFilter, labelFilter, bfs:true, uniqueness:'RELATIONSHIP_PATH', filterStartNode:true, limit, optional:false, endNodes, terminatorNodes, sequence, beginSequenceAtStart:true}) yield path` | expand from given nodes(s) taking the provided restrictions into account |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `call apoc.path.subgraphNodes(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit, optional:false, endNodes, terminatorNodes, sequence, beginSequenceAtStart:true}) yield node` | expand a subgraph from given nodes(s) taking the provided restrictions into account; returns all nodes in the subgraph |
| `call apoc.path.subgraphAll(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit, endNodes, terminatorNodes, sequence, beginSequenceAtStart:true}) yield nodes, relationships` | expand a subgraph from given nodes(s) taking the provided restrictions into account; returns the collection of subgraph nodes, and the collection of all relationships within the subgraph |
| `call apoc.path.spanningTree(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit, optional:false, endNodes, terminatorNodes, sequence, beginSequenceAtStart:true}) yield path` | expand a spanning tree from given nodes(s) taking the provided restrictions into account; the paths returned collectively form a spanning tree |

#### [Relationship Filter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_relationship_filter)

Syntax: `[<]RELATIONSHIP_TYPE1[>]|[<]RELATIONSHIP_TYPE2[>]|…`

| input      | type       | direction |
| :--------- | :--------- | :-------- |
| `LIKES>`   | `LIKES`    | OUTGOING  |
| `<FOLLOWS` | `FOLLOWS`  | INCOMING  |
| `KNOWS`    | `KNOWS`    | BOTH      |
| `>`        | `any type` | OUTGOING  |
| `<`        | `any type` | INCOMING  |

#### [Label Filter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_label_filter)

Syntax: `[+-/>]LABEL1|LABEL2|*|…`

| input     | result                                                       |
| :-------- | :----------------------------------------------------------- |
| `-Foe`    | blacklist filter - No node in the path will have a label in the blacklist. |
| `+Friend` | whitelist filter - All nodes in the path must have a label in the whitelist (exempting termination and end nodes, if using those filters). If no whitelist operator is present, all labels are considered whitelisted. |
| `/Friend` | termination filter - Only return paths up to a node of the given labels, and stop further expansion beyond it. Termination nodes do not have to respect the whitelist. Termination filtering takes precedence over end node filtering. |
| `>Friend` | end node filter - Only return paths up to a node of the given labels, but continue expansion to match on end nodes beyond it. End nodes do not have to respect the whitelist to be returned, but expansion beyond them is only allowed if the node has a label in the whitelist. |

Syntax Changes

As of APOC 3.1.3.x multiple label filter operations are allowed. In prior versions, only one type of operation is allowed in the label filter (`+` or `-` or `/` or `>`, never more than one).

With APOC 3.2.x.x, label filters will no longer apply to starting nodes of the expansion by default, but this can be toggled with the `filterStartNode` config parameter.

With the APOC releases in January 2018, some behavior has changed in the label filters:

| filter                   | changed behavior                                             |
| :----------------------- | :----------------------------------------------------------- |
| `No filter`              | Now indicates the label is whitelisted, same as if it were prefixed with `+`. Previously, a label without a filter symbol reused the previously used symbol. |
| `> (end node filter)`    | The label is additionally whitelisted, so expansion will always continue beyond an end node (unless prevented by the blacklist). Previously, expansion would only continue if allowed by the whitelist and not disallowed by the blacklist. This also applies at a depth below `minLevel`, allowing expansion to continue. |
| `/ (termination filter)` | When at depth below `minLevel`, expansion is allowed to continue and no pruning will take place (unless prevented by the blacklist). Previously, expansion would only continue if allowed by the whitelist and not disallowed by the blacklist. |
| `All filters`            | `*` is allowed as a standin for all labels. Additionally, compound labels are supported (like `Person:Manager`), and only apply to nodes with all of those labels present (order agnositic). |

#### [Sequences](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_sequences)

Introduced in the February 2018 APOC releases, path expander procedures can expand on repeating sequences of labels, relationship types, or both.

If only using label sequences, just use the `labelFilter`, but use commas to separate the filtering for each step in the repeating sequence.

If only using relationship sequences, just use the `relationshipFilter`, but use commas to separate the filtering for each step of the repeating sequence.

If using sequences of both relationships and labels, use the `sequence` parameter.

| Usage                                      | config param         | description                                                  | syntax                                                       | explanation                                                  |
| :----------------------------------------- | :------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| label sequences only                       | `labelFilter`        | Same syntax and filters, but uses commas (`,`) to separate the filters for each step in the sequence. | `labelFilter:'Post|-Blocked,Reply,>Admin'`                   | Start node must be a :Post node that isn’t :Blocked, next node must be a :Reply, and the next must be an :Admin, then repeat if able. Only paths ending with the `:Admin` node in that position of the sequence will be returned. |
| relationship sequences only                | `relationshipFilter` | Same syntax, but uses commas (`,`) to separate the filters for each relationship traversal in the sequence. | `relationshipFilter:'NEXT>,<FROM,POSTED>|REPLIED>'`          | Expansion will first expand `NEXT>` from the start node, then `<FROM`, then either `POSTED>`or `REPLIED>`, then repeat if able. |
| sequences of both labels and relationships | `sequence`           | A string of comma-separated alternating label and relationship filters, for each step in a repeating sequence. The sequence should begin with a label filter, and end with a relationship filter. If present, `labelFilter`, and `relationshipFilter`are ignored, as this takes priority. | `sequence:'Post|-Blocked, NEXT>, Reply, <FROM, >Admin, POSTED>|REPLIED>'` | Combines the behaviors above.                                |

##### [Starting the sequence at one-off from the start node](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_starting_the_sequence_at_one_off_from_the_start_node)

There are some uses cases where the sequence does not begin at the start node, but at one node distant.

A new config parameter, `beginSequenceAtStart`, can toggle this behavior.

Default value is `true`.

If set to `false`, this changes the expected values for `labelFilter`, `relationshipFilter`, and `sequence` as noted below:

| sequence             | altered behavior                                             | example                                                      | explanation                                                  |
| :------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `labelFilter`        | The start node is not considered part of the sequence. The sequence begins one node off from the start node. | `beginSequenceAtStart:false, labelFilter:'Post|-Blocked,Reply,>Admin'` | The next node(s) out from the start node begins the sequence (and must be a :Post node that isn’t :Blocked), and only paths ending with `Admin` nodes returned. |
| `relationshipFilter` | The first relationship filter in the sequence string will not be considered part of the repeating sequence, and will only be used for the first relationship from the start node to the node that will be the actual start of the sequence. | `beginSequenceAtStart:false, relationshipFilter:'FIRST>,NEXT>,<FROM,POSTED>|REPLIED>'` | `FIRST>` will be traversed just from the start node to the node that will be the start of the repeating `NEXT>,<FROM,POSTED>|REPLIED>`sequence. |
| `sequence`           | Combines the above two behaviors.                            | `beginSequenceAtStart:false, sequence:'FIRST>, Post|-Blocked, NEXT>, Reply, <FROM, >Admin, POSTED>|REPLIED>'` | Combines the behaviors above.                                |

Sequence tips

Label filtering in sequences work together with the `endNodes`+`terminatorNodes`, though inclusion of a node must be unanimous.

Remember that `filterStartNode` defaults to `false` for APOC 3.2.x.x and newer. If you want the start node filtered according to the first step in the sequence, you may need to set this explicitly to `true`.

If you need to limit the number of times a sequence repeats, this can be done with the `maxLevel` config param (multiply the number of iterations with the size of the nodes in the sequence).

As paths are important when expanding sequences, we recommend avoiding `apoc.path.subgraphNodes()`, `apoc.path.subgraphAll()`, and `apoc.path.spanningTree()` when using sequences, as the configurations that make these efficient at matching to distinct nodes may interfere with sequence pathfinding.

#### [Uniqueness](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_uniqueness)

Uniqueness of nodes and relationships guides the expansion and the returned results. Uniqueness is only configurable using `expandConfig()`.

`subgraphNodes()`, `subgraphAll()`, and `spanningTree()` all use 'NODE_GLOBAL' uniqueness.

| value                 | description                                                  |
| :-------------------- | :----------------------------------------------------------- |
| `RELATIONSHIP_PATH`   | For each returned node there’s a (relationship wise) unique path from the start node to it. This is Cypher’s default expansion mode. |
| `NODE_GLOBAL`         | A node cannot be traversed more than once. This is what the legacy traversal framework does. |
| `NODE_LEVEL`          | Entities on the same level are guaranteed to be unique.      |
| `NODE_PATH`           | For each returned node there’s a unique path from the start node to it. |
| `NODE_RECENT`         | This is like NODE_GLOBAL, but only guarantees uniqueness among the most recent visited nodes, with a configurable count. Traversing a huge graph is quite memory intensive in that it keeps track of all the nodes it has visited. For huge graphs a traverser can hog all the memory in the JVM, causing OutOfMemoryError. Together with this Uniqueness you can supply a count, which is the number of most recent visited nodes. This can cause a node to be visited more than once, but scales infinitely. |
| `RELATIONSHIP_GLOBAL` | A relationship cannot be traversed more than once, whereas nodes can. |
| `RELATIONSHIP_LEVEL`  | Entities on the same level are guaranteed to be unique.      |
| `RELATIONSHIP_RECENT` | Same as for NODE_RECENT, but for relationships.              |
| `NONE`                | No restriction (the user will have to manage it)             |

#### [Node Filters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_node_filters)

While label filters use labels to allow whitelisting, blacklisting, and restrictions on which kind of nodes can end or terminate expansion, you can also filter based upon actual nodes.

Each of these config parameter accepts a list of nodes, or a list of node ids.

| config parameter  | description                                                  | added in                   |
| :---------------- | :----------------------------------------------------------- | :------------------------- |
| `endNodes`        | Only these nodes can end returned paths, and expansion will continue past these nodes, if possible. | Winter 2018 APOC releases. |
| `terminatorNodes` | Only these nodes can end returned paths, and expansion won’t continue past these nodes. | Winter 2018 APOC releases. |
| `whitelistNodes`  | Only these nodes are allowed in the expansion (though endNodes and terminatorNodes will also be allowed, if present). | Spring 2018 APOC releases. |
| `blacklistNodes`  | None of the paths returned will include these nodes.         | Spring 2018 APOC releases. |

#### [Expand paths](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand_paths)

Expand from start node following the given relationships from min to max-level adhering to the label filters. Several variations exist:

`apoc.path.expand()` expands paths using Cypher’s default expansion modes (bfs and 'RELATIONSHIP_PATH' uniqueness)

`apoc.path.expandConfig()` allows more flexible configuration of parameters and expansion modes

`apoc.path.subgraphNodes()` expands to nodes of a subgraph

`apoc.path.subgraphAll()` expands to nodes of a subgraph and also returns all relationships in the subgraph

`apoc.path.spanningTree()` expands to paths collectively forming a spanning tree

#### [Expand](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand)

```cypher
CALL apoc.path.expand(startNode <id>|Node, relationshipFilter, labelFilter, minLevel, maxLevel )

CALL apoc.path.expand(startNode <id>|Node|list, 'TYPE|TYPE_OUT>|<TYPE_IN', '+YesLabel|-NoLabel|/TerminationLabel|>EndNodeLabel', minLevel, maxLevel ) yield path
```

#### [Relationship Filter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_relationship_filter_2)

Syntax: `[<]RELATIONSHIP_TYPE1[>]|[<]RELATIONSHIP_TYPE2[>]|…`

| input      | type       | direction |
| :--------- | :--------- | :-------- |
| `LIKES>`   | `LIKES`    | OUTGOING  |
| `<FOLLOWS` | `FOLLOWS`  | INCOMING  |
| `KNOWS`    | `KNOWS`    | BOTH      |
| `>`        | `any type` | OUTGOING  |
| `<`        | `any type` | INCOMING  |

#### [Label Filter](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_label_filter_2)

Syntax: `[+-/>]LABEL1|LABEL2|*|…`

| input     | result                                                       |
| :-------- | :----------------------------------------------------------- |
| `-Foe`    | blacklist filter - No node in the path will have a label in the blacklist. |
| `+Friend` | whitelist filter - All nodes in the path must have a label in the whitelist (exempting termination and end nodes, if using those filters). If no whitelist operator is present, all labels are considered whitelisted. |
| `/Friend` | termination filter - Only return paths up to a node of the given labels, and stop further expansion beyond it. Termination nodes do not have to respect the whitelist. Termination filtering takes precedence over end node filtering. |
| `>Friend` | end node filter - Only return paths up to a node of the given labels, but continue expansion to match on end nodes beyond it. End nodes do not have to respect the whitelist to be returned, but expansion beyond them is only allowed if the node has a label in the whitelist. |

Syntax Changes

As of APOC 3.1.3.x multiple label filter operations are allowed. In prior versions, only one type of operation is allowed in the label filter (`+` or `-` or `/` or `>`, never more than one).

With APOC 3.2.x.x, label filters will no longer apply to starting nodes of the expansion by default, but this can be toggled with the `filterStartNode` config parameter.

With the APOC releases in January 2018, some behavior has changed in the label filters:

| filter                   | changed behavior                                             |
| :----------------------- | :----------------------------------------------------------- |
| `No filter`              | Now indicates the label is whitelisted, same as if it were prefixed with `+`. Previously, a label without a filter symbol reused the previously used symbol. |
| `> (end node filter)`    | The label is additionally whitelisted, so expansion will always continue beyond an end node (unless prevented by the blacklist). Previously, expansion would only continue if allowed by the whitelist and not disallowed by the blacklist. This also applies at a depth below `minLevel`, allowing expansion to continue. |
| `/ (termination filter)` | When at depth below `minLevel`, expansion is allowed to continue and no pruning will take place (unless prevented by the blacklist). Previously, expansion would only continue if allowed by the whitelist and not disallowed by the blacklist. |
| `All filters`            | `*` is allowed as a standin for all labels. Additionally, compound labels are supported (like `Person:Manager`), and only apply to nodes with all of those labels present (order agnositic). |

Examples

```cypher
call apoc.path.expand(1,"ACTED_IN>|PRODUCED<|FOLLOWS<","+Movie|Person",0,3)
call apoc.path.expand(1,"ACTED_IN>|PRODUCED<|FOLLOWS<","-BigBrother",0,3)
call apoc.path.expand(1,"ACTED_IN>|PRODUCED<|FOLLOWS<","",0,3)

// combined with cypher:

match (tom:Person {name :"Tom Hanks"})
call apoc.path.expand(tom,"ACTED_IN>|PRODUCED<|FOLLOWS<","+Movie|Person",0,3) yield path as pp
return pp;

// or

match (p:Person) with p limit 3
call apoc.path.expand(p,"ACTED_IN>|PRODUCED<|FOLLOWS<","+Movie|Person",1,2) yield path as pp
return p, pp
```

Termination and end node label filter example

We will first set a `:Western` label on some nodes.

```cypher
match (p:Person)
where p.name in ['Clint Eastwood', 'Gene Hackman']
set p:Western
```

Now expand from 'Keanu Reeves' to all `:Western` nodes with a termination filter:

```cypher
match (k:Person {name:'Keanu Reeves'})
call apoc.path.expandConfig(k, {relationshipFilter:'ACTED_IN|PRODUCED|DIRECTED', labelFilter:'/Western', uniqueness: 'NODE_GLOBAL'}) yield path
return path
```

The one returned path only matches up to 'Gene Hackman'. While there is a path from 'Keanu Reeves' to 'Clint Eastwood' through 'Gene Hackman', no further expansion is permitted through a node in the termination filter.

If you didn’t want to stop expansion on reaching 'Gene Hackman', and wanted 'Clint Eastwood' returned as well, use the end node filter instead (`>`).

Label filter operator precedence and behavior

As of APOC 3.1.3.x, multiple label filter operators are allowed at the same time.

When processing the labelFilter string, once a filter operator is introduced, it remains the active filter until another filter supplants it. (Not applicable after February 2018 release, as no filter will now mean the label is whitelisted).

In the following example, `:Person` and `:Movie` labels are whitelisted, `:SciFi` is blacklisted, with `:Western` acting as an end node label, and `:Romance` acting as a termination label.

```
… labelFilter:'+Person|Movie|-SciFi|>Western|/Romance' …
```

The precedence of operator evaluation isn’t dependent upon their location in the labelFilter but is fixed:

Blacklist filter `-`, termination filter `/`, end node filter `>`, whitelist filter `+`.

The consequences are as follows:

- No blacklisted label `-` will ever be present in the nodes of paths returned, no matter if the same label (or another label of a node with a blacklisted label) is included in another filter list.
- If the termination filter `/` or end node filter `>` is used, then only paths up to nodes with those labels will be returned as results. These end nodes are exempt from the whitelist filter.
- If a node is a termination node `/`, no further expansion beyond the node will occur.
- If a node is an end node `>`, expansion beyond that node will only occur if the end node has a label in the whitelist. This is to prevent returning paths to nodes where a node on that path violates the whitelist. (this no longer applies in releases after February 2018)
- The whitelist only applies to nodes up to but not including end nodes from the termination or end node filters. If no end node or termination node operators are present, then the whitelist applies to all nodes of the path.
- If no whitelist operators are present in the labelFilter, this is treated as if all labels are whitelisted.
- If `filterStartNode` is false (which will be default in APOC 3.2.x.x), then the start node is exempt from the label filter.

#### [Sequences](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_sequences_2)

Introduced in the February 2018 APOC releases, path expander procedures can expand on repeating sequences of labels, relationship types, or both.

If only using label sequences, just use the `labelFilter`, but use commas to separate the filtering for each step in the repeating sequence.

If only using relationship sequences, just use the `relationshipFilter`, but use commas to separate the filtering for each step of the repeating sequence.

If using sequences of both relationships and labels, use the `sequence` parameter.

| Usage                                      | config param         | description                                                  | syntax                                                       | explanation                                                  |
| :----------------------------------------- | :------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| label sequences only                       | `labelFilter`        | Same syntax and filters, but uses commas (`,`) to separate the filters for each step in the sequence. | `labelFilter:'Post|-Blocked,Reply,>Admin'`                   | Start node must be a :Post node that isn’t :Blocked, next node must be a :Reply, and the next must be an :Admin, then repeat if able. Only paths ending with the `:Admin` node in that position of the sequence will be returned. |
| relationship sequences only                | `relationshipFilter` | Same syntax, but uses commas (`,`) to separate the filters for each relationship traversal in the sequence. | `relationshipFilter:'NEXT>,<FROM,POSTED>|REPLIED>'`          | Expansion will first expand `NEXT>` from the start node, then `<FROM`, then either `POSTED>`or `REPLIED>`, then repeat if able. |
| sequences of both labels and relationships | `sequence`           | A string of comma-separated alternating label and relationship filters, for each step in a repeating sequence. The sequence should begin with a label filter, and end with a relationship filter. If present, `labelFilter`, and `relationshipFilter`are ignored, as this takes priority. | `sequence:'Post|-Blocked, NEXT>, Reply, <FROM, >Admin, POSTED>|REPLIED>'` | Combines the behaviors above.                                |

##### [Starting the sequence at one-off from the start node](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_starting_the_sequence_at_one_off_from_the_start_node_2)

There are some uses cases where the sequence does not begin at the start node, but at one node distant.

A new config parameter, `beginSequenceAtStart`, can toggle this behavior.

Default value is `true`.

If set to `false`, this changes the expected values for `labelFilter`, `relationshipFilter`, and `sequence` as noted below:

| sequence             | altered behavior                                             | example                                                      | explanation                                                  |
| :------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `labelFilter`        | The start node is not considered part of the sequence. The sequence begins one node off from the start node. | `beginSequenceAtStart:false, labelFilter:'Post|-Blocked,Reply,>Admin'` | The next node(s) out from the start node begins the sequence (and must be a :Post node that isn’t :Blocked), and only paths ending with `Admin` nodes returned. |
| `relationshipFilter` | The first relationship filter in the sequence string will not be considered part of the repeating sequence, and will only be used for the first relationship from the start node to the node that will be the actual start of the sequence. | `beginSequenceAtStart:false, relationshipFilter:'FIRST>,NEXT>,<FROM,POSTED>|REPLIED>'` | `FIRST>` will be traversed just from the start node to the node that will be the start of the repeating `NEXT>,<FROM,POSTED>|REPLIED>`sequence. |
| `sequence`           | Combines the above two behaviors.                            | `beginSequenceAtStart:false, sequence:'FIRST>, Post|-Blocked, NEXT>, Reply, <FROM, >Admin, POSTED>|REPLIED>'` | Combines the behaviors above.                                |

Sequence tips

Label filtering in sequences work together with the `endNodes`+`terminatorNodes`, though inclusion of a node must be unanimous.

Remember that `filterStartNode` defaults to `false` for APOC 3.2.x.x and newer. If you want the start node filtered according to the first step in the sequence, you may need to set this explicitly to `true`.

If you need to limit the number of times a sequence repeats, this can be done with the `maxLevel` config param (multiply the number of iterations with the size of the nodes in the sequence).

As paths are important when expanding sequences, we recommend avoiding `apoc.path.subgraphNodes()`, `apoc.path.subgraphAll()`, and `apoc.path.spanningTree()` when using sequences, as the configurations that make these efficient at matching to distinct nodes may interfere with sequence pathfinding.

#### [Expand with Config](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand_with_config)

```
apoc.path.expandConfig(startNode <id>Node/list, {config}) yield path expands from start nodes using the given configuration and yields the resulting paths
```

Takes an additional map parameter, `config`, to provide configuration options:

Config

```
{minLevel: -1|number,
 maxLevel: -1|number,
 relationshipFilter: '[<]RELATIONSHIP_TYPE1[>]|[<]RELATIONSHIP_TYPE2[>], [<]RELATIONSHIP_TYPE3[>]|[<]RELATIONSHIP_TYPE4[>]',
 labelFilter: '[+-/>]LABEL1|LABEL2|*,[+-/>]LABEL1|LABEL2|*,...',
 uniqueness: RELATIONSHIP_PATH|NONE|NODE_GLOBAL|NODE_LEVEL|NODE_PATH|NODE_RECENT|
             RELATIONSHIP_GLOBAL|RELATIONSHIP_LEVEL|RELATIONSHIP_RECENT,
 bfs: true|false,
 filterStartNode: true|false,
 limit: -1|number,
 optional: true|false,
 endNodes: [nodes],
 terminatorNodes: [nodes],
 beginSequenceAtStart: true|false}
```

#### [Start Node and label filters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_start_node_and_label_filters)

The config parameter `filterStartNode` defines whether or not the labelFilter (and `sequence`) applies to the start node of the expansion.

Use `filterStartNode: false` when you want your label filter to only apply to all other nodes in the path, ignoring the start node.

`filterStartNode` defaults for all path expander procedures:

| version         | default                 |
| :-------------- | :---------------------- |
| >= APOC 3.2.x.x | filterStartNode = false |
| < APOC 3.2.x.x  | filterStartNode = true  |

#### [Limit](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_limit)

You can use the `limit` config parameter to limit the number of paths returned.

When using `bfs:true` (which is the default for all expand procedures), this has the effect of returning paths to the `n`nearest nodes with labels in the termination or end node filter, where `n` is the limit given.

The default limit value, `-1`, means no limit.

If you want to make sure multiple paths should never match to the same node, use `expandConfig()` with 'NODE_GLOBAL' uniqueness, or any expand procedure which already uses this uniqueness (`subgraphNodes()`, `subgraphAll()`, and `spanningTree()`).

#### [Optional](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_optional)

When `optional` is set to true, the path expansion is optional, much like an OPTIONAL MATCH, so a `null` value is yielded whenever the expansion would normally eliminate rows due to no results.

By default `optional` is false for all expansion procedures taking a config parameter.

Uniqueness

Uniqueness of nodes and relationships guides the expansion and the results returned. Uniqueness is only configurable using `expandConfig()`.

`subgraphNodes()`, `subgraphAll()`, and `spanningTree()` all use 'NODE_GLOBAL' uniqueness.

| value                 | description                                                  |
| :-------------------- | :----------------------------------------------------------- |
| `RELATIONSHIP_PATH`   | For each returned node there’s a (relationship wise) unique path from the start node to it. This is Cypher’s default expansion mode. |
| `NODE_GLOBAL`         | A node cannot be traversed more than once. This is what the legacy traversal framework does. |
| `NODE_LEVEL`          | Entities on the same level are guaranteed to be unique.      |
| `NODE_PATH`           | For each returned node there’s a unique path from the start node to it. |
| `NODE_RECENT`         | This is like NODE_GLOBAL, but only guarantees uniqueness among the most recent visited nodes, with a configurable count. Traversing a huge graph is quite memory intensive in that it keeps track of all the nodes it has visited. For huge graphs a traverser can hog all the memory in the JVM, causing OutOfMemoryError. Together with this Uniqueness you can supply a count, which is the number of most recent visited nodes. This can cause a node to be visited more than once, but scales infinitely. |
| `RELATIONSHIP_GLOBAL` | A relationship cannot be traversed more than once, whereas nodes can. |
| `RELATIONSHIP_LEVEL`  | Entities on the same level are guaranteed to be unique.      |
| `RELATIONSHIP_RECENT` | Same as for NODE_RECENT, but for relationships.              |
| `NONE`                | No restriction (the user will have to manage it)             |

#### [Node filters](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_node_filters_2)

While label filters use labels to allow whitelisting, blacklisting, and restrictions on which kind of nodes can end or terminate expansion, you can also filter based upon actual nodes.

Each of these config parameter accepts a list of nodes, or a list of node ids.

| config parameter  | description                                                  | added in                   |
| :---------------- | :----------------------------------------------------------- | :------------------------- |
| `endNodes`        | Only these nodes can end returned paths, and expansion will continue past these nodes, if possible. | Winter 2018 APOC releases. |
| `terminatorNodes` | Only these nodes can end returned paths, and expansion won’t continue past these nodes. | Winter 2018 APOC releases. |
| `whitelistNodes`  | Only these nodes are allowed in the expansion (though endNodes and terminatorNodes will also be allowed, if present). | Spring 2018 APOC releases. |
| `blacklistNodes`  | None of the paths returned will include these nodes.         | Spring 2018 APOC releases. |

#### [General Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_general_examples)

You can turn this cypher query:

```cypher
MATCH (user:User) WHERE user.id = 460
MATCH (user)-[:RATED]->(movie)<-[:RATED]-(collab)-[:RATED]->(reco)
RETURN count(*);
```

into this procedure call, with changed semantics for uniqueness and bfs (which is Cypher’s expand mode)

```cypher
MATCH (user:User) WHERE user.id = 460
CALL apoc.path.expandConfig(user,{relationshipFilter:"RATED",minLevel:3,maxLevel:3,bfs:false,uniqueness:"NONE"}) YIELD path
RETURN count(*);
```

#### [Expand to nodes in a subgraph](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand_to_nodes_in_a_subgraph)

```
apoc.path.subgraphNodes(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit:-1, optional:false}) yield node
```

Expand to subgraph nodes reachable from the start node following relationships to max-level adhering to the label filters.

Accepts the same `config` values as in `expandConfig()`, though `uniqueness` and `minLevel` are not configurable.

Examples

Expand to all nodes of a connected subgraph:

```cypher
MATCH (user:User) WHERE user.id = 460
CALL apoc.path.subgraphNodes(user, {}) YIELD node
RETURN node;
```

Expand to all nodes reachable by :FRIEND relationships:

```cypher
MATCH (user:User) WHERE user.id = 460
CALL apoc.path.subgraphNodes(user, {relationshipFilter:'FRIEND'}) YIELD node
RETURN node;
```

### [Expand to a subgraph and return all nodes and relationships within the subgraph](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand_to_a_subgraph_and_return_all_nodes_and_relationships_within_the_subgraph)

```
apoc.path.subgraphAll(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit:-1}) yield nodes, relationships
```

Expand to subgraph nodes reachable from the start node following relationships to max-level adhering to the label filters. Returns the collection of nodes in the subgraph, and the collection of relationships between all subgraph nodes.

Accepts the same `config` values as in `expandConfig()`, though `uniqueness` and `minLevel` are not configurable.

The `optional` config value isn’t needed, as empty lists are yielded if there are no results, so rows are never eliminated.

Example

Expand to local subgraph (and all its relationships) within 4 traversals:

```cypher
MATCH (user:User) WHERE user.id = 460
CALL apoc.path.subgraphAll(user, {maxLevel:4}) YIELD nodes, relationships
RETURN nodes, relationships;
```

### [Expand a spanning tree](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_expand_a_spanning_tree)

```
apoc.path.spanningTree(startNode <id>Node/list, {maxLevel, relationshipFilter, labelFilter, bfs:true, filterStartNode:true, limit:-1, optional:false}) yield path
```

Expand a spanning tree reachable from start node following relationships to max-level adhering to the label filters. The paths returned collectively form a spanning tree.

Accepts the same `config` values as in `expandConfig()`, though `uniqueness` and `minLevel` are not configurable.

Example

Expand a spanning tree of all contiguous :User nodes:

```cypher
MATCH (user:User) WHERE user.id = 460
CALL apoc.path.spanningTree(user, {labelFilter:'+User'}) YIELD path
RETURN path;
```

### [Neighbor Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#neighbourhood-search)

| `apoc.neighbors.tohop(node, rel-direction-pattern, distance)` | returns distinct nodes of the given relationships in the pattern up to a certain distance |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.neighbors.tohop.count(node, rel-direction-pattern, distance)` | returns the count of distinct nodes of the given relationships in the pattern up to a certain distance |
| `apoc.neighbors.byhop(node, rel-direction-pattern, distance)` | returns distinct nodes of the given relationships in the pattern grouped by distance |
| `apoc.neighbors.byhop.count(node, rel-direction-pattern, distance)` | returns the count distinct nodes of the given relationships in the pattern grouped by distance |
| `apoc.neighbors.athop(node, rel-direction-pattern, distance)` | returns distinct nodes of the given relationships in the pattern at a certain distance |
| `apoc.neighbors.athop.count(node, rel-direction-pattern, distance)` | returns the count of distinct nodes of the given relationships in the pattern at a certain distance |

## [Cypher Execution](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#cypher-execution)

| `CALL apoc.cypher.run(fragment, params) yield value`         | executes reading fragment with the given parameters          |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.cypher.runFirstColumnSingle(statement, params)`        | function that executes statement with given parameters returning first column only, will return first/single row or null |
| `apoc.cypher.runFirstColumnMany(statement, params)`          | function that executes statement with given parameters returning first column only, will collect all rows into a list |
| `CALL apoc.cypher.runFile(file or url,{config}) yield row, result` | runs each statement in the file, all semicolon separated - currently no schema operations |
| `CALL apoc.cypher.runFiles([files or urls],{config}) yield row, result` | runs each statement in the files, all semicolon separated    |
| `CALL apoc.cypher.runSchemaFile(file or url,{config}) - allows only schema operations, runs each schema statement in the file, all semicolon separated` | CALL apoc.cypher.runSchemaFiles([files or urls],{config}) - allows only schema operations, runs each schema statement in the files, all semicolon separated |
| `CALL apoc.cypher.runMany('cypher;\nstatements;',{params},{config})` | runs each semicolon separated statement and returns summary - currently no schema operations |
| `CALL apoc.cypher.mapParallel(fragment, params, list-to-parallelize) yield value` | executes fragment in parallel batches with the list segments being assigned to _ |
| `CALL apoc.cypher.doIt(fragment, params) yield value`        | executes writing fragment with the given parameters          |
| `CALL apoc.cypher.runTimeboxed('cypherStatement',{params}, timeout)` | abort statement after timeout millis if not finished         |

### [Running Cypher fragments](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#running-cypher)

We can use Cypher as safe, graph-aware, partially compiled scripting language within APOC.

| type      | qualified name                     | description                                                  |
| :-------- | :--------------------------------- | :----------------------------------------------------------- |
| procedure | `apoc.cypher.runTimeboxed`         | apoc.cypher.runTimeboxed('cypherStatement',{params}, timeout) - abort kernelTransaction after timeout ms if not finished |
| procedure | `apoc.cypher.run`                  | apoc.cypher.run(fragment, params) yield value - executes reading fragment with the given parameters |
| procedure | `apoc.cypher.runFile`              | apoc.cypher.runFile(file or url,[{statistics:true,timeout:10,parameters:{}}]) - runs each statement in the file, all semicolon separated - currently no schema operations |
| procedure | `apoc.cypher.runFiles`             | apoc.cypher.runFiles([files or urls],[{statistics:true,timeout:10,parameters:{}}])) - runs each statement in the files, all semicolon separated |
| procedure | `apoc.cypher.runSchemaFile`        | apoc.cypher.runSchemaFile(file or url,[{statistics:true,timeout:10}]) - allows only schema operations, runs each schema statement in the file, all semicolon separated |
| procedure | `apoc.cypher.runSchemaFiles`       | apoc.cypher.runSchemaFiles([files or urls],{statistics:true,timeout:10}) - allows only schema operations, runs each schema statement in the files, all semicolon separated |
| procedure | `apoc.cypher.runMany`              | apoc.cypher.runMany('cypher;\nstatements;',{params},[{statistics:true,timeout:10}]) - runs each semicolon separated statement and returns summary - currently no schema operations |
| procedure | `apoc.cypher.parallel`             |                                                              |
| procedure | `apoc.cypher.mapParallel`          | apoc.cypher.mapParallel(fragment, params, list-to-parallelize) yield value - executes fragment in parallel batches with the list segments being assigned to _ |
| procedure | `apoc.cypher.mapParallel2`         | apoc.cypher.mapParallel2(fragment, params, list-to-parallelize) yield value - executes fragment in parallel batches with the list segments being assigned to _ |
| procedure | `apoc.cypher.parallel2`            |                                                              |
| procedure | `apoc.cypher.doIt`                 | apoc.cypher.doIt(fragment, params) yield value - executes writing fragment with the given parameters |
| procedure | `apoc.when`                        | apoc.when(condition, ifQuery, elseQuery:'', params:{}) yield value - based on the conditional, executes read-only ifQuery or elseQuery with the given parameters |
| procedure | `apoc.do.when`                     | apoc.do.when(condition, ifQuery, elseQuery:'', params:{}) yield value - based on the conditional, executes writing ifQuery or elseQuery with the given parameters |
| procedure | `apoc.case`                        | apoc.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value - given a list of conditional / read-only query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |
| procedure | `apoc.do.case`                     | apoc.do.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value - given a list of conditional / writing query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |
| function  | `apoc.cypher.runFirstColumn`       | use either apoc.cypher.runFirstColumnMany for a list return or apoc.cypher.runFirstColumnSingle for returning the first row of the first column |
| function  | `apoc.cypher.runFirstColumnMany`   | apoc.cypher.runFirstColumnMany(statement, params) - executes statement with given parameters, returns first column only collected into a list, params are available as identifiers |
| function  | `apoc.cypher.runFirstColumnSingle` | apoc.cypher.runFirstColumnSingle(statement, params) - executes statement with given parameters, returns first element of the first column only, params are available as identifiers |

#### [Example: Fast Node-Counts by Label](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_fast_node_counts_by_label)

Counts by label are quickly provided by the counts-store, but only if they are the the single thing in the query, like

```cypher
MATCH (:Person) RETURN count(*);
```

It also works to combine several with `UNION ALL`, but not via `WITH`

Doesn’t work

```cypher
MATCH (:Person) WITH count(*) as people
MATCH (:Movie) RETURN people, count(*) as movies;
```

Works

```cypher
MATCH (:Person) RETURN count(*)
UNION ALL
MATCH (:Movie) RETURN count(*);
```

But with `apoc.cypher.run` we can construct the statement and run each of them individually, so it completes in a few ms.

```cypher
call db.labels() yield label
call apoc.cypher.run("match (:`"+label+"`) return count(*) as count", null) yield value
return label, value.count as count
```

You can use a similar approach to get the property-keys per label:

```cypher
CALL db.labels() yield label
call apoc.cypher.run("MATCH (n:`"+label+"`) RETURN keys(n) as keys LIMIT 1",null) yield value
RETURN label, value.keys as keys
```

#### [Running a cypher statement timeboxed](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#cypher-timeboxed)

There’s a way to terminate a cypher statement if it takes longer than a given threshold. Consider an expensive statement calculating cross product of shortestpaths for each pair of nodes:

```cypher
call apoc.cypher.runTimeboxed("match (n),(m) match p=shortestPath((n)-[*]-(m)) return p", null, 10000) yield value
return value.p
```

This will return all results being returned within 10000 milliseconds. The expensive statement will be terminated after that period.

#### [Run multiple Statements](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_run_multiple_statements)

This procedure runs each semicolon separated statement and returns summary - currently no schema operations.

```
apoc.cypher.runMany('cypher;\nstatements;',{params},[{statistics:true,timeout:10}])
```

#### [Run Cypher Script Files](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#run-cypher-scripts)

Runs each statement in the file / each file, all semicolon separated

You can use them with files that are usually run by cypher-shell or neo4j-shell, e.g. generated by `apoc.export.cypher.*`They automatically skip `:begin/:commit/:rollback` operations as they are executed in a single transaction per file.

Data Operations only:

- `apoc.cypher.runFile(file or url,[{config}])`
- `apoc.cypher.runFiles([files or urls],[{config})])`

Schema Operations only:

- `apoc.cypher.runSchemaFile(file or url,[{config}])`
- `apoc.cypher.runSchemaFiles([files or urls],[{config})])`

The `apoc.cypher.run*File(s)` procedures have some optional configuration:

- `{statistics:true/false}` to output a row of update-stats per statement, default is true
- `{timeout:1 or 10}` for how long the stream waits for new data, default is 10

##### [Conditional Cypher Execution](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#conditionals)

| `CALL apoc.when(condition, ifQuery, elseQuery:'', params:{}) yield value` | based on the conditional, executes read-only ifQuery or elseQuery with the given parameters |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.do.when(condition, ifQuery, elseQuery:'', params:{}) yield value` | based on the conditional, executes writing ifQuery or elseQuery with the given parameters |
| `CALL apoc.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value` | given a list of conditional / read-only query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |
| `CALL apoc.do.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value` | given a list of conditional / writing query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |

Sometimes queries require conditional execution logic that can’t be adequately expressed in Cypher, even with CASE.

APOC’s conditional execution procedures simulate an if / else structure, where a supplied boolean condition determines which cypher query is executed.

##### [WHEN Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_when_procedures)

| `CALL apoc.when(condition, ifQuery, elseQuery:'', params:{}) yield value` | based on the condition, executes read-only ifQuery or elseQuery with the given parameters |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.do.when(condition, ifQuery, elseQuery:'', params:{}) yield value` | based on the condition, executes writing ifQuery or elseQuery with the given parameters |

For example, if we wanted to match to neighbor nodes one and two traversals away from a start node, and return the smaller set (either those one hop away, or those that are two hops away), we might use:

```cypher
 MATCH (start:Node)-[:REL]->(a)-[:REL]->(b)
 WITH collect(distinct a) as aNodes, collect(distinct b) as bNodes
 CALL apoc.when(size(aNodes) <= size(bNodes), 'RETURN aNodes as resultNodes', 'RETURN bNodes as resultNodes', {aNodes:aNodes, bNodes:bNodes}) YIELD value
 RETURN value.resultNodes as resultNodes
```

Or, if we wanted to conditionally set or create graph elements if we deem some account to be suspicious, but still want to continue other query operations in either case, we could use `apoc.do.when`:

```cypher
MATCH (acc:Account)
OPTIONAL MATCH (acc)-[r:ACCESSED_BY]->(suspect:User)
WHERE suspect.id in {suspiciousUsersIdList}
CALL apoc.do.when(r IS NOT NULL, 'SET acc:Suspicious', '', {acc:acc}) YIELD value
// ignore value and continue
WITH acc
...
```

##### [CASE Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_case_procedures)

For more complex conditional logic, case procedures allow for a variable-length list of condition / query pairs, where the query following the first conditional evaluating to true is executed. An elseQuery block is executed if none of the conditionals are true.

| `CALL apoc.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value` | given a list of conditional / read-only query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.do.case([condition, query, condition, query, …], elseQuery:'', params:{}) yield value` | given a list of conditional / writing query pairs, executes the query associated with the first conditional evaluating to true (or the else query if none are true) with the given parameters |

If we wanted to MATCH to selection nodes in a column, we could use entirely different MATCHES depending on query parameters, or based on data already in the graph:

```cypher
 MATCH (me:User{id:{myId}})
 CALL apoc.case(
  [{selection} = 'friends', "RETURN [(me)-[:FRIENDS]-(friend) | friend] as selection",
   {selection} = 'coworkers', "RETURN [(me)-[:WORKS_AT*2]-(coworker) | coworker] as selection",
   {selection} = 'all', "RETURN apoc.coll.union([(me)-[:FRIENDS]-(friend) | friend], [(me)-[:WORKS_AT*2]-(coworker) | coworker]) as selection"],
   'RETURN [] as selection', {me:me}) YIELD value
 RETURN value.selection as selection
```

### [Job management and periodic execution](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#job-management)

#### [Introduction asynchronous transactional execution](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_introduction_asynchronous_transactional_execution)

Cypher is great for querying graphs and importing and updating graph structures. While during imports you can use `PERIODIC COMMIT` to control transaction sizes in memory, for other graph refactorings it’s not that easy to commit transactions regularly to free memory for new update state.

Also sometimes you want to schedule execution of Cypher statements to run regularly in the background or asynchronously ("fire & forget").

This can also be useful in cloud environments that limit the runtime of statements (e.g. to 2 or 5 minutes) by scheduling execution in the background.

The `apoc.periodic.*` procedures provide such capabilities.

<iframe width="560" height="315" src="https://www.youtube.com/embed/t1Nr5C5TAYs" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="box-sizing: border-box;"></iframe>

#### [Overview Job Management](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_overview_job_management)

| `CALL apoc.periodic.commit(statement, params)`               | repeats an batch update statement until it returns 0, this procedure is blocking |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.periodic.list()`                                  | list all jobs                                                |
| `CALL apoc.periodic.submit('name',statement)`                | submit a one-off background statement                        |
| `CALL apoc.periodic.schedule('name',statement,repeat-time-in-seconds)` | submit a repeatedly-called background statement              |
| `CALL apoc.periodic.countdown('name',statement,delay-in-seconds)` | submit a repeatedly-called background statement until it returns 0 |
| `CALL apoc.periodic.rock_n_roll(statementIteration, statementAction, batchSize) YIELD batches, total` | iterate over first statement and apply action statement with given transaction batch size. Returns to numeric values holding the number of batches and the number of total processed rows. E.g. |

- there are also static methods `Jobs.submit`, and `Jobs.schedule` to be used from other procedures
- jobs list is checked / cleared every 10s for finished jobs

copies over the `name` property of each person to `lastname`

```cypher
CALL apoc.periodic.rock_n_roll('match (p:Person) return id(p) as id_p', 'MATCH (p) where id(p)={id_p} SET p.lastname =p.name', 20000)
```

Many procedures run in the background or asynchronously. This setting overrides the default thread pool size (processors*2).

```
apoc.jobs.pool.num_threads=10
```

Many periodic procedures rely on a scheduled executor that has a pool of threads with a default fixed size (processors/4, at least 1). You can configure the pool size using the following configuration property:

```
apoc.jobs.scheduled.num_threads=10
```

### [apoc.periodic.iterate](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#commit-batching)

With `apoc.periodic.iterate` you provide 2 statements, the **first** outer statement is providing a stream of values to be processed. The **second**, inner statement processes **one** element at a time or with `iterateList:true` the whole batch at a time.

The results of the outer statement are passed into the inner statement as parameters, they are automatically made available with their names.

| param        | default | description                                                  |
| :----------- | :------ | :----------------------------------------------------------- |
| batchSize    | 1000    | that many inner statements are run within a single tx params: {_count, _batch} |
| parallel     | false   | run inner statement in parallel, note that statements might deadlock |
| retries      | 0       | if the inner statement fails with an error, sleep 100ms and retry until retries-count is reached, param {_retry} |
| iterateList  | false   | the inner statement is only executed once but the whole batchSize list is passed in as parameter {_batch} |
| params       | {}      | externally passed in map of params                           |
| concurrency  | 50      | How many concurrent tasks are generate when using `parallel:true` |
| failedParams | -1      | If set to a non-negative value, for each failed batch up to `failedParams`parameter sets are returned in in `yield failedParams`. |

|      | We plan to make `iterateList:true` the default in upcoming releases, due to the automatic UNWINDing and providing of nested results as variables, most queries should continue work. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

So if you were to add an `:Actor` label to several million `:Person` nodes, you would run:

```cypher
CALL apoc.periodic.iterate(
"MATCH (p:Person) WHERE (p)-[:ACTED_IN]->() RETURN p",
"SET p:Actor", {batchSize:10000, parallel:true})
```

Which would take 10k people from the stream and update them in a single transaction, executing the **second** statement for each person.

Those executions can happen in parallel as updating node-labels or properties doesn’t conflict.

If you do more complex operations like updating or removing relationships, either **don’t use parallel** OR make sure that you batch the work in a way that each subgraph of data is updated in one operation, e.g. by transferring the root objects. If you attempt complex operations, try to use e.g. `retries:3` to retry failed operations.

```cypher
CALL apoc.periodic.iterate(
"MATCH (o:Order) WHERE o.date > '2016-10-13' RETURN o",
"MATCH (o)-[:HAS_ITEM]->(i) WITH o, sum(i.value) as value SET o.value = value", {batchSize:100, parallel:true})
```

iterating over the whole batch (more efficient)

```cypher
CALL apoc.periodic.iterate(
"MATCH (o:Order) WHERE o.date > '2016-10-13' RETURN o",
"MATCH (o)-[:HAS_ITEM]->(i) WITH o, sum(i.value) as value SET o.value = value", {batchSize:100, iterateList:true, parallel:true})
```

The stream of other data can also come from another source, like a different database, CSV or JSON file.

### [apoc.periodic.commit](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#periodic-commit)

Especially for graph processing it is useful to run a query repeatedly in separate transactions until it doesn’t process and generates any results anymore. So you can iterate in batches over elements that don’t fulfill a condition and update them so that they do afterwards.

|      | as a safety net your statement used inside `apoc.periodic.commit` **must** contain a `LIMIT` clause. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

The query is executed repatedly in separate transactions until it returns 0.

```cypher
call apoc.periodic.commit("
match (user:User) WHERE exists( user.city )
with user limit {limit}
MERGE (city:City {name:user.city})
MERGE (user)-[:LIVES_IN]->(city)
REMOVE user.city
RETURN count(*)
",{limit:10000})
+=======+==========+
|updates|executions|
+=======+==========+
|2000000|200       |
+-------+----------+
```

### [apoc.periodic.countdown](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_apoc_periodic_countdown)

Repeats a statement until the termination is reached. The statement must return a numeric value and it should decrement (like a monotonically decreasing function). When the return value reaches 0 than the iteration stops. For example, define a counter with a numeric property:

```cypher
CREATE (counter:Counter) SET counter.c = 10
```

and decrement this property by 1 each second:

```cypher
CALL apoc.periodic.countdown('decrement',"MATCH (counter:Counter) SET counter.c = counter.c - 1 RETURN counter.c as count", 1)
```

### [Custom, Cypher Based Procedures and Functions](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#cypher-based-procedures-functions)

I wanted for a long time to be able to register Cypher statements as proper procedures and functions, so that they become callable in a standalone way.

You can achieve that with the `apoc.custom.asProcedure` and `apoc.custom.asFunction` procedure calls. Those register a given Cypher statement, prefixed with the `custom.*` namespace, overriding potentially existing ones, so you can redefine them as needed.

Here is a simple example:

```
CALL apoc.custom.asProcedure('answer','RETURN 42 as answer')
```

This registers the statement as procedure `custom.answer` that you then can call. As no information on parameter and return types is given, it just returns a stream of columns of maps called `row`.

```
CALL custom.answer YIELD row
RETURN row.answer
```

The same is possible as a function:

```
CALL apoc.custom.asFunction('answer','RETURN 42')
```

|      | If you override procedures or functions you might need to call `call dbms.clearQueryCaches()` as lookups to internal id’s are kept in compiled query plans. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Custom Procedures with `apoc.custom.asProcedure`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_custom_procedures_with_code_apoc_custom_asprocedure_code)

Given statement will be registered as a procedure, the results will be turned into a stream of records.

| name          | default                   | description                                                  |
| :------------ | :------------------------ | :----------------------------------------------------------- |
| `name`        | `none`                    | dot-separated name, will be prefixed with `custom`           |
| `statement`   | `none`                    | cypher statement to run, can use $parameters                 |
| `mode`        | `read`                    | execution mode of the procedure: read, write, or schema      |
| `outputs`     | `[["row","MAP"]]`         | List of pairs of name-type to be used as output columns, need to be in-order with the cypher statement, the default is a special case, that will collect all columns of the statement result into a map |
| `inputs`      | `[["params","MAP","{}"]]` | Pairs or triples of name-type-default, to be used as input parameters. The default just takes an optional map, otherwise they will become proper paramters in order |
| `description` | `""`                      | A general description about the business rules implemented into the procedure |

The type names are what you would expect and see in outputs of `dbms.procedures` or `apoc.help` just without the `?`. The default values are parsed as JSON.

Type Names

- FLOAT, DOUBLE, INT, INTEGER, NUMBER, LONG
- TEXT, STRING
- BOOL, BOOLEAN
- POINT, GEO, GEOCORDINATE
- DATE, DATETIME, LOCALDATETIME, TIME, LOCALTIME, DURATION
- NODE, REL, RELATIONSHIP, PATH
- MAP
- LIST TYPE, LIST OF TYPE
- ANY

Example Neighbours of a node by name

```cypher
CALL apoc.custom.asProcedure('neighbours',
  'MATCH (n:Person {name:$name})-->(nb) RETURN nb as neighbour','read',
  [['neighbour','NODE']],[['name','STRING'], 'get neighbours of a person']);

CALL custom.neighbours('Keanu Reeves') YIELD neighbour;
```

#### [Custom Functions with `apoc.custom.asFunction`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_custom_functions_with_code_apoc_custom_asfunction_code)

Given statement will be registered as a statement, the results into a single value. If the given output type is a list, results will be collected into a list, otherwise the first row will be used. The statement needs to return a single column, otherwise an error is thrown.

| name          | default                   | description                                                  |
| :------------ | :------------------------ | :----------------------------------------------------------- |
| `name`        | `none`                    | dot-separated name, will be prefixed with `custom`           |
| `statement`   | `none`                    | cypher statement to run, can use $parameters                 |
| `outputs`     | `"LIST OF MAP"`           | Output type for single output, if the type is a list, then all rows will be collected, otherwise just the first row. Only single column results are allowed. If your single row result is a list you can force a single row by setting the last parameter to `true` |
| `inputs`      | `[["params","MAP","{}"]]` | Pairs or triples of name-type-default, to be used as input parameters. The default just takes an optional map, otherwise they will become proper paramters in order |
| `singleRow`   | `false`                   | If set to true, the statement is treated as single row even with the list result type, then your statement has to return a list. |
| `description` | `""`                      | A general description about the business rules implemented into the function |

The type names are what you would expect and see in outputs of `dbms.procedures` or `apoc.help` just without the `?`. The default values are parsed as JSON.

#### [List of registered procedures/function with `apoc.custom.list`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_list_of_registered_procedures_function_with_code_apoc_custom_list_code)

The procedure `apoc.custom.list` provide a list of all registered procedures/function via `apoc.custom.asProcedure`and `apoc.custom.asFunction`

Given the this call:

```cypher
CALL apoc.custom.list
```

The the output will look like the following table:

| type        | name     | description                                                  | mode   | statement                 | inputs                 | outputs               | forceSingle |
| :---------- | :------- | :----------------------------------------------------------- | :----- | :------------------------ | :--------------------- | :-------------------- | :---------- |
| "function"  | "answer" | <null>                                                       | <null> | "RETURN $input as answer" | [["input","number"]]   | "long"                | false       |
| "procedure" | "answer" | "Procedure that answer to the Ultimate Question of Life, the Universe, and Everything" | "read" | "RETURN $input as answer" | [["input","int","42"]] | [["answer","number"]] | <null>      |

#### [How to manage procedure/function replication in a Causal Cluster](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_how_to_manage_procedure_function_replication_in_a_causal_cluster)

In order to replicate the procedure/function in a cluster environment you can tune the following parameters:

| name                             | type                   | description                                                  |
| :------------------------------- | :--------------------- | :----------------------------------------------------------- |
| `apoc.custom.procedures.refresh` | long (default `60000`) | the refresh time that allows replicating the procedure/function changes to each cluster member |

## [Virtual Nodes & Relationships (Graph Projections)](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#virtual)

Virtual Nodes and Relationships don’t exist in the graph, they are only returned to the UI/user for representing a graph projection. They can be visualized or processed otherwise. Please note that they have negative id’s.

### [Use Cases](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_use_cases)

Virtual nodes and relationships are used for quite a number of things.

You can create visual **representation of data that are not in the graph**, e.g. from other databases, that’s also what the `apoc.bolt.load` procedure supports.

Also the virtual nodes and relationships are used by `db.schema` and `apoc.meta.graph`

You can use it to **visually project data**, e.g. aggregate relationships into one, or collapse intermediate nodes into virtual relationships etc. For instance, you can project a citation graph into a virtual author-author or paper-paper graph with aggregated relationships between them. Or turn Twitter data into an user-user mention graph.

This is already automated in `apoc.nodes.group` which automatically groups nodes and relationships by grouping properties, [read more about that here](https://neo4j.com/blog/apoc-release-for-neo4j-3-4-with-graph-grouping/).

You can **combine** real and virtual entities, e.g. connecting two real nodes with a virtual relationship or connecting a virtual node via a virtual relationship to a real node.

APOC has already some means to also create "virtual graphs" which can also be used for export.

Some more uses of virtual entities:

- return only a few properties of nodes/rels to the visualization, e.g. of you have huge text properties
- visualize clusters found by graph algorithms
- aggregate information to a higher level of abstraction
- skip intermediate nodes in a longer path
- hide away properties or intermediate nodes/relationships for security reasons
- graph grouping
- visualization of data from other sources (computation, RDBMS, document-dbs, CSV, XML, JSON) as graph without even storing it
- projecting partial data

You can also create them yourself e.g. for projections.

One thing to keep in mind: as you cannot look up already created virtual nodes from the graph you have to keep them in your own lookup structure. Something that works well for it is `apoc.map.groupBy` which creates a map from a list of entities, keyed by the string value of a given property.

Virtual entities so far work across all surfaces, Neo4j-Browser, Bloom, neovis, and all the drivers, which is really cool, even if it was not originally intended.

They are mainly used for visualization but Cypher itself can’t access them (their ids, labels, types, properties) That’s why we added a number of functions to access their properties, labels, and rel-types.

In some future, they might be subsumed by graph views, the ability to return graphs and composable Cypher queries in Cypher 10.

|      | We also allow graph projections to be used [as inputs for graph algorithms](https://neo4j.com/docs/graph-algorithms/current/introduction/#cypher-projection), so you don’t actually have to change your data to run an algorithm on a different shape but you can just specify node- and relationship-lists with two Cypher statements. You can visualize (a subset of) those using virtual nodes and relationships too. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Virtual Nodes/Rels](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#virtual-nodes-rels)

Virtual Nodes and Relationships don’t exist in the graph, they are only returned to the UI/user for representing a graph projection. They can be visualized or processed otherwise. Please note that they have negative id’s.

#### [Function Overview](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_function_overview)

| `CALL apoc.create.vNode(['Label'], {key:value,…}) YIELD node` | returns a virtual node                  |
| ------------------------------------------------------------ | --------------------------------------- |
| `apoc.create.vNode(['Label'], {key:value,…})`                | function returns a virtual node         |
| `CALL apoc.create.vNodes(['Label'], [{key:value,…}])`        | returns virtual nodes                   |
| `CALL apoc.create.vRelationship(nodeFrom,'KNOWS',{key:value,…}, nodeTo) YIELD rel` | returns a virtual relationship          |
| `apoc.create.vRelationship(nodeFrom,'KNOWS',{key:value,…}, nodeTo)` | function returns a virtual relationship |
| `CALL apoc.create.vPattern({_labels:['LabelA'],key:value},'KNOWS',{key:value,…}, {_labels:['LabelB'],key:value})` | returns a virtual pattern               |
| `CALL apoc.create.vPatternFull(['LabelA'],{key:value},'KNOWS',{key:value,…},['LabelB'],{key:value})` | returns a virtual pattern               |

#### [Virtual Nodes/Rels Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_virtual_nodes_rels_example)

Simple example aggregate Relationships

```cypher
MATCH (from:Account)-[:SENT]->(p:Payment)-[:RECEIVED]->(to:Account)
RETURN from, to, apoc.create.vRelationship(from,'PAID',{amount:sum(p.amount)},to) as rel;
```

Example with virtual node lookups, people grouped by their countries

```cypher
MATCH (p:Person) WITH collect(distinct p.country) as countries
WITH [cName IN countries | apoc.create.vNode(['Country'],{name:cName})] as countryNodes
WITH apoc.coll.groupBy(countryNodes,'name') as countries
MATCH (p1:Person)-[:KNOWS]->(p2:Person)
WITH p1.country as cFrom, p2.country as cTo, count(*) as count, countries
RETURN countries[cFrom] as from, countries[cTo] as to, apoc.create.vRelationship(countries[cFrom],'KNOWS',{count:count},countries[cTo]) as rel;
```

That’s of course easier with `apoc.nodes.group`.

From a simple dataset

```cypher
CREATE(a:Person)-[r:ACTED_IN]->(b:Movie)
```

We can create a virtual copy, adding as attribute `name` the labels value

```cypher
MATCH (a)-[r]->(b)
WITH head(labels(a)) AS l, head(labels(b)) AS l2, type(r) AS rel_type, count(*) as count
CALL apoc.create.vNode([l],{name:l}) yield node as a
CALL apoc.create.vNode([l2],{name:l2}) yield node as b
CALL apoc.create.vRelationship(a,rel_type,{count:count},b) yield rel
RETURN *;
```

![apoc.create.vRelationshipAndvNode](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.create.vRelationshipAndvNode.png)

|      | Virtual nodes and virtual relationships have always a negative id |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

![vNodeId](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/vNodeId.png)

Virtual pattern `vPattern`

```cypher
CALL apoc.create.vPattern({_labels:['Person'],name:'Mary'},'KNOWS',{since:2012},{_labels:['Person'],name:'Michael'})
```

![apoc.create.vPattern](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.create.vPattern.png)

We can add more labels, just adding them on `_labels`

```cypher
CALL apoc.create.vPattern({_labels:['Person', 'Woman'],name:'Mary'},'KNOWS',{since:2012},{_labels:['Person', 'Man'],name:'Michael'})
```

![apoc.create.vPatternLabels](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.create.vPatternLabels.png)

Virtual pattern full `vPatternFull`

```cypher
CALL apoc.create.vPatternFull(['British','Person'],{name:'James', age:28},'KNOWS',{since:2009},['Swedish','Person'],{name:'Daniel', age:30})
```

![apoc.create.vPatternFull](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.create.vPatternFull.png)

We can create a virtual pattern from an existing one

```cypher
CREATE(a:Person {name:'Daniel'})-[r:KNOWS]->(b:Person {name:'John'})
```

From this dataset we can create a virtual pattern

```cypher
MATCH (a)-[r]->(b)
WITH head(labels(a)) AS labelA, head(labels(b)) AS labelB, type(r) AS rel_type, a.name AS aName, b.name AS bName
CALL apoc.create.vPatternFull([labelA],{name: aName},rel_type,{since:2009},[labelB],{name: bName}) yield from, rel, to
RETURN *;
```

![apoc.create.vPatternFullTwo](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.create.vPatternFullTwo.png)

### [Nodes collapse](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_nodes_collapse)

| `apoc.nodes.collapse([<node>], {config})` | returns the list of nodes merged into a VirtualNode |
| ----------------------------------------- | --------------------------------------------------- |
|                                           |                                                     |

##### [Config:](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_config_3)

On `apoc.nodes.collapse` with config properties you can choose from 3 different behavior:

- "properties": "overwrite" : if there is the same property in more node, in the new one will have the last relationship’s/node’s property value
- "properties": "discard" : if there is the same property in more node, the new one will have the first relationship’s/node’s property value
- "properties": "combine" : if there is the same property in more node, the new one a value’s array with all relationship’s/node’s values

If properties parameter isn’t set relationships properties are `discard`.

- "mergeVirtualRels: true/false" : give the possibility to merge relationships with same type and direction. (DEFAULT `true`)
- "selfRel: true/false" : give the possibility to create the self relationship. (DEFAULT `false`)
- "countMerge: true/false" : give the possibility count all the Nodes/Relationships merged. (DEFAULT `true`)
- "collapsedLabel: true/false" : give the possibility to add the label `:Collapsed` to the virtualNode. (DEFAULT `false`)

### [Nodes collapse example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_nodes_collapse_example)

With this dataset we have:

![apoc.nodes.collapse 1](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.nodes.collapse_1.png)

If we want to collapse the people living in the city to a single node, we pass them to the procedure.

```cypher
MATCH (p:Person)-[:LIVES_IN]->(c:City)
WITH c, collect(p) as subgraph
CALL apoc.nodes.collapse(subgraph,{properties:'combine'}) yield from, rel, to
return from, rel, to
```

And get this result:

![apoc.nodes.collapse 2](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.nodes.collapse_2.png)

With this dataset we have:

![apoc.nodes.collapse 3](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.nodes.collapse_3.png)

If we also want to collapse them onto the city itself, we add the city node *first* to the collection.

```cypher
MATCH (p:Person)-[:LIVES_IN]->(c:City)
WITH c, c + collect(p) as subgraph
CALL apoc.nodes.collapse(subgraph) yield from, rel, to
return from, rel, to
```

And get this result:

![apoc.nodes.collapse 4](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.nodes.collapse_4.png)

### [Virtual Graph](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#virtual-graph)

Create a graph object (map) from information that’s passed in. It’s basic structure is: `{name:"Name",properties:{properties},nodes:[nodes],relationships:[relationships]}`

| `apoc.graph.from(data,'name',{properties}) yield graph`      | creates a virtual graph object for later processing it tries its best to extract the graph information from the data you pass in |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.graph.fromData([nodes],[relationships],'name',{properties})` | creates a virtual graph object for later processing          |
| `apoc.graph.fromPaths(path,'name',{properties})`             | creates a virtual graph object for later processing          |
| `apoc.graph.fromPaths([paths],'name',{properties})`          | creates a virtual graph object for later processing          |
| `apoc.graph.fromDB('name',{properties})`                     | creates a virtual graph object for later processing          |
| `apoc.graph.fromCypher('statement',{params},'name',{properties})` | creates a virtual graph object for later processing          |
| `apoc.agg.graph(element) as graph`                           | aggregates graph elements to a "graph" map with unique sets of "nodes" and "relationships" |

Create a graph object (map) from information that’s passed in. It’s basic structure is: `{name:"Name",properties:{properties},nodes:[nodes],relationships:[relationships]}`

| `apoc.graph.from(data,'name',{properties}) yield graph`      | creates a virtual graph object for later processing it tries its best to extract the graph information from the data you pass in |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.graph.fromData([nodes],[relationships],'name',{properties})` | creates a virtual graph object for later processing          |
| `apoc.graph.fromPaths(path,'name',{properties})`             | creates a virtual graph object for later processing          |
| `apoc.graph.fromPaths([paths],'name',{properties})`          | creates a virtual graph object for later processing          |
| `apoc.graph.fromDB('name',{properties})`                     | creates a virtual graph object for later processing          |
| `apoc.graph.fromCypher('statement',{params},'name',{properties})` | creates a virtual graph object for later processing          |
| `apoc.graph.fromDocument({json},{config})`                   | transform JSON documents into graph structures               |
| `apoc.graph.validateDocument({json},{config})`               | validate the JSON and returns informations about required fields violations |

#### [`apoc.graph.fromDocument`](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_code_apoc_graph_fromdocument_code)

The procedure `apoc.graph.fromDocument` transforms a JSON into a graph structure. It takes two arguments:

- **json**, *type Object*: the JSON that must be transformed. Every entry must have an `id` and a `type` (name of Label), configurable via the config params.
  The value can be a String, or Cypher Map or List of Maps.
- **config**, *type Map*: the configuration params

Currently spatial and datetime properties are not handled yet. More advanced configuration for mapping the document is coming in future versions.

The config is composed by the following parameters:

- **write**, *type boolean*: persist the graph otherwise return a Virtual Graph, default **false**
- **labelField**, *type String*: the field name that became the label of the node, default **type**
- **idField**, *type String*: the document field name that will become the id field of the created nodes (used for node resolution when you create relationships between nodes), default **id**

```json
{
    "id": 1,
    "type": "artist",
    "name": "Genesis",
    "members": ["Tony Banks", "Mike Rutherford", "Phil Collins"],
    "years": [1967, 1998, 1999, 2000, 2006]
}
```

In this case it create one `Node` with labels **Artist**

It also accepts list of documents:

```json
[{
    "id": 1,
    "type": "artist",
    "name": "Genesis",
    "members": ["Tony Banks", "Mike Rutherford", "Phil Collins"],
    "years": [1967, 1998, 1999, 2000, 2006]
}, {
    "id": 2,
    "type": "artist",
    "name": "Daft Punk",
    "members": ["Guy-Manuel de Homem-Christo", "Thomas Bangalter."],
    "years": [1987, 1993, 1999, 2004, 2008, 2011]
}]
```

In this case it create 2 `Node` with labels **Artist**

JSON Tree to graph:

```json
{
	"id": 1,
	"type": "artist",
	"name": "Genesis",
	"albums": [{
		"type": "album",
		"id": 1,
		"producer": "Jonathan King",
		"title": "From Genesis to Revelation"
	}]
}
```

In this case it will create 2 `Node`, one **Artist** and one **Album** connected to each other by the **ALBUMS** `Relationship`

#### [Virtual Graph Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_virtual_graph_examples)

We create a dataset for our examples

```cypher
CREATE (a:Actor {name:'Tom Hanks'})-[r:ACTED_IN {roles:'Forrest'}]->(m:Movie {title:'Forrest Gump'}) RETURN *
```

Virtual graph from data

```cypher
MATCH (n)-[r]->(m) CALL apoc.graph.fromData([n,m],[r],'test',{answer:42}) YIELD graph RETURN *
```

Virtual graph from path

```cypher
MATCH path = (n)-[r]->(m) CALL apoc.graph.fromPath(path,'test',{answer:42}) YIELD graph RETURN *
```

Virtual graph from paths

```cypher
MATCH path = (n)-[r]->(m) CALL apoc.graph.fromPaths([path],'test',{answer:42}) YIELD graph RETURN *
```

Virtual graph from DB

```cypher
CALL apoc.graph.fromDB('test',{answer:42}) YIELD graph RETURN *
```

Virtual graph from Cypher

```cypher
CALL apoc.graph.fromCypher('MATCH (n)-[r]->(m) RETURN *',null,'test',{answer:42}) YIELD graph RETURN *
```

As a result we have a virtual graph object for later processing

![apoc.graph](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.graph.png)

Virtual graph from JSON

```cypher
CALL apoc.graph.fromDocument("{'id': 1,'type': 'artist','name':'Genesis','members': ['Tony Banks','Mike Rutherford','Phil Collins'],'years': [1967, 1998, 1999, 2000, 2006],'albums': [{'type': 'album','id': 1,'producer': 'Jonathan King','title': 'From Genesis to Revelation'}]}", false) yield graph return graph
```

As a result we have a virtual graph with two nodes and one relationship:

![apoc.graph](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.graph.fromDocument_1)

### [Graph Grouping](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#graph-grouping)

Large graphs are often hard to understand or visualize.

Tabular results can be aggregated for overviews, e.g. in charts with sums, counts etc.

Grouping nodes by property values into virtual nodes helps to do the same with graph visualizations.

When doing that, relationships between those groups are aggregated too, so you only see the summary information.

This functionality is inspired by the work of [Martin Junghanns](https://twitter.com/kc1s) in the [Grouping Demo](https://github.com/dbs-leipzig/gradoop_demo#graph-grouping) for the Gradoop Graph Processing system.

Basically you can use any `(entity)<-->(entity)` graph for the grouping, support for graph projections is on the roadmap.

Example on movie graph

```cypher
match (n) set n.century = toInteger(coalesce(n.born,n.relased)/100) * 100;

call apoc.nodes.group(['Person','Movie'],['century']);
```

![apoc.nodes.group](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.nodes.group.jpg)

|      | *Sometimes* an UI has an issue with the return values of the grouping (list of nodes and list of relationships), then it might help to run:`call apoc.nodes.group(['Person','Movie'],['century']) yield nodes, relationships UNWIND nodes as node UNWIND relationships as rel RETURN node, rel;` |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Usage](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_usage_4)

```cypher
call apoc.nodes.group(labels,properties, [grouping], [config])
```

The only required parameters are a *label-list* (can also be `['*']`) and a *list of property names* to group by (both for rels/nodes).

Optionally you can also provide grouping operators by field and a number of configuration options.

#### [Grouping Operators](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_grouping_operators)

For grouping operators, you provide a map of operations per field in this form: `{fieldName: [operators]}`

One map for nodes and one for relationships: `[{nodeOperators},{relOperators}]`

Possible operators:

- `count_*`
- `count`
- `sum`
- `min/max`
- `avg`
- `collect`

The default is: `[{*:count},{*:count}]` which just counts nodes and relationships.

#### [Configuration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_configuration_2)

In the config there are more options:

| option        | default | description                                                  |
| :------------ | :------ | :----------------------------------------------------------- |
| `selfRels`    | `true`  | show self-relationships in resulting graph                   |
| `orphans`     | `true`  | show orphan nodes in resulting graph                         |
| `limitNodes`  | `-1`    | limit to maximum of nodes                                    |
| `limitRels`   | `-1`    | limit to maximum of rels                                     |
| `relsPerNode` | ` -1`   | limit number of relationships per node                       |
| `filter`      | `null`  | a min/max filter by property value, e.g. `{User.count_*.min:2}` see below |

The `filter` config option is a map of `{Label/TYPE.operator_property.min/max: number}` where the `Label/TYPE.`prefix is optional.

So you can e.g. filter only for people with a min-age in the grouping of 21: `Person.min_age.min: 21` or having at most 10 `KNOWS` relationships in common: `KNOWS.count_*.max:10`.

#### [Example](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_example_5)

Graph Setup

```cypher
CREATE
 (alice:Person {name:'Alice', gender:'female', age:32, kids:1}),
 (bob:Person   {name:'Bob',   gender:'male',   age:42, kids:3}),
 (eve:Person   {name:'Eve',   gender:'female', age:28, kids:2}),
 (graphs:Forum {name:'Graphs',    members:23}),
 (dbs:Forum    {name:'Databases', members:42}),
 (alice)-[:KNOWS {since:2017}]->(bob),
 (eve)-[:KNOWS   {since:2018}]->(bob),
 (alice)-[:MEMBER_OF]->(graphs),
 (alice)-[:MEMBER_OF]->(dbs),
 (bob)-[:MEMBER_OF]->(dbs),
 (eve)-[:MEMBER_OF]->(graphs)
CALL apoc.nodes.group(['*'],['gender'],
  [{`*`:'count', age:'min'}, {`*`:'count'} ])
```

- image

```
CALL apoc.nodes.group(
        ['Person'],['gender'],
        [{`*`:'count', kids:'sum', age:['min', 'max', 'avg'], gender:'collect'},
         {`*`:'count', since:['min', 'max']}]);
```

Larger Example

Setup

```
with ["US","DE","UK","FR","CA","BR","SE"] as tld
unwind range(1,1000) as id
create (u:User {id:id, age : id % 100, female: rand() < 0.5, name: "Name "+id, country:tld[toInteger(rand()*size(tld))]})
with collect(u) as users
unwind users as u
unwind range(1,10) as r
with u, users[toInteger(rand()*size(users))] as u2
where u <> u2
merge (u)-[:KNOWS]-(u2);
call apoc.nodes.group(['*'], ['country'])
yield node, relationship return *
```

![grouping country all](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/grouping-country-all.jpg)

```
call apoc.nodes.group(['*'], ['country'], null,
    {selfRels:false, orphans:false,
     filter:{`User.count_*.min`:130,`KNOWS.count_*.max`:200}})
yield node, relationship return *
```

![grouping country filter](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/grouping-country-filter.jpg)

To visualize this result in Neo4j Browser it’s useful to have a custom Graph Style Sheet (GRASS) that renders the grouped properties with some of the aggregations.

```css
node {
  diameter: 50px;
  color: #A5ABB6;
  border-color: #9AA1AC;
  border-width: 2px;
  text-color-internal: #FFFFFF;
  font-size: 10px;
}

relationship {
  color: #A5ABB6;
  shaft-width: 3px;
  font-size: 8px;
  padding: 3px;
  text-color-external: #000000;
  text-color-internal: #FFFFFF;
  caption: '{count_*}';
}

node.Country {
  color: #68BDF6;
  diameter: 80px;
  border-color: #5CA8DB;
  text-color-internal: #FFFFFF;
  caption: '{country} ({count_*})';
}
```

## [Graph Refactoring](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#graph-refactoring)

| `call apoc.refactor.cloneNodes([node1,node2,…])`             | clone nodes with their labels and properties                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `call apoc.refactor.cloneNodesWithRelationships([node1,node2,…])` | clone nodes with their labels, properties and relationships  |
| `call apoc.refactor.cloneSubgraph([node1,node2,…], [rel1,rel2,…]=[], {standinNodes:[[oldNode1, standinNode1], …], skipProperties:[prop1, prop2, …]}={}) YIELD input, output, error` | clone nodes with their labels and properties (optionally skipping any properties in the skipProperties list via the config map), and clone the given relationships (will exist between cloned nodes only). If no relationships are provided, all relationships between the given nodes will be cloned. Relationships can be optionally redirected according to standinNodes node pairings (this is a list of list-pairs of nodes), so given a node in the original subgraph (first of the pair), an existing node (second of the pair) can act as a standin for it within the cloned subgraph. Cloned relationships will be redirected to the standin. |
| `call apoc.refactor.cloneSubgraphFromPaths([path1,path2,…], {standinNodes:[[oldNode1, standinNode1], …], skipProperties:[prop1, prop2, …]}={}) YIELD input, output, error` | from the subgraph formed from the given paths, clone nodes with their labels and properties (optionally skipping any properties in the skipProperties list via the config map), and clone the relationships (will exist between cloned nodes only). Relationships can be redirected according to optional standinNodes node pairings (this is a list of list-pairs of nodes), so given a node in the original subgraph (first of the pair), an existing node (second of the pair) can act as a standin for it within the cloned subgraph. Cloned relationships will be redirected to the standin. |
| `call apoc.refactor.mergeNodes([node1,node2])`               | merge nodes onto first in list                               |
| `call apoc.refactor.mergeRelationships([rel1,rel2,…],{config})` | merge relationships onto first in list                       |
| `call apoc.refactor.to(rel, endNode)`                        | redirect relationship to use new end-node                    |
| `call apoc.refactor.from(rel, startNode)`                    | redirect relationship to use new start-node                  |
| `call apoc.refactor.invert(rel)`                             | inverts relationship direction                               |
| `call apoc.refactor.setType(rel, 'NEW-TYPE')`                | change relationship-type                                     |
| `call apoc.refactor.extractNode([rel1,rel2,…], [labels], 'OUT','IN')` | extract node from relationships                              |
| `call apoc.refactor.collapseNode([node1,node2],'TYPE')`      | collapse nodes with 2 rels to relationship, node with one rel becomes self-relationship |
| `call apoc.refactor.normalizeAsBoolean(entity, propertyKey, true_values, false_values)` | normalize/convert a property to be boolean                   |
| `call apoc.refactor.categorize(node, propertyKey, type, outgoing, label)` | turn each unique propertyKey into a category node and connect to it |

On mergeRelationship and mergeNodes with config properties you can choose from 3 different management: * "overwrite" or "override": if there is the same property in more relationship, in the new one will have the last relationship’s property value * "discard" : if there is the same property in more relationship, the new one will have the first relationship’s property value * "combine" : if there is the same property in more relationship, the new one a value’s array with all relationships' values

On mergeNodes procedure there is also a config parameter to merge relationships of the merged nodes: * "mergeRels: true/false" : give the possibility to merge relationships with same type and direction.

If relationships have same start and end nodes will be merged into one, and properties managed by the properties config. If relationships have different start/end nodes (related to direction), relationships will be maintained and properties will be combine in all relationship.

### [Clone nodes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#clone-nodes)

We create a dataset

```cypher
CREATE (f:Foo{name:'Foo'}),(b:Bar{name:'Bar'})
```

As result we have two nodes

![apoc.refactor.cloneNodes.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.cloneNodes.dataset.png)

```cypher
MATCH (f:Foo{name:'Foo'}),(b:Bar{name:'Bar'}) WITH f,b
CALL apoc.refactor.cloneNodes([f,b]) yield input, output RETURN *
```

As result we have the two nodes that we have created before and their clones

![apoc.refactor.cloneNodes](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.cloneNodes.png)

Clone nodes with relationship

We create a dataset of two different nodes of type `Actor` connected with other two different node of type `Movie`

```cypher
CREATE (k:Actor {name:'Keanu Reeves'})-[:ACTED_IN {role:'Neo'}]->(m:Movie {title:'The Matrix'}),
	   (t:Actor {name:'Tom Hanks'})-[:ACTED_IN {role:'Forrest'}]->(f:Movie {title:'Forrest Gump'}) RETURN *
```

![apoc.refactor.cloneNodesWithRelationships.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.cloneNodesWithRelationships.dataset.png)

```cypher
MATCH (k:Actor {name:'Keanu Reeves'}), (t:Actor {name:'Tom Hanks'})
CALL apoc.refactor.cloneNodesWithRelationships([k,t]) YIELD input, output RETURN *
```

As result we have a copy of the nodes and relationships

![apoc.refactor.cloneNodesWithRelationships](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.cloneNodesWithRelationships.png)

### [Clone subgraph](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#clone-subgraph)

You can use the `cloneSubgraph()` and `cloneSubraphFromPaths()` to clone a subgraph defined either by a list of nodes and a list of relationships, or a list of paths. This is useful when you want to ensure the cloned subgraph isn’t connected to the original nodes, or to nodes outside the subgraph.

If relationships are not provided, then all relationships between the given nodes will be cloned.

In the config map, we can supply a `standinNodes` list (of pairs of nodes), allowing an existing node in the graph to act as a standin for another node in the cloned subgraph. This can be useful when you want to attach the cloned subgraph to another node in your graph (in place of cloning a node).

For example, when cloning a tree from one root to another.

Let’s create a dataset of two trees:

```cypher
CREATE  (rootA:Root{name:'A'}),
        (rootB:Root{name:'B'}),
        (n1:Node{name:'node1', id:1}),
        (n2:Node{name:'node2', id:2}),
        (n3:Node{name:'node3', id:3}),
        (n4:Node{name:'node4', id:4}),
        (n5:Node{name:'node5', id:5}),
        (n6:Node{name:'node6', id:6}),
        (n7:Node{name:'node7', id:7}),
        (n8:Node{name:'node8', id:8}),
        (n9:Node{name:'node9', id:9}),
        (n10:Node{name:'node10', id:10}),
        (n11:Node{name:'node11', id:11}),
        (n12:Node{name:'node12', id:12})
        CREATE (rootA)-[:LINK]->(n1)-[:LINK]->(n2)-[:LINK]->(n3)-[:LINK]->(n4)
        CREATE               (n1)-[:LINK]->(n5)-[:LINK]->(n6)<-[:LINK]-(n7)
        CREATE                             (n5)-[:LINK]->(n8)
        CREATE                             (n5)-[:LINK]->(n9)-[:DIFFERENT_LINK]->(n10)
        CREATE (rootB)-[:LINK]->(n11)
```

For our use case, we want to clone a subtree starting from rootA consisting only of outgoing :LINK relationships, and attach that subgraph to rootB. rootB becomes the standin for rootA (which is not cloned).

```cypher
MATCH  (rootA:Root{name:'A'}),
        (rootB:Root{name:'B'})
MATCH path = (rootA)-[:LINK*]->(node)
WITH rootA, rootB, collect(path) as paths
CALL apoc.refactor.cloneSubgraphFromPaths(paths, {standinNodes:[[rootA, rootB]]}) YIELD input, output, error
RETURN input, output, error
```

A subsequent MATCH to the entire graph will show the subgraph has been cloned and attached to rootB.

We can instead use `apoc.refactor.cloneSubgraph()`, providing the lists of nodes and relationships which form the subgraph. We can get the nodes and rels from the yielded output of `apoc.path.subgraphAll()`, and we can filter to the relationship types we want in the call.

After clearing and repopulating the tree graph, we can run:

```cypher
MATCH  (rootA:Root{name:'A'}),
        (rootB:Root{name:'B'})
CALL apoc.path.subgraphAll(rootA, {relationshipFilter:'LINK>'}) YIELD nodes, relationships
CALL apoc.refactor.cloneSubgraph(nodes, [rel in relationships WHERE type(rel) = 'LINK'], {standinNodes:[[rootA, rootB]]}) YIELD input, output, error
RETURN input, output, error
```

The resulting graph will be the same as our earlier `apoc.refactor.cloneSubgraphFromPaths()` call.

### [Merge Nodes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#merge-nodes)

You can merge a list of nodes onto the first one in the list.

All relationships are merged onto that node too. You can specify the merge behavior for properties globally and/or individually.

```cypher
---
MATCH (p:Person)
WITH p ORDER BY p.created DESC // newest one first
WITH p.email, collect(p) as nodes
CALL apoc.refactor.mergeNodes(nodes, {properties: {name:'discard', age:'overwrite', kids:'combine', `addr.*`, 'overwrite',`.*`: 'discard'}}) YIELD node
RETURN node
---
```

This config option also works for `apoc.refactor.mergeRelationships([rels],{config})`.

| type                 | operations                                                   |
| :------------------- | :----------------------------------------------------------- |
| discard              | the first nodes' property will remain if already set, otherwise the first property in list will be written |
| overwrite / override | last property in list wins                                   |
| combine              | if there is only one property in list, it will be set / kept as single property otherwise create an array, tries to coerce values |

For mergeNodes you can Merge relationships with same type and direction, you can spacify this with property mergeRels. Relationships properties are managed with the same nodes' method, if properties parameter isn’t set relationships properties are combined.

example1 - Relationships with same start and end nodes

First of all we have to create nodes and relationships

```cypher
Create (n1:Person {name:'Tom'}),
(n2:Person {name:'John'}),
(n3:Company {name:'Company1'}),
(n5:Car {brand:'Ferrari'}),
(n6:Animal:Cat {name:'Derby'}),
(n7:City {name:'London'}),
(n1)-[:WORKS_FOR{since:2015}]->(n3),
(n2)-[:WORKS_FOR{since:2018}]->(n3),
(n3)-[:HAS_HQ{since:2004}]->(n7),
(n1)-[:DRIVE{since:2017}]->(n5),
(n2)-[:HAS{since:2013}]->(n6)
return *;
```

![apoc.refactor.mergeNodes.createDataSetFirstExample](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.mergeNodes.createDataSetFirstExample.png)

Next step is calling the apoc to merge nodes :Person

```cypher
MATCH (a1:Person{name:'John'}), (a2:Person {name:'Tom'})
WITH head(collect([a1,a2])) as nodes
CALL apoc.refactor.mergeNodes(nodes,{properties:"combine", mergeRels:true}) yield node
MATCH (n)-[r:WORKS_FOR]->(c) return *
```

and the result is:

![apoc.refactor.mergeNodes.resultFirstExample](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.mergeNodes.resultFirstExample.png)

In this case we have relationships with same start and end nodes so relationships are merged into one and properties are combined.

Relationships with different start or end nodes

```cypher
Create (n1:Person {name:'Tom'}),
(n2:Person {name:'John'}),
(n3:Company {name:'Company1'}),
(n4:Company {name:'Company2'}),
(n5:Car {brand:'Ferrari'}),
(n6:Animal:Cat {name:'Derby'}),
(n7:City {name:'London'}),
(n8:City {name:'Liverpool'}),
(n1)-[:WORKS_FOR{since:2015}]->(n3),
(n2)-[:WORKS_FOR{since:2018}]->(n4),
(n3)-[:HAS_HQ{since:2004}]->(n7),
(n4)-[:HAS_HQ{since:2007}]->(n8),
(n1)-[:DRIVE{since:2017}]->(n5),
(n2)-[:HAS{since:2013}]->(n6)
return *;
```

![apoc.refactor.mergeNodes.createDataSetSecondExample](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.mergeNodes.createDataSetSecondExample.png)

Next step is calling the apoc to merge nodes :Person

```cypher
MATCH (a1:Person{name:'John'}), (a2:Person {name:'Tom'})
WITH head(collect([a1,a2])) as nodes
CALL apoc.refactor.mergeNodes(nodes,{properties:"combine", mergeRels:true}) yield node
MATCH (n)-[r:WORKS_FOR]->(c) return n.name,r.since,c.name;
```

and the result is:

![apoc.refactor.mergeNodes.resultSecondExample](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.mergeNodes.resultSecondExample.png)

![apoc.refactor.mergeNodes.resultSecondExampleData](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.mergeNodes.resultSecondExampleData.png)

In this case we have relationships with different end nodes so all relationships are maintained and properties are combined into all relationships.

```cypher
MATCH (p:Person)
WITH p ORDER BY p.created DESC // newest one first
WITH p.email, collect(p) as nodes
CALL apoc.refactor.mergeNodes(nodes, {properties:'combine', mergeRels: true}) YIELD node
RETURN node
```

### [Redirect relationships](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#redirect-relationship)

#### [Redirect Source Node](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_redirect_source_node)

We start with two nodes related each other with a relationship. We create a new node which we will use to redirect the relationship like end node

```cypher
CREATE (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar)
CREATE (p:Person {name:'Antony'})
RETURN *
```

![apoc.refactor.to.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.to.dataset.png)

```cypher
MATCH (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar) with id(rel) as id
MATCH (p:Person {name:'Antony'}) with p as p
MATCH ()-[r]->(), (p:Person)  CALL apoc.refactor.to(r, p) YIELD input, output RETURN *
```

![apoc.refactor.to](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.to.png)

Now the relationship is towards the new node `Person`

#### [Redirect Target Node](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_redirect_target_node)

We start with two nodes related each other with a relationship. We create a new node which we will use to redirect the relationship like start node

```cypher
CREATE (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar)
CREATE (p:Person {name:'Antony'})
RETURN *
```

![apoc.refactor.from.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.from.dataset.png)

```cypher
MATCH (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar) with id(rel) as id
MATCH (p:Person {name:'Antony'}) with p as p
MATCH ()-[r]->(), (p:Person)  CALL apoc.refactor.from(r, p) YIELD input, output RETURN *
```

![apoc.refactor.from](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.from.png)

Now the relationship starts from the new node `Person` from the old node `Bar`

### [Invert relationship](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#invert-relationship)

We start with two nodes connected by a relationship

```cypher
CREATE (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar)
```

![apoc.refactor.invert.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.invert.dataset.png)

Now we want to invert the relationship direction

```cypher
MATCH (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar) WITH id(rel) as id
MATCH ()-[r]->() WHERE id(r) = id
CALL apoc.refactor.invert(r) yield input, output RETURN *
```

![apoc.refactor.invert.call](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.invert.call.png)

![apoc.refactor.invert](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.invert.png)

### [Set Relationship Tsype](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#set-relationship-type)

With a simple relationship between two node

```cypher
CREATE (f:Foo)-[rel:FOOBAR]->(b:Bar)
```

![apoc.refactor.setType.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.setType.dataset.png)

We can change the relationship type from `FOOBAR` to `NEW-TYPE`

```cypher
MATCH (f:Foo)-[rel:FOOBAR]->(b:Bar) with rel
CALL apoc.refactor.setType(rel, 'NEW-TYPE') YIELD input, output RETURN *
```

![apoc.refactor.setType](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.setType.png)

### [Extract node from relationships](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#extract-node-from-relationship)

```cypher
CREATE (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar)
```

![apoc.refactor.extractNode.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.extractNode.dataset.png)

We pass the ID of the relationship as parameter to extract a node

```cypher
MATCH (f:Foo)-[rel:FOOBAR {a:1}]->(b:Bar) WITH id(rel) as id
CALL apoc.refactor.extractNode(id,['FooBar'],'FOO','BAR')
YIELD input, output RETURN *
```

![apoc.refactor.extractNode](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.extractNode.png)

### [Collapse node to relationship](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#collapse-node-to-relationship)

```cypher
CREATE (f:Foo)-[:FOO {a:1}]->(b:Bar {c:3})-[:BAR {b:2}]->(f) WITH id(b) as id
CALL apoc.refactor.collapseNode(id,'FOOBAR')
YIELD input, output RETURN *
```

Before we have this situation

![apoc.refactor.collapseNode.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.collapseNode.dataset.png)

And the result are

![apoc.refactor.collapseNode](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.collapseNode.png)

The property of the two relationship and the property of the node are joined in one relationship that has the properties `a:1`, `b:2`, `name:Bar`

### [Normalize As Boolean](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_normalize_as_boolean)

```cypher
CREATE (:Person {prop: 'Y', name:'A'}),(:Person {prop: 'Yes', name:'B'}),(:Person {prop: 'NO', name:'C'}),(:Person {prop: 'X', name:'D'})
```

As a resul we have four nodes with different properties `prop` like `Y`, `Yes`, `NO`, `X`

![apoc.refactor.normalizeAsBoolean.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.normalizeAsBoolean.dataset.png)

Now we want to transform some properties into a boolean, `Y`, `Yes` into true and the properties `NO` into false. The other properties that don’t match these possibilities will be set as `null`.

```cypher
MATCH (n)  CALL apoc.refactor.normalizeAsBoolean(n,'prop',['Y','Yes'],['NO']) WITH n ORDER BY n.id RETURN n.prop AS prop
```

![apoc.refactor.normalizeAsBoolean](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.refactor.normalizeAsBoolean.png)

### [Categorize](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#categorize)

Categorize replaces string property values on nodes with relationship to a unique category node for that property value.

This example will turn all n.color properties into :HAS_ATTRIBUTE relationships to :Color nodes with a matching .colour property.

```cypher
CALL apoc.refactor.categorize('color','HAS_ATTRIBUTE',true,'Color','colour',['popularity'],1)
```

Additionally, it will also copy over the first 'popularity' property value encountered on any node n for each newly created :Color node and remove any occurrences of that property value on nodes with the same 'Color'.

### [Using Cypher and APOC to move a property value to a label](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_cypher_and_apoc_to_move_a_property_value_to_a_label)

You can use the procedure `apoc.create.addLabels` to move a property to a label with Cypher as follows

Create a node with property studio

```cypher
CREATE (:Movie {title: 'A Few Good Men', genre: 'Drama'})
```

Move the 'genre' property to a label and remove it as a property

```cypher
MATCH (n:Movie)
CALL apoc.create.addLabels( id(n), [ n.genre ] ) YIELD node
REMOVE node.genre
RETURN node
```

### [Rename](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#rename-label-type-property)

Procedures set for renaming labels, relationship types, nodes and relationships' properties. They return the list of eventually impacted constraints and indexes, the user should take care of.

| `call apoc.refactor.rename.label(oldLabel, newLabel, [nodes])` | rename a label from 'oldLabel' to 'newLabel' for all nodes. If 'nodes' is provided renaming is applied to this set only |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `call apoc.refactor.rename.type(oldType, newType, [rels])`   | rename all relationships with type 'oldType' to 'newType'. If 'rels' is provided renaming is applied to this set only |
| `call apoc.refactor.rename.nodeProperty(oldName, newName, [nodes])` | rename all node’s property from 'oldName' to 'newName'. If 'nodes' is provided renaming is applied to this set only |
| `call apoc.refactor.rename.typeProperty(oldName, newName, [rels])` | rename all relationship’s property from 'oldName' to 'newName'. If 'rels' is provided renaming is applied to this set only |

## [Operational](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#operational)

#### [Time To Live (TTL) - Expire Nodes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_time_to_live_ttl_expire_nodes)

Some nodes are not meant to live forever. That’s why with APOC you can specify a time by when they are removed from the database, by utilizing a schema index and an additional label. A few convenience procedures help with that.

<iframe width="560" height="315" src="https://www.youtube.com/embed/e9aoQ9xOmoU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" style="box-sizing: border-box;"></iframe>

Enable TTL with setting in `neo4j.conf` : `apoc.ttl.enabled=true`

There are some convenience procedures to expire nodes.

You can also do it yourself by running

```cypher
SET n:TTL
SET n.ttl = timestamp() + 3600
```

| `CALL apoc.date.expire.in(node,time,'time-unit')` | expire node in given time-delta by setting :TTL label and `ttl` property |
| ------------------------------------------------- | ------------------------------------------------------------ |
| `CALL apoc.date.expire(node,time,'time-unit')`    | expire node at given time by setting :TTL label and `ttl` property |

Optionally set `apoc.ttl.schedule=5` as repeat frequency.

##### [Process](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_process)

30s after startup an index is created:

```cypher
CREATE INDEX ON :TTL(ttl)
```

At startup a statement is scheduled to run every 60s (or configure in `neo4j.conf` - `apoc.ttl.schedule=120`)

```cypher
MATCH (t:TTL) where t.ttl < timestamp() WITH t LIMIT 1000 DETACH DELETE t
```

The `ttl` property holds the **time when the node is expired in milliseconds since epoch**.

You can expire your nodes by setting the :TTL label and the ttl property:

```cypher
MATCH (n:Foo) WHERE n.bar SET n:TTL, n.ttl = timestamp() + 10000;
```

There is also a procedure that does the same:

```cypher
CALL apoc.date.expire(node,time,'time-unit');
CALL apoc.date.expire(n,100,'s');
```

### [Triggers](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#triggers)

#### [Triggers](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_triggers)

In a trigger you register Cypher statements that are called when data in Neo4j is changed (created, updated, deleted). You can run them before or after commit.

Enable `apoc.trigger.enabled=true` in `$NEO4J_HOME/config/neo4j.conf` first.

| `CALL apoc.trigger.add(name, statement, selector) yield name, statement, installed` | add a trigger statement under a name, in the statement you can use {createdNodes}, {deletedNodes} etc., the selector is {phase:'before/after/rollback'} returns previous and new trigger information |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.trigger.remove(name) yield name, statement, installed` | remove previously added trigger, returns trigger information |
| `CALL apoc.trigger.removeAll() yield name, statement, installed` | removes all previously added triggers , returns trigger information |
| `CALL apoc.trigger.list() yield name, statement, installed`  | update and list all installed triggers                       |
| `CALL apoc.trigger.pause(name)`                              | it pauses the trigger                                        |
| `CALL apoc.trigger.resume(name)`                             | it resumes the paused trigger                                |

The transaction data from Neo4j is turned into appropriate data structures to be consumed as parameters to your statement.

The parameters available are:

| Statement                      | Description                                                  |
| :----------------------------- | :----------------------------------------------------------- |
| transactionId                  | returns the id of the transaction                            |
| commitTime                     | return the date of the transaction in milliseconds           |
| createdNodes                   | when a node is created our trigger fires (list of nodes)     |
| createdRelationships           | when a relationship is created our trigger fires (list of relationships) |
| deletedNodes                   | when a node is delated our trigger fires (list of nodes)     |
| deletedRelationships           | when a relationship is delated our trigger fires (list of relationships) |
| removedLabels                  | when a label is removed our trigger fires (map of label to list of nodes) |
| removedNodeProperties          | when a properties of node is removed our trigger fires (map of key to list of map of key,old,node) |
| removedRelationshipProperties  | when a properties of relationship is removed our trigger fires (map of key to list of map of key,old,relationship) |
| assignedLabels                 | when a labes is assigned our trigger fires (map of label to list of nodes) |
| assignedNodeProperties         | when node property is assigned our trigger fires (map of key to list of map of key,old,new,node) |
| assignedRelationshipProperties | when relationship property is assigned our trigger fires (map of key to list of map of key,old,new,relationship) |

You can use these helper functions to extract nodes or relationships by label/relationship-type or updated property key.

| `apoc.trigger.nodesByLabel({assignedLabels/assignedNodeProperties},'Label')` | function to filter labelEntries by label, to be used within a trigger statement with {assignedLabels} and {removedLabels} {phase:'before/after/rollback'} returns previous and new trigger information |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.trigger.propertiesByKey({assignedNodeProperties},'key')` | function to filter propertyEntries by property-key, to be used within a trigger statement with {assignedNode/RelationshipProperties} and {removedNode/RelationshipProperties}. Returns [{old,[new],key,node,relationship}] |

##### [Triggers Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_triggers_examples)

Set properties connected to a node

We could add a trigger that when is added a specific property on a node, that property is added to all the nodes connected to this node

Dataset

```cypher
CREATE (d:Person {name:'Daniel'})
CREATE (l:Person {name:'Mary'})
CREATE (t:Person {name:'Tom'})
CREATE (j:Person {name:'John'})
CREATE (m:Person {name:'Michael'})
CREATE (a:Person {name:'Anne'})
CREATE (l)-[:DAUGHTER_OF]->(d)
CREATE (t)-[:SON_OF]->(d)
CREATE (t)-[:BROTHER]->(j)
CREATE (a)-[:WIFE_OF]->(d)
CREATE (d)-[:SON_OF]->(m)
CREATE (j)-[:SON_OF]->(d)
```

![apoc.trigger.add.setAllConnectedNodes.dataset](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.add.setAllConnectedNodes.dataset.png)

Now we add the trigger using `apoc.trigger.propertiesByKey` on the `surname` property

```cypher
CALL apoc.trigger.add('setAllConnectedNodes','UNWIND apoc.trigger.propertiesByKey({assignedNodeProperties},"surname") as prop
WITH prop.node as n
MATCH(n)-[]-(a)
SET a.surname = n.surname', {phase:'after'});
```

So when we add the `surname` property on a node, it’s added to all the nodes connected (in this case one level deep)

```cypher
MATCH (d:Person {name:'Daniel'})
SET d.surname = 'William'
```

![apoc.trigger.add.setAllConnectedNodes](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.add.setAllConnectedNodes.png)

The `surname` property is add/change on all related nodes

Update labels

Dataset

```cypher
CREATE (k:Actor {name:'Keanu Reeves'})
CREATE (l:Actor {name:'Laurence Fishburne'})
CREATE (c:Actor {name:'Carrie-Anne Moss'})
CREATE (m:Movie {title:'Matrix'})
CREATE (k)-[:ACT_IN]->(m)
CREATE (l)-[:ACT_IN]->(m)
CREATE (c)-[:ACT_IN]->(m)
```

![apoc.trigger.add.setLabels](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.add.setLabels.png)

We add a trigger using `apoc.trigger.nodesByLabel` that when the label `Actor` of a node is removed, update all labels `Actor` with `Person`

```cypher
CALL apoc.trigger.add('updateLabels',"UNWIND apoc.trigger.nodesByLabel({removedLabels},'Actor') AS node
MATCH (n:Actor)
REMOVE n:Actor SET n:Person SET node:Person", {phase:'before'})
MATCH(k:Actor {name:'Keanu Reeves'})
REMOVE k:Actor
```

![apoc.trigger.add.setLabelsResult](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.add.setLabelsResult.png)

Create relationship on a new node

We can add a trigger that connect every new node with label `Actor` and as `name` property a specific value

```cypher
CALL apoc.trigger.add('create-rel-new-node',"UNWIND {createdNodes} AS n
MATCH (m:Movie {title:'Matrix'})
WHERE n:Actor AND n.name IN ['Keanu Reeves','Laurence Fishburne','Carrie-Anne Moss']
CREATE (n)-[:ACT_IN]->(m)", {phase:'before'})
CREATE (k:Actor {name:'Keanu Reeves'})
CREATE (l:Actor {name:'Laurence Fishburne'})
CREATE (c:Actor {name:'Carrie-Anne Moss'})
CREATE (a:Actor {name:'Tom Hanks'})
CREATE (m:Movie {title:'Matrix'})
```

![apoc.trigger.add.create rel new node](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.add.create-rel-new-node.png)

Pause trigger

We have the possibility to pause a trigger without remove it, if we will need it in the future

![apoc.trigger.pause](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.pause.png)

Resume paused trigger

When you need again of a trigger paused

![apoc.trigger.resume](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.trigger.resume.png)

Enforcing property type

For this example, we would like that all the `reference` node properties are of type `STRING`

```cypher
CALL apoc.trigger.add("forceStringType",
"UNWIND apoc.trigger.propertiesByKey({assignedNodeProperties}, 'reference') AS prop
CALL apoc.util.validate(apoc.meta.type(prop) <> 'STRING', 'expected string property type, got %s', [apoc.meta.type(prop)]) RETURN null", {phase:'before'})
CREATE (a:Node) SET a.reference = 1

Neo.ClientError.Transaction.TransactionHookFailed
```

Other examples

```cypher
CALL apoc.trigger.add('timestamp','UNWIND {createdNodes} AS n SET n.ts = timestamp()');
CALL apoc.trigger.add('lowercase','UNWIND {createdNodes} AS n SET n.id = toLower(n.name)');
CALL apoc.trigger.add('txInfo',   'UNWIND {createdNodes} AS n SET n.txId = {transactionId}, n.txTime = {commitTime}', {phase:'after'});
CALL apoc.trigger.add('count-removed-rels','MATCH (c:Counter) SET c.count = c.count + size([r IN {deletedRelationships} WHERE type(r) = "X"])')
CALL apoc.trigger.add('lowercase-by-label','UNWIND apoc.trigger.nodesByLabel({assignedLabels},'Person') AS n SET n.id = toLower(n.name)')
```

### [Cypher init script](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#init-script)

Apoc optionally allows you to run a cypher command after database initialization is finished. This can e.g. be used to ensure indexes/constraints are created up front.

To use this feature use a config option:

```config
apoc.initializer.cypher=CALL apoc.cypher.runSchemaFile("file:///indexes.cypher")
```

For running multiple statements you can also add suffixes to the config options, like `cypher.1`, `cypher.2`. The statements will then be executed in sort-order.

### [Config](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#neo4j-config)

| `apoc.config.list` | Lists the Neo4j configuration as key,value table |
| ------------------ | ------------------------------------------------ |
| `apoc.config.map`  | Lists the Neo4j configuration as map             |

### [Warmup](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#warmup)

| `CALL apoc.warmup.run([loadProperties],[loadDynamicProperties],[loadIndexes])` | Quickly warm up the page-caches by touching pages in paralle optionally load property-records, dynamic-properties, indexes |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

### [Monitoring](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#monitoring)

| `apoc.monitor.ids`                     | node and relationships-ids in total and in use               |
| -------------------------------------- | ------------------------------------------------------------ |
| `apoc.monitor.kernel`                  | store information such as kernel version, start time, read-only, database-name, store-log-version etc. |
| `apoc.monitor.store`                   | store size information for the different types of stores     |
| `apoc.monitor.tx`                      | number of transactions total,opened,committed,concurrent,rolled-back,last-tx-id |
| `apoc.monitor.locks(minWaitTime long)` | db locking information such as avertedDeadLocks, lockCount, contendedLockCount and contendedLocks etc. (enterprise) |

#### [UUID](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_uuid)

These procedures manage the UUID Handler Lifecycle. The UUID handler is a transaction event handler that automatically adds the UUID property to a provided label and for the provided property name. Please check the following documentation to an in-depth description.

Enable `apoc.uuid.enabled=true` in `$NEO4J_HOME/config/neo4j.conf` first.

| `**procedure**`                                              | **description**                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `CALL apoc.uuid.install(label, {addToExistingNodes: true/false, uuidProperty: 'uuid'}) yield label, installed, properties, batchComputationResult` | it will add the uuid transaction handler for the provided `label` and `uuidProperty`, in case the UUID handler is already present it will be replaced by the new one |
| `CALL apoc.uuid.remove(label) yield label, installed, properties` | remove previously added uuid handler and returns uuid information. All the existing uuid properties are left as-is |
| `CALL apoc.uuid.removeAll() yield label, installed, properties` | removes all previously added uuid handlers and returns uuids information. All the existing uuid properties are left as-is |
| `CALL apoc.uuid.list() yield label, installed, properties`   | provides a list of all the uuid handlers installed with the related configuration |

###### [Config](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_config_4)

| **config**         | **type**                | **description**                                              |
| ------------------ | ----------------------- | ------------------------------------------------------------ |
| addToExistingNodes | Boolean (default: true) | when installed, for the label provided, adds the UUID to the nodes already existing in your graph |
| uuidProperty       | String (default: uuid)  | the name of the UUID field                                   |

##### [UUID Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_uuid_examples)

First create a Constraint for the Label and the Property, if you try to add a `uuid` an error occured.

```cypher
CREATE CONSTRAINT ON (person:Person) ASSERT person.uuid IS UNIQUE
```

Add the `uuid`:

```cypher
CALL apoc.uuid.install('Person') YIELD label RETURN label
```

The result is:

```
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| label    | installed | properties                                               | batchComputationResult                                                                                                                         |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| "Person" | true      | {uuidProperty -> "uuid", addToExistingNodes -> true} | {wasTerminated -> false, count -> 10, batches -> 1, successes -> 1, failedOps -> 0, timeTaken -> 0, operationErrors -> {}, failedBatches -> 0} |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

The result is Node Person have 2 property:

![apoc.uuid.result](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.uuid.result.png)

Get all the uuid installed, call the procedure as:

```cypher
call apoc.uuid.list() yield label, installed return label, installed
```

The result is:

```
+---------------------------------------------------------------------------------+
| label    | installed | properties                                               |
+---------------------------------------------------------------------------------+
| "Person" | true      | {uuidProperty -> "uuid", addToExistingNodes -> true} |
+---------------------------------------------------------------------------------+
```

Remove the uuid installed call the procedure as:

```cypher
call apoc.uuid.remove('Person') yield label return label
```

The result is:

```
+---------------------------------------------------------------------------------+
| label    | installed | properties                                               |
+---------------------------------------------------------------------------------+
| "Person" | false     | {uuidProperty -> "uuid", addToExistingNodes -> true} |
+---------------------------------------------------------------------------------+
1 row
```

You can also remove all the uuid installed call the procedure as:

```cypher
call apoc.uuid.removeAll() yield label return label
```

The result is:

```
+---------------------------------------------------------------------------------+
| label    | installed | properties                                               |
+---------------------------------------------------------------------------------+
| "Person" | false     | {uuidProperty -> "uuid", addToExistingNodes -> true} |
+---------------------------------------------------------------------------------+
```

## [Text and Lookup Indexes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#indexes)

### [Schema Index Procedures](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#schema-index-operations)

| `apoc.schema.assert({indexLabel:[indexKeys],…},{constraintLabel:[constraintKeys],…}, dropExisting : true) yield label, key, unique, action` | drops all other existing indexes and constraints when `dropExisting` is `true` (default is `true`), and asserts that at the end of the operation the given indexes and unique constraints are there, each label:key pair is considered one constraint/label. |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.schema.nodes([config]) yield name, label, properties, status, type` | get all indexes and constraints information for all the node labels in your database, in optional config param could be define a set of labels to include or exclude |
| `apoc.schema.relationships([config]) yield name, type, properties, status` | return all the constraint information for all the relationship types in your database, in optional config param could be define a set of types to include or exclude |
| `apoc.schema.node.constraintExists(labelName, properties)`   | return the constraints existence on node                     |
| `apoc.schema.relationship.constraintExists(type, properties)` | return the constraints existence on relationship             |

##### [Schema Information](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_schema_information)

To drop or create index or constraint, you can use the following procedure:

```cypher
CALL apoc.schema.assert({indexLabel:[[indexKeys]], ...}, {constraintLabel:[constraintKeys], ...}, dropExisting : true) yield label, key, keys, unique, action
```

Where the outputs are:

- label
- key
- keys, list of the key
- unique, if the index or constraint are unique
- action, can be the following values: DROPPED, CREATED

To retrieve indexes and constraints information for all the node labels in your database, you can use the following procedure:

```cypher
CALL apoc.schema.nodes() yield name, label, properties, status, type
```

Where the outputs are:

- name of the index/constraint,
- label
- properties, (for Neo4j 3.1 and lower versions is a single element array) that are affected by the constraint
- status, for index can be one of the following values: ONLINE, POPULATING and FAILED
- type, always "INDEX" for indexes, constraint type for constraints
- failure, the failure description of a failed index
- populationProgress, the population progress of the index in percentage
- size, the size of the index
- valuesSelectivity, computes the selectivity of the unique values
- userDescription, a user friendly description of what this index indexes

To retrieve the constraint information for all the relationship types in your database, you can use the following procedure:

```cypher
CALL apoc.schema.relationships() yield name, type, properties, status
```

Where the outputs are:

- name of the constraint
- type of the relationship
- properties, (for Neo4j 3.1 and lower versions is a single element array) that are affected by the constraint
- status

Config optional param is a map and its possible values are:

- labels : list of labels to retrieve index/constraint information
- excludeLabels: list of labels to exclude from retrieve index/constraint information
- relationships: list of relationships type to retrieve constraint information
- excludeRelationships: list of relationships' type to exclude from retrieve constraint information

**Exclude has more power than include, so if excludeLabels and labels are both valued, procedure considers excludeLabels only, the same for relationships.**

```cypher
CALL apoc.schema.nodes({labels:['Book']}) yield name, label, properties, status, type
```

N.B. Constraints for property existence on nodes and relationships are available only for the Enterprise Edition.

To retrieve the index existence on node, you can use the following user function:

```cypher
RETURN apoc.schema.node.indexExists(labelName, propertyNames)
```

The output return the index existence on node is present or not

To retrieve if the constraint exists on node, you can use the following user function:

```cypher
RETURN apoc.schema.node.constraintExists(labelName, propertyNames)
```

The output return the constraint existence on node.

To retrieve if the constraint exists on relationship, you can use the following user function:

```cypher
RETURN apoc.schema.relationship.constraintExists(type, propertyNames)
```

The output return the constraint on the relationship is present or not

###### [Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_examples_7)

[List Schema assert](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_list_schema_assert)

When you:

```cypher
CALL apoc.schema.assert({Foo:['bar']},null)
```

you will receive this result:

![apoc.schema.assert.index](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.assert.index.png)

When you:

```cypher
CALL apoc.schema.assert(null,{Foo:['bar']})
```

you will receive this result:

![apoc.schema.assert.constraint](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.assert.constraint.png)

When you:

```cypher
CALL apoc.schema.assert(null,null)
```

you will receive this result:

![apoc.schema.assert.drop](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.assert.drop.png)

[List indexes and constraints for nodes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_list_indexes_and_constraints_for_nodes)

Given the following cypher statements:

```cypher
CREATE CONSTRAINT ON (bar:Bar) ASSERT exists(bar.foobar)
CREATE CONSTRAINT ON (bar:Bar) ASSERT bar.foo IS UNIQUE
CREATE INDEX ON :Person(name)
CREATE INDEX ON :Publication(name)
CREATE INDEX ON :Source(name)
```

When you

```cypher
CALL apoc.schema.nodes()
```

you will receive this result:

![apoc.schema.nodes](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.nodes.png)

[List constraints for relationships](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_list_constraints_for_relationships)

Given the following cypher statements:

```cypher
CREATE CONSTRAINT ON ()-[like:LIKED]-() ASSERT exists(like.day)
CREATE CONSTRAINT ON ()-[starred:STARRED]-() ASSERT exists(starred.month)
```

When you

```cypher
CALL apoc.schema.relationships()
```

you will receive this result:

![apoc.schema.relationships](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.relationships.png)

[Check if an index or a constraint exists for a Label and property](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_check_if_an_index_or_a_constraint_exists_for_a_label_and_property)

Given the previous index definitions, running this statement:

```cypher
RETURN apoc.schema.node.indexExists("Publication", ["name"])
```

produces the following output:

![apoc.schema.node.indexExists](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.node.indexExists.png)

Given the previous constraint definitions, running this statement:

```cypher
RETURN apoc.schema.node.constraintExists("Bar", ["foobar"])
```

produces the following output:

![apoc.schema.node.constraintExists](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.node.constraintExists.png)

If you want to check if a constraint exists for a relationship you can run this statement:

```cypher
RETURN apoc.schema.relationship.constraintExists('LIKED', ['day'])
```

and you get the following result:

![apoc.schema.relationship.constraintExists](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.schema.relationship.constraintExists.png)

### [Deprecated: Manual Indexes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#manual-indexes)

|      | These Index procedures in the namespaces `apoc.index.*` are deprecated and will be removed from APOC soon. From version 3.5 Neo4j provides built-in, case-insensitive, configurable fulltext indices. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Index Queries](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_index_queries)

Procedures to add to and query manual indexes

|      | Please note that there are (case-sensitive) [automatic schema indexes](http://neo4j.com/docs/developer-manual/current/#cypher-schema), for equality, non-equality, existence, range queries, starts with, ends-with and contains! |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

| `apoc.index.addAllNodes('index-name',{label1:['prop1',…],…}, {options})` | add all nodes to this full text index with the given fields, additionally populates a 'search' index field with all of them in one place |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.index.addNode(node,['prop1',…])`                       | add node to an index for each label it has                   |
| `apoc.index.addNodeByLabel('Label',node,['prop1',…])`        | add node to an index for the given label                     |
| `apoc.index.addNodeByName('name',node,['prop1',…])`          | add node to an index for the given name                      |
| `apoc.index.addNodeMap(node,{key:value})`                    | add node to an index for each label it has with the given attributes which can also be computed |
| `apoc.index.addNodeMapByName(index, node,{key:value})`       | add node to an index for each label it has with the given attributes which can also be computed |
| `apoc.index.addRelationship(rel,['prop1',…])`                | add relationship to an index for its type                    |
| `apoc.index.addRelationshipByName('name',rel,['prop1',…])`   | add relationship to an index for the given name              |
| `apoc.index.addRelationshipMap(rel,{key:value})`             | add relationship to an index for its type indexing the given document which can be computed |
| `apoc.index.addRelationshipMapByName(index, rel,{key:value})` | add relationship to an index for its type indexing the given document which can be computed |
| `apoc.index.removeNodeByName('name',node) remove node from an index for the given name` | apoc.index.removeRelationshipByName('name',rel) remove relationship from an index for the given name |

![apoc.index.nodes with score](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.index.nodes-with-score.jpg)

| `apoc.index.search('index-name', 'query') YIELD node, weight` | search for the first 100 nodes in the given full text index matching the given lucene query returned by relevance |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.index.nodes('Label','prop:value*') YIELD node, weight` | lucene query on node index with the given label name         |
| `apoc.index.relationships('TYPE','prop:value*') YIELD rel, weight` | lucene query on relationship index with the given type name  |
| `apoc.index.between(node1,'TYPE',node2,'prop:value*') YIELD rel, weight` | lucene query on relationship index with the given type name bound by either or both sides (each node parameter can be null) |
| `apoc.index.out(node,'TYPE','prop:value*') YIELD node, weight` | lucene query on relationship index with the given type name for **outgoing** relationship of the given node, **returns end-nodes** |
| `apoc.index.in(node,'TYPE','prop:value*') YIELD node, weight` | lucene query on relationship index with the given type name for **incoming** relationship of the given node, **returns start-nodes** |
| `apoc.index.nodes.count('Label','prop:value*') YIELD value`  | lucene query on node index with the given label name, **returns count-nodes** |
| `apoc.index.relationships.count('TYPE','prop:value*') YIELD value` | lucene query on relationship index with the given type name, **returns count-relationships** |
| `apoc.index.between.count(node1,'TYPE',node2,'prop:value*') YIELD value` | lucene query on relationship index with the given type name bound by either or both sides (each node parameter can be null), **returns count-relationships** |
| `apoc.index.out.count(node,'TYPE','prop:value*') YIELD value` | lucene query on relationship index with the given type name for **outgoing** relationship of the given node, **returns count-end-nodes** |
| `apoc.index.in.count(node,'TYPE','prop:value*') YIELD value` | lucene query on relationship index with the given type name for **incoming** relationship of the given node, **returns count-start-nodes** |

#### [Index Management](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_index_management)

| `CALL apoc.index.list() YIELD type,name,config`              | lists all manual indexes                  |
| ------------------------------------------------------------ | ----------------------------------------- |
| `CALL apoc.index.remove('name') YIELD type,name,config`      | removes manual indexes                    |
| `CALL apoc.index.forNodes('name',{config}) YIELD type,name,config` | gets or creates manual node index         |
| `CALL apoc.index.forRelationships('name',{config}) YIELD type,name,config` | gets or creates manual relationship index |

Add node to index example

```cypher
match (p:Person) call apoc.index.addNode(p,["name","age"]) RETURN count(*);
// 129s for 1M People
call apoc.index.nodes('Person','name:name100*') YIELD node, weight return * limit 2
```

### [Manual Index Examples](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_manual_index_examples)

#### [Data Used](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_data_used)

The below examples use [flight data](https://github.com/nicolewhite/neo4j-flights).

Here is a sample subset of the data that can be load to try the procedures:

```cypher
CREATE (slc:Airport {abbr:'SLC', id:14869, name:'SALT LAKE CITY INTERNATIONAL'})
CREATE (oak:Airport {abbr:'OAK', id:13796, name:'METROPOLITAN OAKLAND INTERNATIONAL'})
CREATE (bur:Airport {abbr:'BUR', id:10800, name:'BOB HOPE'})
CREATE (f2:Flight {flight_num:6147, day:2, month:1, weekday:6, year:2016})
CREATE (f9:Flight {flight_num:6147, day:9, month:1, weekday:6, year:2016})
CREATE (f16:Flight {flight_num:6147, day:16, month:1, weekday:6, year:2016})
CREATE (f23:Flight {flight_num:6147, day:23, month:1, weekday:6, year:2016})
CREATE (f30:Flight {flight_num:6147, day:30, month:1, weekday:6, year:2016})
CREATE (f2)-[:DESTINATION {arr_delay:-13, taxi_time:9}]->(oak)
CREATE (f9)-[:DESTINATION {arr_delay:-8, taxi_time:4}]->(bur)
CREATE (f16)-[:DESTINATION {arr_delay:-30, taxi_time:4}]->(slc)
CREATE (f23)-[:DESTINATION {arr_delay:-21, taxi_time:3}]->(slc)
CREATE (f30)-[:DESTINATION]->(slc)
```

#### [Using Manual Index on Node Properties](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_manual_index_on_node_properties)

In order to create manual index on a node property, you call `apoc.index.addNode` with the node, providing the properties to be indexed.

```cypher
MATCH (a:Airport)
CALL apoc.index.addNode(a,['name'])
RETURN count(*)
```

The statement will create the node index with the **same name as the Label name(s) of the node** in this case `Airport`and add the node by their properties to the index.

Once this has been added check if the node index exists using `apoc.index.list`.

```cypher
CALL apoc.index.list()
```

Usually `apoc.index.addNode` would be used as part of node-creation, e.g. during LOAD CSV. There is also `apoc.index.addNodes` for adding a list of multiple nodes at once.

Once the node index is created we can start using it.

Here are some examples:

The `apoc.index.nodes` finds nodes in a manual index using the given lucene query.

|      | That makes only sense if you combine multiple properties in one lookup or use case insensitive or fuzzy matching full-text queries. In all other cases the built in schema indexes should be used. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

```cypher
CALL apoc.index.nodes('Airport','name:inter*') YIELD node AS airport, weight
RETURN airport.name, weight
LIMIT 10
```

|      | Apoc index queries not only return nodes and relationships but also a weight, which is the score returned from the underlying Lucene index. The results are also sorted by that score. That’s especially helpful for partial and fuzzy text searches. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

To remove the node index `Airport` created, use:

```cypher
CALL apoc.index.remove('Airport')
```

##### [Add "document" to index](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_add_document_to_index)

Instead of the key-value pairs of a node or relationship properties, you can also compute a map containing information and add that to the index. So you could find a node or relationship by information from it’s neighbours or relationships.

```cypher
CREATE (company:Company {name:'Neo4j,Inc.'})
CREATE (company)<-[:WORKS_AT {since:2013}]-(:Employee {name:'Mark'})
CREATE (company)<-[:WORKS_AT {since:2014}]-(:Employee {name:'Martin'})
MATCH (company:Company)<-[worksAt:WORKS_AT]-(employee)
WITH company, { name: company.name, employees:collect(employee.name),startDates:collect(worksAt.since)} as data
CALL apoc.index.addNodeMap(company, data)
RETURN count(*)
```

These could be example searches that all return the same result node.

```cypher
CALL apoc.index.nodes('Company','name:Ne* AND employees:Ma*')
CALL apoc.index.nodes('Company','employees:Ma*')
CALL apoc.index.nodes('Company','startDates:[2013 TO 2014]')
```

#### [Using Manual Index on Relationship Properties](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_using_manual_index_on_relationship_properties)

The procedure `apoc.index.addRelationship` is used to create a manual index on relationship properties.

As there are no schema indexes for relationships, these manual indexes can be quite useful.

```cypher
MATCH (:Flight)-[r:DESTINATION]->(:Airport)
CALL apoc.index.addRelationship(r,['taxi_time'])
RETURN count(*)
```

The statement will create the relationship index with the **same name as relationship-type**, in this case `DESTINATION`and add the relationship by its properties to the index.

Using `apoc.index.relationships`, we can find the relationship of type `DESTINATION` with the property `taxi_time` of 11 minutes. We can chose to also return the start and end-node.

```cypher
CALL apoc.index.relationships('DESTINATION','taxi_time:11') YIELD rel, start AS flight, end AS airport
RETURN flight_num.flight_num, airport.name;
```

|      | Manual relationship indexed do not only store the relationship by its properties but also the start- and end-node. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

That’s why we can use that information to subselect relationships not only by property but also by those nodes, which is quite powerful.

With `apoc.index.in` we can pin the node with incoming relationships (end-node) to get the start nodes for all the `DESTINATION` relationships. For instance to find all flights arriving in 'SALT LAKE CITY INTERNATIONAL' with a taxi_time of 7 minutes we’d use:

```cypher
MATCH (a:Airport {name:'SALT LAKE CITY INTERNATIONAL'})
CALL apoc.index.in(a,'DESTINATION','taxi_time:7') YIELD node AS flight
RETURN flight
```

The opposite is `apoc.index.out`, which takes and binds end-nodes and returns start-nodes of relationships.

Really useful to quickly find a subset of relationships between nodes with many relationships (tens of thousands to millions) is `apoc.index.between`. Here you bind both the start and end-node and provide (or not) properties of the relationships.

```cypher
MATCH (f:Flight {flight_num:6147})
MATCH (a:Airport {name:'SALT LAKE CITY INTERNATIONAL'})
CALL apoc.index.between(f,'DESTINATION',a,'taxi_time:7') YIELD rel, weight
RETURN *
```

To remove the relationship index `DESTINATION` that was created, use.

```cypher
CALL apoc.index.remove('DESTINATION')
```

#### [Schema Index Queries](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_schema_index_queries)

Schema Index lookups that keep order and can apply limits

| `apoc.index.orderedRange(label,key,min,max,sort-relevance,limit) yield node` | schema range scan which keeps index order and adds limit, values can be null, boundaries are inclusive |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.index.orderedByText(label,key,operator,value,sort-relevance,limit) yield node` | schema string search which keeps index order and adds limit, operator is 'STARTS WITH' or 'CONTAINS' |

### [Deprecated: Full Text Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#fulltext-index)

|      | These Fulltext-Index procedures are deprecated and will be removed from APOC soon. From version 3.5 Neo4j provides built-in, case-insensitive, configurable fulltext indices. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

Indexes are used for finding nodes in the graph that further operations can then continue from. Just like in a book where you look at the index to find a section that interest you, and then start reading from there. A full text index allows you to find occurrences of individual words or phrases across all attributes.

In order to use the full text search feature, we have to first index our data by specifying all the attributes we want to index. Here we create a full text index called `“locations”` (we will use this name when searching in the index) with our data.

|      | by default these fulltext indexes do not automatically track changes you perform in your graph. See …. for how to enabled automatic index tracking. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

```cypher
CALL apoc.index.addAllNodes('locations',{
  Company: ["name", "description"],
  Person:  ["name","address"],
  Address: ["address"]})
```

Creating the index will take a little while since the procedure has to read through the entire database to create the index.

We can now use this index to search for nodes in the database. The most simple case would be to search across all data for a particular word.

It does not matter which property that word exists in, any node that has that word in any of its indexed properties will be found.

If you use a name in the call, all occurrences will be found (but limited to 100 results).

```cypher
CALL apoc.index.search("locations", 'name')
```

#### [Advanced Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_advanced_search)

We can further restrict our search to only searching in a particular attribute. In order to search for a `Person` with an address in **France**, we use the following.

```cypher
CALL apoc.index.search("locations", "Person.address:France")
```

Now we can search for nodes with a specific property value, and then explore their neighbourhoods visually.

But integrating it with an graph query is so much more powerful.

#### [Fulltext and Graph Search](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_fulltext_and_graph_search)

We could for instance search for addresses in the database that contain the word "Paris", and then find all companies registered at those addresses:

```cypher
CALL apoc.index.search("locations", "Address.address:Paris~") YIELD node AS addr
MATCH (addr)<-[:HAS_ADDRESS]-(company:Company)
RETURN company LIMIT 50
```

The tilde (~) instructs the index search procedure to do a fuzzy match, allowing us to find "Paris" even if the spelling is slightly off.

We might notice that there are addresses that contain the word “Paris” that are not in Paris, France. For example there might be a Paris Street somewhere.

We can further specify that we want the text to contain both the word Paris, and the word France:

```cypher
CALL apoc.index.search("locations", "+Address.address:Paris~ +France~")
YIELD node AS addr
MATCH (addr)<-[:HAS_ADDRESS]-(company:Company)
RETURN company LIMIT 50
```

#### [Complex Searches](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_complex_searches)

Things start to get interesting when we look at how the different entities in Paris are connected to one another. We can do that by finding all the entities with addresses in Paris, then creating all pairs of such entities and finding the shortest path between each such pair:

```cypher
CALL apoc.index.search("locations", "+Address.address:Paris~ +France~") YIELD node AS addr
MATCH (addr)<-[:HAS_ADDRESS]-(company:Company)
WITH collect(company) AS companies

// create unique pairs
UNWIND companies AS x UNWIND companies AS y
WITH x, y WHERE ID(x) < ID(y)

MATCH path = shortestPath((x)-[*..10]-(y))
RETURN path
```

For more details on the query syntax used in the second parameter of the `search` procedure, please see [this Lucene query tutorial](http://www.lucenetutorial.com/lucene-query-syntax.html)

##### [Index Configuration](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_index_configuration)

`apoc.index.addAllNodes(<name>, <labelPropsMap>, <option>)` allows to fine tune your indexes using the options parameter defaulting to an empty map. All [standard options](https://neo4j.com/docs/java-reference/3.1/#indexing-create-advanced) for [Neo4j manual indexes](https://neo4j.com/docs/java-reference/3.1/#indexing) are allowed plus apoc specific options:

| name            | value            | description                                                |
| :-------------- | :--------------- | :--------------------------------------------------------- |
| `type`          | `fulltext/exact` | type of the index                                          |
| `to_lower_case` | `false/true`     | if terms should be converted to lower case before indexing |
| `analyzer`      | `classname`      | classname of lucene analyzer to be used for this index     |
| `similarity`    | `classname`      | classname for lucene similarity to be used for this index  |
| `autoUpdate`    | `true/false`     | if this index should be tracked for graph updates          |

|      | An index configuration cannot be changed once the index is created. However subsequent invocations of `apoc.index.addAllNodes` will delete the index if existing and create it afterwards. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Automatic Index Tracking for Manual Indexes](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_automatic_index_tracking_for_manual_indexes)

As mentioned above, `apoc.index.addAllNodes()` populates an fulltext index. But it does not track changes being made to the graph and reflect these changes to the index. You would have to rebuild that index regularly yourself.

Or alternatively use the automatic index tracking, that keeps the index in sync with your graph changes. To enable this feature a two step configuration approach is required.

|      | Please note that there is a performance impact if you enable automatic index tracking. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

in `neo4j.conf` set

```properties
apoc.autoIndex.enabled=true
```

This global setting will initialize a transaction event handler to take care of reflecting changes of any added nodes, deleted nodes, changed properties to the indexes.

In addition to enable index tracking globally using `apoc.autoIndex.enabled` each individual index must be configured as "trackable" by setting `autoUpdate:true` in the options when initially creating an index:

```cypher
CALL apoc.index.addAllNodes('locations',{
  Company: ["name", "description"],
  Person:  ["name","address"],
  Address: ["address"]}, {autoUpdate:true})
```

By default index tracking is done synchronously. That means updates to fulltext indexes are part of same transaction as the originating change (e.g. changing a node property). While this guarantees instant consistency it has an impact on performance.

Alternatively, you can decide to perform index updates asynchronously in a separate thread by setting this flag in `neo4j.conf`

```properties
apoc.autoIndex.async=true
```

With this setting enabled, index updates are fed to a buffer queue that is consumed asynchronously using transaction batches. The batching can be further configured using

```properties
apoc.autoIndex.queue_capacity=100000
apoc.autoIndex.async_rollover_opscount=50000
apoc.autoIndex.async_rollover_millis=5000
apoc.autoIndex.tx_handler_stopwatch=false
```

The values above are the default setting. In this example the index updates are consumed in transactions of maximum 50000 operations or 5000 milliseconds - whichever triggers first will cause the index update transaction to be committed and rolled over.

If `apoc.autoIndex.tx_handler_stopwatch` is enabled, the time spent in `beforeCommit` and `afterCommit` is traced to `debug.log`. Use this setting only for diagnosis.

##### [A Worked Example on Fulltext Index Tracking](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_a_worked_example_on_fulltext_index_tracking)

This section provides a small but still usable example to understand automatic index updates.

Make sure `apoc.autoIndex.enabled=true` is set. First we create some nodes - note there’s no index yet.

```cypher
UNWIND ["Johnny Walker", "Jim Beam", "Jack Daniels"] as name CREATE (:Person{name:name})
```

Now we index them:

```cypher
CALL apoc.index.addAllNodes('people', { Person:["name"]}, {autoUpdate:true})
```

Check if we can find "Johnny" - we expect one result.

```cypher
CALL apoc.index.search("people", "Johnny") YIELD node, weight
RETURN node.name, weight
```

Adding some more people - note, we have another "Johnny":

```cypher
UNWIND ["Johnny Rotten", "Axel Rose"] as name CREATE (:Person{name:name})
```

Again we’re search for "Johnny", expecting now two of them:

```cypher
CALL apoc.index.search("people", "Johnny") YIELD node, weight
RETURN node.name, weight
```

##### [Fulltext index count](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_fulltext_index_count)

Accompanying UserFunctions that just return counts for nodes and relationships manual index

```cypher
apoc.index.nodes.count('Label','prop:value*') YIELD value
apoc.index.relationships.count('TYPE','prop:value*') YIELD value
apoc.index.between.count(node1,'TYPE',node2,'prop:value*') YIELD value
apoc.index.out.count(node,'TYPE','prop:value*') YIELD value
apoc.index.in.count(node,'TYPE','prop:value*') YIELD value
```

[Some example with the userFunctions describe above](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_some_example_with_the_userfunctions_describe_above)

First we create this set of data:

```cypher
CREATE (joe:Person:Hipster {name:'Joe',age:42})-[checkin:CHECKIN {on:'2015-12-01'}]->(philz:Place {name:'Philz'})
MATCH (p:Person) CALL apoc.index.addNode(p, ["name"]) RETURN count(*)
MATCH (p:Place) CALL apoc.index.addNode(p, ["name"]) RETURN count(*)
MATCH (person:Person)-[check:CHECKIN]->(place:Place) CALL apoc.index.addRelationship(check, ["on"]) RETURN count(*)
```

- We call the apoc.index.nodes.count function as follow:

```cypher
RETURN apoc.index.nodes.count('Person', 'name:Jo*') AS value
```

The result is:

![apoc.index.nodes.count](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.index.nodes.count.png)

- We call the apoc.index.relationships.count function as follow:

```cypher
RETURN apoc.index.relationships.count('CHECKIN', 'on:2015-*') as value
```

The result is:

![apoc.index.relationships.count](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.index.relationships.count.png)

- We call the apoc.index.between.count function as follow:

```cypher
MATCH (joe:Person:Hipster {name:'Joe',age:42}),(philz:Place {name:'Philz'}) WITH joe,philz RETURN apoc.index.between.count(joe, 'CHECKIN', philz, 'on:2015-*') as value
```

The result is:

![apoc.index.between.count](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.index.between.count.png)

- We call the apoc.index.in.count function as follow:

```cypher
MATCH (philz:Place {name:'Philz'}) WITH philz RETURN apoc.index.in.count(philz, 'CHECKIN','on:2015-*') as value
```

The result is:

![apoc.in.nodes.count](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.in.nodes.count.png)

- We call the apoc.index.out.count function as follow:

```cypher
MATCH (joe:Person:Hipster {name:'Joe',age:42}) WITH joe RETURN apoc.index.out.count(joe, 'CHECKIN','on:2015-*') as value
```

The result is:

![apoc.index.out.count](https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.4/docs/images/apoc.index.out.count.png)

## [Deprecated: Graph Algorithms](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#algorithms)

|      | Graph Algorithms (similarity, centrality and clustering) in APOC are deprecated and about to be removed. Please use the algorithms in [neo4j-graph-algorithms](https://r.neo4j.com/algo) instead. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

### [Similarity](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#similarity)

| `apoc.algo.cosineSimilarity([vector1], [vector2])`    | Compute cosine similarity    |
| ----------------------------------------------------- | ---------------------------- |
| `apoc.algo.euclideanDistance([vector1], [vector2])`   | Compute Euclidean distance   |
| `apoc.algo.euclideanSimilarity([vector1], [vector2])` | Compute Euclidean similarity |

| `apoc.algo.betweenness(['TYPE',…],nodes,BOTH) YIELD node, score` | calculate betweenness centrality for given nodes |
| ------------------------------------------------------------ | ------------------------------------------------ |
| `apoc.algo.closeness(['TYPE',…],nodes, INCOMING) YIELD node, score` | calculate closeness centrality for given nodes   |
| `apoc.algo.cover(nodeIds) YIELD rel`                         | return relationships between this set of nodes   |

| `apoc.algo.pageRank(nodes) YIELD node, score`                | calculates page rank for given nodes |
| ------------------------------------------------------------ | ------------------------------------ |
| `apoc.algo.pageRankWithConfig(nodes,{iterations:_,types:_}) YIELD node, score` | calculates page rank for given nodes |

| `apoc.algo.community(times,labels,partitionKey,type,direction,weightKey,batchSize)` | simple label propagation kernel                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `apoc.algo.cliques(minSize) YIELD clique`                    | search the graph and return all maximal cliques at least at large as the minimum size argument. |
| `apoc.algo.cliquesWithNode(startNode, minSize) YIELD clique` | search the graph and return all maximal cliques that are at least as large than the minimum size argument and contain this node |

### [Community Detection via Label Propagation](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#community-detection)

|      | Graph Algorithms (similarity, centrality and clustering) in APOC are deprecated and about to be removed. Please use the algorithms in [neo4j-graph-algorithms](https://r.neo4j.com/algo) instead. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

APOC includes a simple procedure for label propagation. It may be used to detect communities or solve other graph partitioning problems. The following example shows how it may be used.

The example call with scan all nodes 25 times. During a scan the procedure will look at all outgoing relationships of type :X for each node n. For each of these relationships, it will compute a weight and use that as a vote for the other node’s 'partition' property value. Finally, n.partition is set to the property value that acquired the most votes.

Weights are computed by multiplying the relationship weight with the weight of the other nodes. Both weights are taken from the 'weight' property; if no such property is found, the weight is assumed to be 1.0. Similarly, if no 'weight' property key was specified, all weights are assumed to be 1.0.

```cypher
CALL apoc.algo.community(25,null,'partition','X','OUTGOING','weight',10000)
```

The second argument is a list of label names and may be used to restrict which nodes are scanned.

### [Centrality Algorithms](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#centrality)

|      | Graph Algorithms (similarity, centrality and clustering) in APOC are deprecated and about to be removed. Please use the algorithms in [neo4j-graph-algorithms](https://r.neo4j.com/algo) instead. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Setup](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_setup)

Let’s create some test data to run the Centrality algorithms on.

```cypher
// create 100 nodes
FOREACH (id IN range(0,1000) | CREATE (:Node {id:id}))

// over the cross product (1M) create 100.000 relationships
MATCH (n1:Node),(n2:Node) WITH n1,n2 LIMIT 1000000 WHERE rand() < 0.1

CREATE (n1)-[:TYPE]->(n2)
```

#### [Closeness Centrality Procedure](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_closeness_centrality_procedure)

Centrality is an indicator of a node’s influence in a graph. In graphs there is a natural distance metric between pairs of nodes, defined by the length of their shortest paths. For both algorithms below we can measure based upon the direction of the relationship, whereby the 3rd argument represents the direction and can be of value BOTH, INCOMING, OUTGOING.

Closeness Centrality defines the farness of a node as the sum of its distances from all other nodes, and its closeness as the reciprocal of farness.

The more central a node is the lower its total distance from all other nodes.

Complexity: This procedure uses a BFS shortest path algorithm. With BFS the complexes becomes `O(n * m)` Caution: Due to the complexity of this algorithm it is recommended to run it on only the nodes you are interested in.

```cypher
MATCH (node:Node)
WHERE node.id %2 = 0
WITH collect(node) AS nodes
CALL apoc.algo.closeness(['TYPE'],nodes,'INCOMING') YIELD node, score
RETURN node, score
ORDER BY score DESC
```

#### [Betweenness Centrality Procedure](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_betweenness_centrality_procedure)

The procedure will compute betweenness centrality as defined by Linton C. Freeman (1977) using the algorithm by Ulrik Brandes (2001). Centrality is an indicator of a node’s influence in a graph.

Betweenness Centrality is equal to the number of shortest paths from all nodes to all others that pass through that node.

High centrality suggests a large influence on the transfer of items through the graph.

Centrality is applicable to numerous domains, including: social networks, biology, transport and scientific cooperation.

Complexity: This procedure uses a BFS shortest path algorithm. With BFS the complexes becomes O(n * m) Caution: Due to the complexity of this algorithm it is recommended to run it on only the nodes you are interested in.

```cypher
MATCH (node:Node)
WHERE node.id %2 = 0
WITH collect(node) AS nodes
CALL apoc.algo.betweenness(['TYPE'],nodes,'BOTH') YIELD node, score
RETURN node, score
ORDER BY score DESC
```

### [PageRank Algorithm](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#pagerank)

|      | Graph Algorithms (similarity, centrality and clustering) in APOC are deprecated and about to be removed. Please use the algorithms in [neo4j-graph-algorithms](https://r.neo4j.com/algo) instead. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

#### [Setup](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_setup_2)

Let’s create some test data to run the PageRank algorithm on.

```cypher
// create 100 nodes
FOREACH (id IN range(0,1000) | CREATE (:Node {id:id}))

// over the cross product (1M) create 100.000 relationships
MATCH (n1:Node),(n2:Node) WITH n1,n2 LIMIT 1000000 WHERE rand() < 0.1

CREATE (n1)-[:TYPE_1]->(n2)
```

#### [PageRank Procedure](https://neo4j-contrib.github.io/neo4j-apoc-procedures/#_pagerank_procedure)

PageRank is an algorithm used by Google Search to rank websites in their search engine results.

It is a way of measuring the importance of nodes in a graph.

PageRank counts the number and quality of relationships to a node to approximate the importance of that node.

PageRank assumes that more important nodes likely have more relationships.

Caution: `nodes` specifies the nodes for which a PageRank score will be projected, but the procedure will *always* compute the PageRank algorithm on the *entire* graph. At present, there is no way to filter/reduce the number of elements that PageRank computes over.

A future version of this procedure will provide the option of computing PageRank on a subset of the graph.

```cypher
MATCH (node:Node)
WHERE node.id %2 = 0
WITH collect(node) AS nodes
// compute over relationships of all types
CALL apoc.algo.pageRank(nodes) YIELD node, score
RETURN node, score
ORDER BY score DESC
MATCH (node:Node)
WHERE node.id %2 = 0
WITH collect(node) AS nodes
// only compute over relationships of types TYPE_1 or TYPE_2
CALL apoc.algo.pageRankWithConfig(nodes,{types:'TYPE_1|TYPE_2'}) YIELD node, score
RETURN node, score
ORDER BY score DESC
MATCH (node:Node)
WHERE node.id %2 = 0
WITH collect(node) AS nodes
// peroform 10 page rank iterations, computing only over relationships of type TYPE_1
CALL apoc.algo.pageRankWithConfig(nodes,{iterations:10,types:'TYPE_1'}) YIELD node, score
RETURN node, score
ORDER BY score DESC
```