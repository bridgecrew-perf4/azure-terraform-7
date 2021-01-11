resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  addon_profile {
    aci_connector_linux {
      enabled     = false
      subnet_name = azurerm_subnet.aci.name
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
    }
  }

  # (Optional) The IP ranges to whitelist for incoming traffic to the masters.
  # api_server_authorized_ip_ranges { }

  auto_scaler_profile {
    balance_similar_node_groups      = false
    max_graceful_termination_sec     = 600
    scale_down_delay_after_add       = "10m"
    scale_down_delay_after_delete    = "10s"
    scale_down_delay_after_failure   = "3m"
    scan_interval                    = "10s"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "20m"
    scale_down_utilization_threshold = 0.5
  }

  default_node_pool {
    name                = var.node_pool_name
    min_count           = var.min_node_count
    max_count           = var.max_node_count
    vm_size             = var.node_pool_vm_size
    enable_auto_scaling = true
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
        managed = true
    }

  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}
