variable "region" {
  description = "The region for the database instance"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

variable "ip_range_pods_name" {
  description = "Range of IPs for pods"
  type = string
}

variable "ip_range_services_name" {
  description = "Range of IPs for service names"
  type = string
}

variable "network" {
  description = "Network range"
  type = string
}

variable "subnetwork" {
  description = "Sub Network range"
  type = string
}

variable "app_node_pool" {
  description = "Node pool for apps"
  type = string
}

variable "desired_node_count" {
  description = "Desired node count"
  type = number
}
