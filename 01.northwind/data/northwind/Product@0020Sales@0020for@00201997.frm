TYPE=VIEW
query=select `northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,sum(((((`northwind`.`Order Details`.`UnitPrice` * `northwind`.`Order Details`.`Quantity`) * (1 - `northwind`.`Order Details`.`Discount`)) / 100) * 100)) AS `ProductSales` from (((`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) join `northwind`.`Order Details` on((`northwind`.`Products`.`ProductID` = `northwind`.`Order Details`.`ProductID`))) join `northwind`.`Orders` on((`northwind`.`Orders`.`OrderID` = `northwind`.`Order Details`.`OrderID`))) where (`northwind`.`Orders`.`ShippedDate` between \'1997-01-01\' and \'1997-12-31\') group by `northwind`.`Categories`.`CategoryName`,`northwind`.`Products`.`ProductName`
md5=8aded5cf9f098353880489b368ec19ed
updatable=0
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT Categories.CategoryName, \n       Products.ProductName, \n       Sum((`Order Details`.UnitPrice*Quantity*(1-Discount)/100)*100) AS ProductSales\nFROM Categories\n JOIN    Products On Categories.CategoryID = Products.CategoryID\n    JOIN  `Order Details` on Products.ProductID = `Order Details`.ProductID     \n     JOIN  `Orders` on Orders.OrderID = `Order Details`.OrderID \nWHERE Orders.ShippedDate Between \'1997-01-01\' And \'1997-12-31\'\nGROUP BY Categories.CategoryName, Products.ProductName
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,sum(((((`northwind`.`Order Details`.`UnitPrice` * `northwind`.`Order Details`.`Quantity`) * (1 - `northwind`.`Order Details`.`Discount`)) / 100) * 100)) AS `ProductSales` from (((`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) join `northwind`.`Order Details` on((`northwind`.`Products`.`ProductID` = `northwind`.`Order Details`.`ProductID`))) join `northwind`.`Orders` on((`northwind`.`Orders`.`OrderID` = `northwind`.`Order Details`.`OrderID`))) where (`northwind`.`Orders`.`ShippedDate` between \'1997-01-01\' and \'1997-12-31\') group by `northwind`.`Categories`.`CategoryName`,`northwind`.`Products`.`ProductName`
