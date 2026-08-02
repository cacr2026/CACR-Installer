#!/bin/bash

BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {

    clear

    echo -e "${BLUE}"
    echo "=============================================================="
    echo "             CACR Research Platform"
    echo "=============================================================="
    echo -e "${NC}"

}

pause() {

    echo
    read -p "Press ENTER to continue..."

}

success() {

    echo -e "${GREEN}$1${NC}"

}

error() {

    echo -e "${RED}$1${NC}"

}

info() {

    echo -e "${YELLOW}$1${NC}"

}
