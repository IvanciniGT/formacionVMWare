# Proveedor de vSphere
provider "vsphere" {
  user           = var.vsphere_user          # Usuario desde las variables
  password       = var.vsphere_password      # Contraseña desde las variables
  server         = var.vsphere_server        # Servidor (vCenter o ESXi)
  allow_unverified_ssl = true                # Permitir certificados no confiables
}

# Data source para obtener información de los hosts ESXi
data "vsphere_host" "esxi" {
  for_each = toset(var.esxi_hosts)           # Itera sobre los hosts proporcionados
  name     = each.key                        # Usa el nombre del host
}

# Crear un vSwitch estándar en cada host ESXi
resource "vsphere_host_virtual_switch" "vswitch" {
  count           = length(var.esxi_hosts)   # Aplica a cada host de la lista
  host_system_id  = data.vsphere_host.esxi[var.esxi_hosts[count.index]].id
  name            = var.vswitch_name         # Nombre del vSwitch desde la variable
  mtu             = var.mtu                  # MTU configurado
}

# Crear un PortGroup asociado al vSwitch en cada host
resource "vsphere_host_port_group" "portgroup" {
  count             = length(var.esxi_hosts) # Aplica a cada host de la lista
  host_system_id    = data.vsphere_host.esxi[var.esxi_hosts[count.index]].id
  name              = var.portgroup_name     # Nombre del PortGroup desde la variable
  virtual_switch_id = vsphere_host_virtual_switch.vswitch[count.index].id
  vlan_id           = var.vlan_id            # VLAN ID configurado
}
