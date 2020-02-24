# Output variables from created group

output "group_name" {
  value = "${oci_identity_group.faas-group.name}"
}