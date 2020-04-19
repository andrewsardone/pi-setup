SHELL := /bin/bash

default: help

PHONY: install
install: ## Install the various Docker-managed services into systemd
	for file in */*.service; do sudo systemctl enable "$$PWD/$$file"; done

# via https://gist.github.com/prwhite/8168133
help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
