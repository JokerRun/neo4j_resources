TYPE=VIEW
query=select distinct `northwind`.`Customers`.`CustomerID` AS `CustomerID`,`northwind`.`Customers`.`CompanyName` AS `CompanyName`,`northwind`.`Customers`.`City` AS `City`,`northwind`.`Customers`.`Country` AS `Country` from (`northwind`.`Customers` join `northwind`.`Orders` on((`northwind`.`Customers`.`CustomerID` = `northwind`.`Orders`.`CustomerID`))) where (`northwind`.`Orders`.`OrderDate` between \'1997-01-01\' and \'1997-12-31\')
md5=49dd9e858945114f807799f0a9f6fbe9
updatable=0
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT DISTINCT Customers.CustomerID, \n                Customers.CompanyName, \n                Customers.City, \n                Customers.Country\nFROM Customers \n     JOIN Orders ON Customers.CustomerID = Orders.CustomerID\nWHERE Orders.OrderDate BETWEEN \'1997-01-01\' And \'1997-12-31\'
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select distinct `northwind`.`Customers`.`CustomerID` AS `CustomerID`,`northwind`.`Customers`.`CompanyName` AS `CompanyName`,`northwind`.`Customers`.`City` AS `City`,`northwind`.`Customers`.`Country` AS `Country` from (`northwind`.`Customers` join `northwind`.`Orders` on((`northwind`.`Customers`.`CustomerID` = `northwind`.`Orders`.`CustomerID`))) where (`northwind`.`Orders`.`OrderDate` between \'1997-01-01\' and \'1997-12-31\')
