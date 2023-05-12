output "connection_strings" {
  value = mongodbatlas_cluster.data.connection_strings.0.standard_srv
}