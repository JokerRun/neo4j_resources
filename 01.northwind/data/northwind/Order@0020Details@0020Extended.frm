TYPE=VIEW
query=select `northwind`.`Order Details`.`OrderID` AS `OrderID`,`northwind`.`Order Details`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Order Details`.`UnitPrice` AS `UnitPrice`,`northwind`.`Order Details`.`Quantity` AS `Quantity`,`northwind`.`Order Details`.`Discount` AS `Discount`,((((`northwind`.`Order Details`.`UnitPrice` * `northwind`.`Order Details`.`Quantity`) * (1 - `northwind`.`Order Details`.`Discount`)) / 100) * 100) AS `ExtendedPrice` from (`northwind`.`Products` join `northwind`.`Order Details` on((`northwind`.`Products`.`ProductID` = `northwind`.`Order Details`.`ProductID`)))
md5=89d28132d99488f1a9a81a4da54377c8
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:26
create-version=1
source=SELECT `Order Details`.OrderID, \n       `Order Details`.ProductID, \n       Products.ProductName, \n	   `Order Details`.UnitPrice, \n       `Order Details`.Quantity, \n       `Order Details`.Discount, \n      (`Order Details`.UnitPrice*Quantity*(1-Discount)/100)*100 AS ExtendedPrice\nFROM Products \n     JOIN `Order Details` ON Products.ProductID = `Order Details`.ProductID
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Order Details`.`OrderID` AS `OrderID`,`northwind`.`Order Details`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Order Details`.`UnitPrice` AS `UnitPrice`,`northwind`.`Order Details`.`Quantity` AS `Quantity`,`northwind`.`Order Details`.`Discount` AS `Discount`,((((`northwind`.`Order Details`.`UnitPrice` * `northwind`.`Order Details`.`Quantity`) * (1 - `northwind`.`Order Details`.`Discount`)) / 100) * 100) AS `ExtendedPrice` from (`northwind`.`Products` join `northwind`.`Order Details` on((`northwind`.`Products`.`ProductID` = `northwind`.`Order Details`.`ProductID`)))
