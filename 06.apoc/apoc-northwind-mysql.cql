//将jdbc依赖包放在Neo4jServer的plugins目录下，重启服务器并载入JDBC驱动
CALL apoc.load.driver("com.mysql.jdbc.Driver");

//查询数据库相关表
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
RETURN count(*);

//查询数据库相关表
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
RETURN row limit 1;

//清空neo4j数据库
MATCH (n) detach delete n;
// 导入单表数据
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
CREATE (o:Orders)
SET o=row;

call db.schema();




//#### Load records
//```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Products") YIELD row
CREATE (n:Product)
SET n = row,
  n.unitPrice = toFloat(row.unitPrice),
  n.unitsInStock = toInteger(row.unitsInStock), n.unitsOnOrder = toInteger(row.unitsOnOrder),
  n.reorderLevel = toInteger(row.reorderLevel), n.discontinued = (row.discontinued <> "0");
//```
//```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Categories") YIELD row
CREATE (n:Category)
SET n = row;
//```
//```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Suppliers") YIELD row
CREATE (n:Supplier)
SET n = row
//```
//#### Create indexes
//```
//#### Create indexes
//```cypher
CREATE INDEX ON :Product(productID)
//```
//```cypher
CREATE INDEX ON :Category(categoryID)
//```
//```cypher
CREATE INDEX ON :Supplier(supplierID)
//```

