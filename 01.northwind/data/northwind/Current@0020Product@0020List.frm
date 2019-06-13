TYPE=VIEW
query=select `northwind`.`Products`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName` from `northwind`.`Products` where (`northwind`.`Products`.`Discontinued` = 0)
md5=0bae73a76ba868df183d76c2eb774364
updatable=1
algorithm=0
definer_user=root
definer_host=%
suid=2
with_check_option=0
timestamp=2019-06-12 02:09:25
create-version=1
source=SELECT ProductID,\n       ProductName \nFROM Products \nWHERE Discontinued=0
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `northwind`.`Products`.`ProductID` AS `ProductID`,`northwind`.`Products`.`ProductName` AS `ProductName` from `northwind`.`Products` where (`northwind`.`Products`.`Discontinued` = 0)
