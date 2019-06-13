TYPE=VIEW
query=select `northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Products`.`QuantityPerUnit` AS `QuantityPerUnit`,`northwind`.`Products`.`UnitsInStock` AS `UnitsInStock`,`northwind`.`Products`.`Discontinued` AS `Discontinued` from (`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) where (`northwind`.`Products`.`Discontinued` <> 1)
md5=eeb2838574050432906264c427413ad1
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT Categories.CategoryName, \n       Products.ProductName, \n       Products.QuantityPerUnit, \n       Products.UnitsInStock, \n       Products.Discontinued\nFROM Categories \n     INNER JOIN Products ON Categories.CategoryID = Products.CategoryID\nWHERE Products.Discontinued <> 1
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Categories`.`CategoryName` AS `CategoryName`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Products`.`QuantityPerUnit` AS `QuantityPerUnit`,`northwind`.`Products`.`UnitsInStock` AS `UnitsInStock`,`northwind`.`Products`.`Discontinued` AS `Discontinued` from (`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) where (`northwind`.`Products`.`Discontinued` <> 1)
