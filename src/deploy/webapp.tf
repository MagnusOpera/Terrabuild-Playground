resource "null_resource" "webapp" {
    provisioner "local-exec" {
      command = "echo '==> webapp_version = ${var.webapp_version}'"
  }
}
