ANSIBLE_DIR := ansible
SCRIPTS_DIR := scripts
CYAN_COLOR := \033[34;1m
NO_COLOR := \033[0m
COLOR_OUTPUT ?= true

.PHONY: help format plan apply build ansible
.DEFAULT_GOAL := help

help: ## shows this help
	@if [ "${COLOR_OUTPUT}" = "true" ]; then \
		CYAN="${CYAN_COLOR}"; NC="${NO_COLOR}"; \
	else \
		CYAN=""; NC=""; \
	fi; \
	grep -E "^[a-zA-Z_-]+.*: ## .*$$" ${MAKEFILE_LIST} | sort | \
	awk -v c="$$CYAN" -v n="$$NC" 'BEGIN { FS=": ##" }; { printf "%s%-20s%s%s\n", c, $$1, n, $$2 };'

format: ## format terraform configuration using fmt-validate.sh
	@./${SCRIPTS_DIR}/fmt-validate.sh


apply: ## apply terraform configuration using apply.sh script
	@./${SCRIPTS_DIR}/apply.sh
	

plan: ## show terraform execution plan
	@terraform plan

build: ## format, validate, plan and apply terraform configuration files
	@$(MAKE) format
	@$(MAKE) plan
	@$(MAKE) apply

ansible: ## create the ansible inventory
	@./${SCRIPTS_DIR}/ansible.sh ${ANSIBLE_DIR} "~/.ssh/digital-school"
	
