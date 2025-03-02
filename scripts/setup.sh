#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo -e "${RED}Error: Go is not installed${NC}"
    echo "Please install Go from https://golang.org/doc/install"
    exit 1
fi

PROJECT_NAME=$1
SYSTEM_GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Project name is required${NC}"
    echo "Usage: ./scripts/setup.sh <project-name>"
    exit 1
fi

echo -e "${BLUE}Setting up project: ${GREEN}$PROJECT_NAME${NC}"
echo -e "${BLUE}Using system Go version: ${GREEN}$SYSTEM_GO_VERSION${NC}"

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo -e "${RED}Error: go.mod not found${NC}"
    exit 1
fi

# Update go.mod with new module name and Go version
echo -e "${BLUE}Updating go.mod...${NC}"
# Create temporary file
awk -v proj="$PROJECT_NAME" -v ver="$SYSTEM_GO_VERSION" '
    NR==1 { print "module " proj; next }
    $1=="go" { print "go " ver; next }
    { print }
' go.mod > go.mod.tmp && mv go.mod.tmp go.mod

# Update import path in main.go
sed -i "s|\".*/internal/config\"|\"${PROJECT_NAME}/internal/config\"|" cmd/main.go

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${BLUE}Project renamed to: ${GREEN}$PROJECT_NAME${NC}"

# Verify changes
echo -e "\n${BLUE}Current go.mod content:${NC}"
cat go.mod