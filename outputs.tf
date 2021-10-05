## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "buckets_created" {
 value = "${oci_objectstorage_bucket.bucket.name}, ${oci_objectstorage_bucket.function-output-bucket.name}"
 #"curl -X POST -u 'ADMIN:${var.dbpwd-cipher}' -H \"Content-Type: application/json\"  --data '{}' https://${substr(oci_database_autonomous_database.ADWdatabase.connection_urls[0].apex_url,8,21)}.adb.${var.region}.oraclecloudapps.com/ords/admin/soda/latest/regionsnumbers?action=query | python -m json.tool"
}