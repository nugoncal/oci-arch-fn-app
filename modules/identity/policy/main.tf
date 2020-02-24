/*
 * This example file shows how to define policies for the compartment
 */

resource "oci_identity_policy" "faas-demo-policy" {
  name           = "faas-demo-policy"
  description    = "policy created by terraform for functions"
  compartment_id = "${var.compartment_ocid}"

  statements = ["Allow group ${var.group_name} to manage all-resources in compartment ${var.compartment_name}",
                "Allow service FaaS to read repos in tenancy",
                "Allow service FaaS to use virtual-network-family in compartment ${var.compartment_name}",
                "Allow group PowerUsers to manage repos in tenancy",
                "Allow group ${var.group_name} to manage repos in tenancy",
                "Allow group ${var.group_name} to manage functions-family in compartment ${var.compartment_name}",
                "Allow group ${var.group_name} to manage vnics in compartment ${var.compartment_name}",
                "Allow group ${var.group_name} to inspect subnets in compartment ${var.compartment_name}",
  ]
}