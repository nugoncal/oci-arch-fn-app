## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# This Terraform script provisions a compute instance

# Create Compute Instance

resource "oci_core_instance" "compute_instance1" {
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 2],"name")
  compartment_id = var.compartment_ocid
  display_name = "function-instance"
  shape = var.instance_shape
  subnet_id = var.subnet1_ocid
  fault_domain        = "FAULT-DOMAIN-1"

  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }

   source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  timeouts {
    create = "60m"
  }
}