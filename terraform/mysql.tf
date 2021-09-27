data "google_secret_manager_secret_version" "root_password_sql" {
  secret = "sql-db-root-password"
}

resource "google_sql_database_instance"   "master" {
  name = "db-mysql"
  database_version = "MYSQL_5_7"
  region = var.region[0]
  settings {
    tier = "db-n1-standard-4"
    disk_size         = 50
    disk_type         = "PD_SSD"
    backup_configuration {
        enabled = "true"
        binary_log_enabled = "true"
    }
    availability_type = "REGIONAL"
    maintenance_window {
      day  = 6
      hour = 02
    }
    //ip_configuration {
      //ipv4_enabled = "false"
      //private_network = var.network
    //}
  } 
}


resource "google_sql_database" "database" {
  name = "database_name"
  instance = "${google_sql_database_instance.master.name}"
  charset = "utf8"
  collation = "utf8_general_ci"
}
resource "google_sql_user" "users" {
  name = "root"
  instance = "${google_sql_database_instance.master.name}"
  host = "%"
  password = "data.google_secret_manager_secret_version.root_password_sql.secret_data"
}