MATCH (n) DETACH DELETE n;
//====Product Catalog====
//Load records
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/products.csv' AS row
CREATE (n:Product)
SET n = row,
  n.unitPrice = toFloat(row.unitPrice),
  n.unitsInStock = toInteger(row.unitsInStock), n.unitsOnOrder = toInteger(row.unitsOnOrder),
  n.reorderLevel = toInteger(row.reorderLevel), n.discontinued = (row.discontinued <> '0')
;
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/categories.csv' AS row
CREATE (n:Category)
SET n = row
;
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/suppliers.csv' AS row
CREATE (n:Supplier)
SET n = row
;
//Create indexes
CREATE INDEX ON :Product(productID);
CREATE INDEX ON :Category(categoryID);
CREATE INDEX ON :Supplier(supplierID);


//====Product Catalog Graph====
//Create data relationships
MATCH (p:Product),(c:Category)
WHERE p.categoryID = c.categoryID
CREATE (p)-[:PART_OF]->(c) ;

//Note you only need to compare property values like this when first creating relationships
//Calculate join, materialize relationship. (See   importing guide for more details)
MATCH (p:Product),(s:Supplier)
WHERE p.supplierID = s.supplierID
CREATE (s)-[:SUPPLIES]->(p);
//Note you only need to compare property values like this when first creating relationships

//====Querying Product Catalog Graph====
//Query using patterns
//List the product categories provided by each supplier.
MATCH (s:Supplier)-->(:Product)-->(c:Category)
RETURN s.companyName AS Company, collect(DISTINCT c.categoryName) AS Categories
;

//Find the produce suppliers.
MATCH (c:Category {categoryName:'Produce'})<--(:Product)<--(s:Supplier)
RETURN DISTINCT s.companyName AS ProduceSuppliers
;
//====Customer Orders====
//Load and index records
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/customers.csv' AS row
CREATE (n:Customer)
SET n = row ;
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/orders.csv' AS row
CREATE (n:Order)
SET n = row ;
CREATE INDEX ON :Customer(customerID) ;
CREATE INDEX ON :Order(orderID) ;
//Create data relationships
MATCH (c:Customer),(o:Order)
WHERE c.customerID = o.customerID
CREATE (c)-[:PURCHASED]->(o);
//Note you only need to compare property values like this when first creating relationships


//====Customer Order Graph====
//Load and index records
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/northwind/order-details.csv' AS row
MATCH (p:Product), (o:Order)
WHERE p.productID = row.productID AND o.orderID = row.orderID
CREATE (o)-[details:ORDERS]->(p)
SET details = row,
  details.quantity = toInteger(row.quantity)
;
//Note you only need to compare property values like this when first creating relationships
//Query using patterns
MATCH (cust:Customer)-[:PURCHASED]->(:Order)-[o:ORDERS]->(p:Product),
      (p)-[:PART_OF]->(c:Category {categoryName:'Produce'})
RETURN DISTINCT cust.contactName AS CustomerName, sum(o.quantity) AS TotalProductsPurchased
;



















