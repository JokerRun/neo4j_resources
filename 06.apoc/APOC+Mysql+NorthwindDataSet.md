
## 1.启动Neo4j Server
启动neo4j server,并将plugins+data目录挂在出来：
```bash
# start neo4j
docker run \
   -d --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/plugins:/plugins \
    --env=NEO4J_AUTH=none \
    -e NEO4J_apoc_export_file_enabled=true \
    -e NEO4J_apoc_import_file_enabled=true \
    -e NEO4J_apoc_import_file_use__neo4j__config=true \
    --name neo4j-apoc \
    neo4j
```

## 2.引入JDBC Driver
将jdbc依赖包放在Neo4jServer的plugins目录下，重启服务器并载入JDBC驱动
```cypher
CALL apoc.load.driver("com.mysql.jdbc.Driver");
```
## 3.APOC 测试
查询数据库相关表
```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
RETURN count(*);
```
查询数据库相关表
```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
RETURN row limit 1;
```
// 导入单表数据
```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Orders") YIELD row
CREATE (o:Orders)
SET o=row;

call db.schema();

```
## 4.导入数据
### 4.1.清空neo4j数据库
```cypher
MATCH (n)detach delete n;
```

### 4.2.Product Catalog

Northwind sells food products in a few categories, provided by suppliers. Let's start by loading the product catalog tables.

The load statements to the right require public internet access.`LOAD CSV` will retrieve a CSV file from a valid URL, applying a Cypher statement to each row using a named map (here we're using the name `row`).

![img](assets/product-category-supplier-b5a40101da41fc85d63062c8cb4db224.png)

#### Load records

```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Products") YIELD row
CREATE (n:Product)
SET n = row,
  n.unitPrice = toFloat(row.unitPrice),
  n.unitsInStock = toInteger(row.unitsInStock), n.unitsOnOrder = toInteger(row.unitsOnOrder),
  n.reorderLevel = toInteger(row.reorderLevel), n.discontinued = (row.discontinued <> "0");
```
```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Categories") YIELD row
CREATE (n:Category)
SET n = row;
```
```cypher
with "jdbc:mysql://172.17.0.3:3306/northwind?user=root&password=123456@" as url
CALL apoc.load.jdbc(url,"Suppliers") YIELD row
CREATE (n:Supplier)
SET n = row
```

#### Create indexes

```cypher
CREATE INDEX ON :Product(productID)
```
```cypher
CREATE INDEX ON :Category(categoryID)
```
```cypher
CREATE INDEX ON :Supplier(supplierID)
```

