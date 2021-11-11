variable "project_id" {
    type    = string
    default = "instruqt"
}

source "googlecompute" "ansible-tower" {
    project_id          = var.project_id
    source_image_family = "rhel-8"
    ssh_username        = "rhel"
    zone                = "europe-west1-b"
    machine_type        = "n1-standard-2"
    image_name          = "ansible-tower"
}


build {
    sources = ["sources.googlecompute.ansible-tower"]

    provisioner "file" {
        source = "assets/inventory"
        destination = "/tmp/inventory"
    }

    provisioner "file" {
        source = "license/tower_license.json"
        destination = "/tmp/license"
    }

    provisioner "shell" {
        inline = [
            "sudo dnf remove dnf-automatic -y",
            "sudo dnf upgrade -y",
            "sudo dnf install -y git curl vim",
            "sudo mkdir -p /etc/tower",
            "sudo mv /tmp/license /etc/tower/license",
            "sudo dnf config-manager --add-repo https://releases.ansible.com/ansible-tower/cli/ansible-tower-cli-el8.repo",
            "sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
            "sudo dnf install -y ansible postgresql ansible-tower-cli jq",
            "cd /tmp",
            "curl -sLO https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-3.7.3-1.tar.gz",
            "tar xzf ansible-tower-setup-bundle-3.7.3-1.tar.gz",
            "cd ansible-tower-setup-bundle-3.7.3-1",
            "sudo mv /tmp/inventory .",
            "sudo ./setup.sh",
        ]
    }
}

