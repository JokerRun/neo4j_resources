TYPE=VIEW
query=select `northwind`.`Orders`.`ShippedDate` AS `ShippedDate`,`northwind`.`Orders`.`OrderID` AS `OrderID`,`Order Subtotals`.`Subtotal` AS `Subtotal` from (`northwind`.`Orders` join `northwind`.`Order Subtotals` on((`northwind`.`Orders`.`OrderID` = `Order Subtotals`.`OrderID`))) where (`northwind`.`Orders`.`ShippedDate` is not null)
md5=c9d3f1f6e42e6b5e8d5273d6a3a40a09
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT      Orders.ShippedDate, \n            Orders.OrderID, \n `Order Subtotals`.Subtotal\nFROM Orders \n     INNER JOIN `Order Subtotals` ON Orders.OrderID = `Order Subtotals`.OrderID\nWHERE Orders.ShippedDate IS NOT NULL
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Orders`.`ShippedDate` AS `ShippedDate`,`northwind`.`Orders`.`OrderID` AS `OrderID`,`Order Subtotals`.`Subtotal` AS `Subtotal` from (`northwind`.`Orders` join `northwind`.`Order Subtotals` on((`northwind`.`Orders`.`OrderID` = `Order Subtotals`.`OrderID`))) where (`northwind`.`Orders`.`ShippedDate` is not null)
