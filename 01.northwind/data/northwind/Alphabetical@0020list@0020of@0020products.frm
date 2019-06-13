TYPE=VIEW
query=select `northwind`.`Products`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Products`.`SupplierID` AS `SupplierID`,`northwind`.`Products`.`CategoryID` AS `CategoryID`,`northwind`.`Products`.`QuantityPerUnit` AS `QuantityPerUnit`,`northwind`.`Products`.`UnitPrice` AS `UnitPrice`,`northwind`.`Products`.`UnitsInStock` AS `UnitsInStock`,`northwind`.`Products`.`UnitsOnOrder` AS `UnitsOnOrder`,`northwind`.`Products`.`ReorderLevel` AS `ReorderLevel`,`northwind`.`Products`.`Discontinued` AS `Discontinued`,`northwind`.`Categories`.`CategoryName` AS `CategoryName` from (`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) where (`northwind`.`Products`.`Discontinued` = 0)
md5=3bcfc5a2ec79ce7ea30e66750a4c3e15
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT Products.*, \n       Categories.CategoryName\nFROM Categories \n   INNER JOIN Products ON Categories.CategoryID = Products.CategoryID\nWHERE (((Products.Discontinued)=0))
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Products`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName`,`northwind`.`Products`.`SupplierID` AS `SupplierID`,`northwind`.`Products`.`CategoryID` AS `CategoryID`,`northwind`.`Products`.`QuantityPerUnit` AS `QuantityPerUnit`,`northwind`.`Products`.`UnitPrice` AS `UnitPrice`,`northwind`.`Products`.`UnitsInStock` AS `UnitsInStock`,`northwind`.`Products`.`UnitsOnOrder` AS `UnitsOnOrder`,`northwind`.`Products`.`ReorderLevel` AS `ReorderLevel`,`northwind`.`Products`.`Discontinued` AS `Discontinued`,`northwind`.`Categories`.`CategoryName` AS `CategoryName` from (`northwind`.`Categories` join `northwind`.`Products` on((`northwind`.`Categories`.`CategoryID` = `northwind`.`Products`.`CategoryID`))) where (`northwind`.`Products`.`Discontinued` = 0)
