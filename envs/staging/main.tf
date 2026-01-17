provider "google" {
    project = var.project_id 
    region = var.region
}


module "service_account" {
    source = "../../modules/service-accounts"
    project_id = var.project_id
    service_account = var.service_account
}


module "node-iam" {
    source = "../../modules/node-iam"

    project_id            = var.project_id
    service_account_email = module.service_account.service_account_emails[var.node_service_account_key]
    roles                 = var.node_service_account_roles
}