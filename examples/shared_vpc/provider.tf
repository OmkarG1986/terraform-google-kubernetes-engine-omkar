locals {
 terraform_service_account = "hmcp-f-dev-rqmfnd-sa-proj@hmcp-devdz-rqmfnd-de-prj-r2q.iam.gserviceaccount.com"
}

provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}

data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 project 		= "hmcp-devdz-rqmfnd-de-prj-r2q"
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
}