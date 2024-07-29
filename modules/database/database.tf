
resource "google_sql_database_instance" "postgres" {
  name             = "${var.environment}-postgres-db-instance"
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-f1-micro"  # Free tier eligible
  }
}

resource "google_sql_database" "my_database" {
  name     = "${var.environment}-hw-api-db"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "users" {
  name     = "${var.environment}_api_db_creds"
  instance = google_sql_database_instance.postgres.name
  password = data.google_secret_manager_secret_version.db_password.secret_data
}

data "google_secret_manager_secret_version" "db_password" {
  secret = "${var.environment}_api_db_creds"
}

