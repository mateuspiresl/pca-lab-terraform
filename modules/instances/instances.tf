resource "google_compute_instance" "tf-instance-1" {
  name                      = "tf-instance-1"
  machine_type              = "e2-standard-2"
  allow_stopping_for_update = true

    metadata_startup_script = <<-EOT
#!/bin/bash
EOT

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "tf-vpc-445771"
    subnetwork = "subnet-01"
  }
}

resource "google_compute_instance" "tf-instance-2" {
  name                      = "tf-instance-2"
  machine_type              = "e2-standard-2"
  allow_stopping_for_update = true

  metadata_startup_script = <<-EOT
#!/bin/bash
EOT

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "tf-vpc-445771"
    subnetwork = "subnet-02"
  }
}
