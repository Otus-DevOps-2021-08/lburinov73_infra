terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "lburinov73-terraform"
    region                      = "ru-central1"
    key                         = "terraform.tfstate.prod"
    shared_credentials_file     = "./.credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
