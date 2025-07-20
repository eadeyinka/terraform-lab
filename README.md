# terraform-lab

# GCP Terraform Resource Provisioning

## Project Overview
To demonstrate proficiency in IaC (terraform) by creating more resources on GCP 

##  Tools & Technologies Used
- Terraform
- Google Cloud Platform (GCP)
- Visual Studio code
  
## 📂 File Structure
| File            | Description                                      |
|-----------------|--------------------------------------------------|
| `vpc.tf`        | Manages VPC subnets and firewall rules          |
| `vm.tf`         | Provisions Compute Engine VM instances          |
| `bucket.tf`     | Creates cloud storage buckets                   |
| `db-instance.tf`| Provisions MySQL and PostgreSQL database instances |

## Provisioned Resources
### VPC & Subnets
resource "google_compute_network" "vpc-network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}



resource "google_compute_subnetwork" "subnet1" {
  name          = "my-subnet-1"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc-network.id
}



resource "google_compute_subnetwork" "subnet2" {
  name          = "my-subnet-2"
  ip_cidr_range = "10.0.1.0/24"
  region        = "southamerica-west1"
  network       = google_compute_network.vpc-network.id
}



resource "google_compute_subnetwork" "subnet3" {
  name          = "my-subnet-3"
  ip_cidr_range = "10.0.2.0/24"
  region        = "northamerica-south1"
  network       = google_compute_network.vpc-network.id
}



resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = google_compute_network.vpc-network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "allow-https"
  network = google_compute_network.vpc-network.id

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

### ✅ VM Instances
resource "google_compute_instance" "test-vm1" {
  name         = "my-vm-1"
  machine_type = "e2-micro"          
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet1.id

    access_config {  
    }
  }
}



resource "google_compute_instance" "test-vm2" {
  name         = "my-vm-2"
  machine_type = "e2-micro"        
  zone         = "southamerica-west1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.id

    access_config {  
    }
  }
}



resource "google_compute_instance" "test-vm3" {
  name         = "my-vm-3"
  machine_type = "e2-micro"          
  zone         = "northamerica-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet3.id

    access_config {  
    }
  }
}

### ✅ Storage Buckets
resource "google_storage_bucket" "gcp-bucket1" {
  name     = "nexedge-bucket-ayo1234"
  location = "US"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}



resource "google_storage_bucket" "gcp-bucket2" {
  name     = "nexedge-bucket-ayo2345"
  location = "EU"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}



resource "google_storage_bucket" "gcp-bucket3" {
  name     = "nexedge-bucket-ayo3456"
  location = "ASIA"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

### ✅ Databases
resource "google_sql_database_instance" "mysql_instance_1" {
  name             = "mysql-db-1"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = false
}



resource "google_sql_database_instance" "mysql_instance_2" {
  name             = "mysql-db-2"
  region           = "southamerica-west1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = false
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-db-3"
  region           = "northamerica-south1"
  database_version = "POSTGRES_15"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = false
}

## Deployment
terraform init
terraform plan
terraform apply
