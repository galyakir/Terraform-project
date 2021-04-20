## network module
This module will create vpc, 3 subnets, internet_gateway and route_table. 



**To use this module you must provide:**

`vpc_cidr` :  string of vpc cidr

`subnets_cidr` : list of 3 subnets cidr 

`tag_name` : string of tag name

`availability_zones` : list of 3 availability zones

**Module output:**

`app_vpc` : vpc

`subnet1,2,3` : subnets 1,2,3 

`db_subnet` : DB subnet




