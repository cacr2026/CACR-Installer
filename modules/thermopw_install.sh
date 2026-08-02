#!/bin/bash

source "$(dirname "$0")/common.sh"

THERMOPW_VERSION="2.1.1"

print_header

echo
info "ThermoPW Installation Module"
echo

echo "Version : $THERMOPW_VERSION"
echo

echo "Checking Quantum ESPRESSO installation..."

QE_DIR="$HOME/CACR/software/qe-7.5"

if [ -d "$QE_DIR" ]; then

    success "Quantum ESPRESSO detected."
echo
info "Checking ThermoPW..."

THERMOPW_DIR="$QE_DIR/thermo_pw"

if [ -d "$THERMOPW_DIR" ]; then

    success "ThermoPW already exists."

else

    info "Downloading ThermoPW..."

    cd "$QE_DIR" || exit 1

    git clone https://github.com/dalcorso/thermo_pw.git

    if [ $? -eq 0 ]; then

        success "ThermoPW downloaded successfully."

    else

        error "Failed to download ThermoPW."

        pause

        exit 1

    fi

fi
    echo
    echo "Location : $QE_DIR"

else

    error "Quantum ESPRESSO installation not found."

    pause

    exit 1

fi

echo

pause
