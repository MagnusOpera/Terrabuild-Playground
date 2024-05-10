resource "null_resource" "webapi" {
    provisioner "local-exec" {
      command = "echo 'webapi_version = ${var.webapi_version}' >> deploy.log"
  }
}
