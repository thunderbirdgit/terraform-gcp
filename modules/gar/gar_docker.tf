resource "google_artifact_registry_repository" "docker_repo" {
  location       = var.region
  repository_id = var.gar_docker_repo
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
  cleanup_policy_dry_run = true
}
