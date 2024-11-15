# Lista de hosts ESXi donde se configurará el vSwitch y PortGroup
variable "esxi_hosts" {
  description = "Lista de nombres o direcciones IP de los hosts ESXi"
  type        = list(string)
}

# Nombre del vSwitch estándar
variable "vswitch_name" {
  description = "Nombre del vSwitch estándar que se creará"
  type        = string
  default     = "vSwitch_Custom"
}

# Nombre del PortGroup
variable "portgroup_name" {
  description = "Nombre del PortGroup que se asociará al vSwitch"
  type        = string
  default     = "PortGroup_Custom"
}

# VLAN ID del PortGroup
variable "vlan_id" {
  description = "VLAN ID para el PortGroup (0 significa sin VLAN)"
  type        = number
  default     = 0
}

# Credenciales de acceso a vSphere/ESXi
variable "vsphere_user" {
  description = "Usuario para autenticarse en vSphere o ESXi"
  type        = string
}

variable "vsphere_password" {
  description = "Contraseña para autenticarse en vSphere o ESXi"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "IP o FQDN del servidor vCenter o host ESXi"
  type        = string
}

# Configuración adicional para la red
variable "mtu" {
  description = "Tamaño de MTU para el vSwitch"
  type        = number
  default     = 1500
}
