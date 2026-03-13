#!/bin/bash


create_ansible_dynamic_inventory () {
    local ansible_dir=$1
    local key_path=$2
    local ip 
    echo "[app]" > "$ansible_dir/hosts.ini"
    ip=$(terraform output boris_instance_public_ip_address)
    if [[ -z $ip ]]; then 
        display_msg "⚠️ no ip address as terraform output"
    else
        echo "$(echo "$ip" | jq -r ".") ansible_user=ubuntu ansible_ssh_private_key_file=$key_path" >> "$ansible_dir/hosts.ini"
    fi
}


create_ansible_dynamic_inventory "$1" "$2"