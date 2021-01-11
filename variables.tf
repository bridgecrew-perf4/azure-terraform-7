variable "resource_group_name" {
  type    = string
  default = "rg-aks-centralus"
}
variable "location" {
  type    = string
  default = "centralus"
}
variable "cluster_name" {
  type    = string
  default = "aks-centralus"
}
variable "dns_prefix" {
  type    = string
  default = "kubernet"
}

variable "node_pool_name" {
  type    = string
  default = "default"
}
variable "min_node_count" {
  type    = number
  default = 1
}
variable "max_node_count" {
  type    = number
  default = 2
}
variable "node_pool_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "tags" {
  type = map
  default = {
    "Environment" : "Production"
  }
}
