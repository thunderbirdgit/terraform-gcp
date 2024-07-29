variable "project_id" {
  description = "idme test exercise"
  type        = string
  default = "nonprod-app-cluster"
}

variable "cluster_name" {
  description = "GKE cluster"
  default     = "gke-cluster"
}

variable "environment" {
  description = "Environment for GKE cluster"
  default     = "dev"
}

variable "region" {
  description = "Region to host GKE cluster"
  default     = "us-central1"
}

variable "network" {
  description = "VPC network created to host the cluster"
  default     = "gke-network"
}

variable "subnetwork" {
  description = "Subnetwork created to host the cluster"
  default     = "app-subnet"
}

variable "ip_range_pods_name" {
  description = "Secondary ip range to use for pods"
  default     = "app-ip-range-pods"
}

variable "ip_range_services_name" {
  description = "Secondary ip range to use for services"
  default     = "app-ip-range-services"
}

variable "app_node_pool" {
  description = "Node pool to create nodes in GKE cluster"
  default = "app-node-pool"
}

variable "instance_type" {
  default = "e2-micro"
}

variable "desired_node_count" {
  description = "Desired number of nodes in the node pool"
  type        = number
  default     = 6
}

/*
variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}
*/
