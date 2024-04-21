resource "google_storage_bucket" "static-site" {
  name                        = "tf-bucket-632599"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}
