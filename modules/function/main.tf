## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_functions_application" "test_application" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "cloud-events-demo"
  subnet_ids     = [var.subnet2_ocid]
}