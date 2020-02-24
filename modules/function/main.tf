resource "oci_functions_application" "test_application" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name   = "cloud-events-demo"
  subnet_ids     = ["${var.subnet3_ocid}"]
}