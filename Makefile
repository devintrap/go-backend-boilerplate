# Variables
BINARY_NAME=ekko
BUILD_DIR=bin
MAIN_PATH=cmd/main.go
ENV ?= local

# Go related variables
GOBASE=$(shell pwd)
GOBIN=$(GOBASE)/$(BUILD_DIR)

# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent

.PHONY: all build clean run test coverage fmt lint help setup

## Build:
all: clean build

build: ## Build the binary
	@echo "Building..."
	go build -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_PATH)

clean: ## Remove build related files
	@echo "Cleaning..."
	rm -rf $(BUILD_DIR)

## Run and Test:
run: ## Run the application with specified environment (default: local) - usage: make run ENV=<local|stage|prod>
	ENV=$(ENV) go run $(MAIN_PATH)

test: ## Run tests
	go test ./... -v

coverage: ## Run tests with coverage
	go test ./... -coverprofile=coverage.out
	go tool cover -html=coverage.out

## Code Quality:
fmt: ## Format the code
	go fmt ./...

lint: ## Run linter
	@if command -v golangci-lint > /dev/null; then \
		golangci-lint run; \
	else \
		echo "golangci-lint not installed"; \
		exit 1; \
	fi

## Setup:
setup: ## Initialize project with system Go version - usage: make setup NAME=<project-name>
	@if [ -z "$(NAME)" ]; then \
		echo "Error: Project name is required. Use 'make setup NAME=<project-name>'"; \
		exit 1; \
	fi
	@chmod +x scripts/setup.sh
	@./scripts/setup.sh $(NAME)

## Help:
help: ## Show this help message
	@echo "Usage:\n  make \033[36m<target>\033[0m"
	@echo "\nTargets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help