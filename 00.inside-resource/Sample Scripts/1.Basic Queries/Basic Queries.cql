
//====Hello World!====
CREATE (database:Database {name:"Neo4j"})-[r:SAYS]->(message:Message {name:"Hello World!"}) RETURN database, message, r
;

//====Get some data====
MATCH (n1)-[r]->(n2) RETURN r, n1, n2 LIMIT 25
;


//====Create an index====
// Replace:
//   'LabelName' with label to index
//   'propertyKey' with property to be indexed
CREATE INDEX ON :LabelName(propertyKey)
;

//====Create unique property constraint====
// Replace:
//   'LabelName' with node label
//   'propertyKey' with property that should be unique
CREATE CONSTRAINT ON (n:LabelName) ASSERT n.propertyKey IS UNIQUE