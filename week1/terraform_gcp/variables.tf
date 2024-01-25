variable "credentials" {
    description = "My Credentials"
    default = "./keys/civil-charmer-410021-379ae1cf2cb3.json"
}
variable "project" {
    description = "Project"
    default = "civil-charmer-410021"
}

variable "region" {
    description = "Region"
    default = "us-central1"
}

variable "location" {
    description = "Project Location"
    default = "US"
}

variable "bq_dataset_name" {
    description = "My BigQuery Dataset Name"
    default = "demo_dataset"
}

variable "gcs_bucket_name" {
    description = "My Storage Bucket Name"
    default = "civil-charmer-410021-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default = "STANDARD"
}