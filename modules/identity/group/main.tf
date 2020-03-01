## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# This example file shows how to create a group.

# Creating group called faas-group
resource "oci_identity_group" "faas-group" {
  name           = "faas-group"
  description    = "group created by terraform for functions"
  compartment_id = var.tenancy_ocid
}
