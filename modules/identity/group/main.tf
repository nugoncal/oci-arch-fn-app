# This example file shows how to create a group.

# Creating group called faas-group
resource "oci_identity_group" "faas-group" {
  name           = "faas-group"
  description    = "group created by terraform for functions"
  compartment_id = "${var.tenancy_ocid}"
}

resource "oci_identity_user_group_membership" "user-group-mem1" {
  compartment_id = "${var.tenancy_ocid}"
  user_id        = "${var.user_ocid}"
  group_id       = "${oci_identity_group.faas-group.id}"
}
