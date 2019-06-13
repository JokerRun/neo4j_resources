TYPE=VIEW
query=select `Order Subtotals`.`Subtotal` AS `SaleAmount`,`northwind`.`Orders`.`OrderID` AS `OrderID`,`northwind`.`Customers`.`CompanyName` AS `CompanyName`,`northwind`.`Orders`.`ShippedDate` AS `ShippedDate` from ((`northwind`.`Customers` join `northwind`.`Orders` on((`northwind`.`Customers`.`CustomerID` = `northwind`.`Orders`.`CustomerID`))) join `northwind`.`Order Subtotals` on((`northwind`.`Orders`.`OrderID` = `Order Subtotals`.`OrderID`))) where ((`Order Subtotals`.`Subtotal` > 2500) and (`northwind`.`Orders`.`ShippedDate` between \'1997-01-01\' and \'1997-12-31\'))
md5=6443001337e0fff2672ceb05c232391e
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT `Order Subtotals`.Subtotal AS SaleAmount, \n                  Orders.OrderID, \n               Customers.CompanyName, \n                  Orders.ShippedDate\nFROM Customers \n JOIN Orders ON Customers.CustomerID = Orders.CustomerID\n    JOIN `Order Subtotals` ON Orders.OrderID = `Order Subtotals`.OrderID \nWHERE (`Order Subtotals`.Subtotal >2500) \nAND (Orders.ShippedDate BETWEEN \'1997-01-01\' And \'1997-12-31\')
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `Order Subtotals`.`Subtotal` AS `SaleAmount`,`northwind`.`Orders`.`OrderID` AS `OrderID`,`northwind`.`Customers`.`CompanyName` AS `CompanyName`,`northwind`.`Orders`.`ShippedDate` AS `ShippedDate` from ((`northwind`.`Customers` join `northwind`.`Orders` on((`northwind`.`Customers`.`CustomerID` = `northwind`.`Orders`.`CustomerID`))) join `northwind`.`Order Subtotals` on((`northwind`.`Orders`.`OrderID` = `Order Subtotals`.`OrderID`))) where ((`Order Subtotals`.`Subtotal` > 2500) and (`northwind`.`Orders`.`ShippedDate` between \'1997-01-01\' and \'1997-12-31\'))
