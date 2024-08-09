variable "region" {
  description = "The region for the database instance"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gar_docker_repo" {
  description = "Google Artifact Registry Repo name"
  type = string
}
