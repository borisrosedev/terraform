#!/bin/bash 


# shellcheck disable=SC1091
source "$(dirname "$0")/constants.sh"
source "$(dirname "$0")/utils.sh"

apply_terraform_configuration () {
    display_msg "🚀 Applying terraform configuration ..."
    if terraform apply; then 
        echo "✅ Terraform Configuration applied"
    else
        display_msg "❌ Terraform Configuration not applied"
    fi
}


plan_terraform_configuration () {
    display_msg "🚀 Terraform configuration plan has started ..."
    if terraform plan; then 
        display_msg "✅ Terraform configuration plan has been done successfully"
        apply_terraform_configuration
    else
        display_msg "❌ Terraform configuration plan has failed"
    fi
}


apply_terraform_configuration