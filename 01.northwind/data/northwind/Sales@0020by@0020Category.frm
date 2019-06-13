TYPE=VIEW
query=select `northwind`.`Categories`.`CategoryID` AS `CategoryID`,`northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,sum(`Order Details Extended`.`ExtendedPrice`) AS `ProductSales` from (((`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) join `northwind`.`Order Details Extended` on((`northwind`.`Products`.`ProductID` = `Order Details Extended`.`ProductID`))) join `northwind`.`Orders` on((`northwind`.`Orders`.`OrderID` = `Order Details Extended`.`OrderID`))) where (`northwind`.`Orders`.`OrderDate` between \'1997-01-01\' and \'1997-12-31\') group by `northwind`.`Categories`.`CategoryID`,`northwind`.`Categories`.`CategoryName`,`northwind`.`Products`.`ProductName`
md5=913aa5f3628e451760362fc1ffc965e4
updatable=0
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:26
create-version=1
source=SELECT Categories.CategoryID, \n       Categories.CategoryName, \n         Products.ProductName, \n	Sum(`Order Details Extended`.ExtendedPrice) AS ProductSales\nFROM  Categories \n    JOIN Products \n      ON Categories.CategoryID = Products.CategoryID\n       JOIN `Order Details Extended` \n         ON Products.ProductID = `Order Details Extended`.ProductID                \n           JOIN Orders \n             ON Orders.OrderID = `Order Details Extended`.OrderID \nWHERE Orders.OrderDate BETWEEN \'1997-01-01\' And \'1997-12-31\'\nGROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Categories`.`CategoryID` AS `CategoryID`,`northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,sum(`Order Details Extended`.`ExtendedPrice`) AS `ProductSales` from (((`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) join `northwind`.`Order Details Extended` on((`northwind`.`Products`.`ProductID` = `Order Details Extended`.`ProductID`))) join `northwind`.`Orders` on((`northwind`.`Orders`.`OrderID` = `Order Details Extended`.`OrderID`))) where (`northwind`.`Orders`.`OrderDate` between \'1997-01-01\' and \'1997-12-31\') group by `northwind`.`Categories`.`CategoryID`,`northwind`.`Categories`.`CategoryName`,`northwind`.`Products`.`ProductName`
