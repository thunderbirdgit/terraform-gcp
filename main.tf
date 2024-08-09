provider "google" {
  project = "nonprod-app-cluster-431611"
  region  = "us-central1"
}

module "database" {
  source = "./modules/database"
  environment = var.environment  
  region = var.region
}

module "gar" {
  source = "./modules/gar"
  project_id = var.project_id
  region = var.region
  gar_docker_repo = var.gar_docker_repo
}

module "gkecluster" {
  source = "./modules/gkecluster"
  environment = var.environment  
  region = var.region
  project_id = var.project_id
  cluster_name = var.cluster_name
  ip_range_pods_name = var.ip_range_pods_name
  ip_range_services_name = var.ip_range_services_name
  network = var.network
  subnetwork = var.subnetwork
  app_node_pool = var.app_node_pool
  desired_node_count = var.desired_node_count
}
