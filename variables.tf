variable "root_vpc_name" {
  type = string
  default = "tf_vpc"
}
variable "root_private_subnet_name" {
  type = string
  default = "tf_private_subnet"
}
variable "root_public_subnet_name" {
  type = string
  default = "tf_public_subnet"
}
variable "root_private_route_table" {
  type = string
  default = "tf_private_route_table"
}
variable "root_public_route_table" {
  type = string
  default = "tf_public_route_table"
}
variable "root_igw" {
  type = string
  default = "tf_igw"
}