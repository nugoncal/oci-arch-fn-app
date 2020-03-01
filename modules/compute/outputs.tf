## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Output variables from created compute instance

output "instance_ocid1" {
  value = oci_core_instance.compute_instance1.id
}

output "public_ip1" {
  value = oci_core_instance.compute_instance1.public_ip
}

output "private_ip1" {
  value = oci_core_instance.compute_instance1.private_ip
}