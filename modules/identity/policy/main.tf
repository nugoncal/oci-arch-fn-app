## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

/*
 * This example file shows how to define policies for the compartment
 */

resource "oci_identity_policy" "faas-demo-policy" {
  name           = "faas-demo-policy"
  description    = "policy created by terraform for functions"
  compartment_id = var.compartment_ocid

  statements = ["Allow group ${var.group_name} to manage all-resources in tenancy",
                "Allow service FaaS to read repos in tenancy",
                "Allow service FaaS to use virtual-network-family in tenancy",
                "Allow group ${var.group_name} to manage repos in tenancy",
                "Allow group ${var.group_name} to manage functions-family in tenancy",
                "Allow group ${var.group_name} to manage vnics in tenancy",
                "Allow group ${var.group_name} to inspect subnets in tenancy",
  ]
}