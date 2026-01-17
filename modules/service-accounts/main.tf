resource "google_service_account" "this" {
    for_each = var.service_account

    project = var.project_id
    account_id = each.value.account_id
    display_name = each.value.account_id
  
}