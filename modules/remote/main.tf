## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "null_resource" "compute-script1" {
  provisioner "file" {
    connection {
      host = var.public-ip1
      user = var.instance_user
      private_key = chomp(file(var.ssh_private_key))
    }
    source      = "scripts/"
    destination = "/tmp/"
  }
}

resource "null_resource" "app-config1" {
  depends_on = ["null_resource.compute-script1"]
  provisioner "remote-exec" {
    connection {
      host = var.public-ip1
      user = var.instance_user
      private_key = chomp(file(var.ssh_private_key))
    }

    inline = [
      "touch /tmp/temp.txt",
      "chmod +x /tmp/script1.sh",
      "sudo yes | /tmp/script1.sh > /tmp/output1.txt"
    ]
  }
}