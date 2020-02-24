/*
*  calling the different modules from this main file
*/

# module to create group
module "group"{
    source = "./modules/identity/group"
    tenancy_ocid = "${var.tenancy_ocid}"
    user_ocid    = "${var.user_ocid}"
}

module "policy"{
    source = "./modules/identity/policy"
    compartment_name = "${var.compartment_name}"
    group_name = "${module.group.group_name}"
    compartment_ocid = "${var.compartment_ocid}"
}

module "vcn"{
  source = "./modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
}

module "function"{
    source = "./modules/function"
    compartment_ocid = "${var.compartment_ocid}"
    subnet3_ocid = "${module.vcn.subnet3_ocid}"
}

module "compute"{
    source = "./modules/compute"
    tenancy_ocid = "${var.tenancy_ocid}"
    compartment_ocid = "${var.compartment_ocid}"
    availability_domain = "${var.availability_domain}"
    image_ocid = "${var.image_ocid}"
    instance_shape = "${var.instance_shape}"
    ssh_public_key = "${var.ssh_public_key}"
    subnet1_ocid = "${module.vcn.subnet1_ocid}"
}

module "remote-exec"{
    source = "./modules/remote"
    ssh_private_key   = "${var.ssh_authorized_private_key}"
    public-ip1        = "${module.compute.public_ip1}"
    instance_user     = "${var.instance_user}"
}