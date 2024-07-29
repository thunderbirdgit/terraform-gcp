module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version = "31.1.0"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}

module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                = "31.1.0"
  project_id             = var.project_id
  name                   = "${var.environment}-${var.cluster_name}"
  regional               = true
  region                 = var.region
  network                = module.gcp-network.network_name
  subnetwork             = module.gcp-network.subnets_names[0]
  ip_range_pods          = var.ip_range_pods_name
  ip_range_services      = var.ip_range_services_name
}

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "9.1.0"
  project_id   = var.project_id
  network_name = "${var.environment}-${var.network}"

  subnets = [
    {
      subnet_name   = "${var.environment}-${var.subnetwork}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${var.environment}-${var.subnetwork}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.environment}"
}

data "google_client_config" "default" {}

# Null resource to calculate desired node count
resource "null_resource" "desired_node_count" {
  triggers = {
    current_node_count = length(google_container_node_pool.default.instance_group_urls)
  }
}

# Local variable to determine desired node count
locals {
  desired_node_count = max(6, null_resource.desired_node_count.triggers.current_node_count)
}

resource "google_container_node_pool" "default" {
  name       = var.app_node_pool
  location   = var.region
  project   = var.project_id
  cluster = "${var.environment}-${var.cluster_name}"
  #node_count = 1
  #node_count = local.desired_node_count
  # Set node_count to the desired_node_count, but limit it to a maximum of 6
  node_count = var.desired_node_count > 6 ? 6 : var.desired_node_count


  node_config {
    machine_type = "e2-micro"
    disk_type = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

