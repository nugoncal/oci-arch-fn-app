# data "oci_functions_applications" "test_applications" {
#   #Required
#   compartment_id = "${var.compartment_ocid}"

#   #Optional
#   display_name = "example-application"
#   id           = "${oci_functions_application.test_application.id}"
#   state        = "${var.application_state}"
# }