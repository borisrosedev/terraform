#!/bin/bash 

# shellcheck disable=SC1091
source "$(dirname "$0")/constants.sh"
source "$(dirname "$0")/utils.sh"


validate_terraform_files() {
    display_msg "🚀 Terraform configuration validation has started ..."
    if terraform validate; then
        display_msg "✅ Terraform files's configuration validated"
    else
        display_msg "❌ terraform files's configuration not validated"
    fi

}

format_terraform_files() {
    display_msg "🚀 Terraform Linting has started ..."
    local fmt_result
    fmt_result=$(terraform fmt)
    if [[ -z $fmt_result ]]; then 
        display_msg "✅ Your terraform files are formated"
        validate_terraform_files
    else
        display_msg "❌ error of format"
    fi
}


format_terraform_files
   
