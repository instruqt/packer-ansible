variable "project_id" {
    type    = string
    default = "instruqt"
}

source "googlecompute" "ansible" {
    project_id          = var.project_id
    source_image_family = "rhel-8"
    ssh_username        = "rhel"
    zone                = "europe-west1-b"
    machine_type        = "n1-standard-2"
    image_name          = "ansible"
}


build {
    sources = ["sources.googlecompute.ansible"]

    provisioner "shell" {
        inline = [
            "sudo dnf remove dnf-automatic -y",
            "sudo dnf upgrade -y",
            "sudo dnf install -y git curl vim",
            "sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
            "sudo dnf install -y ansible",
        ]
    }
}
