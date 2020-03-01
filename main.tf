## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

/*
*  calling the different modules from this main file
*/

# module to create group
module "group"{
    source = "./modules/identity/group"
    tenancy_ocid = var.tenancy_ocid
    user_ocid    = var.user_ocid
}

module "policy"{
    source = "./modules/identity/policy"
    group_name          = module.group.group_name
    compartment_ocid    = var.compartment_ocid
}

module "vcn"{
  source = "./modules/vcn"
  tenancy_ocid      = var.tenancy_ocid
  compartment_ocid  = var.compartment_ocid
}

module "function"{
    source = "./modules/function"
    compartment_ocid    = var.compartment_ocid
    subnet2_ocid        = module.vcn.subnet2_ocid
}

module "compute"{
    source = "./modules/compute"
    tenancy_ocid          = var.tenancy_ocid
    compartment_ocid      = var.compartment_ocid
    availability_domain   = var.availability_domain
    instance_shape        = var.instance_shape
    ssh_public_key        = var.ssh_public_key
    subnet1_ocid          = module.vcn.subnet1_ocid
    instance_os           = var.instance_os
    linux_os_version      = var.linux_os_version
}

module "remote-exec"{
    source = "./modules/remote"
    ssh_private_key   = var.ssh_private_key
    public-ip1        = module.compute.public_ip1
    instance_user     = var.instance_user
}