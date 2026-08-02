#!/bin/bash

source "$(dirname "$0")/common.sh"

THERMOPW_VERSION="2.1.1"
QE_DIR="$HOME/CACR/software/qe-7.5"
THERMOPW_DIR="$QE_DIR/thermo_pw"

print_header

echo
info "ThermoPW Installation Module"
echo
echo "Version : $THERMOPW_VERSION"
echo

############################################################
# Check Quantum ESPRESSO
############################################################

info "Checking Quantum ESPRESSO installation..."

if [ ! -d "$QE_DIR" ]; then
    error "Quantum ESPRESSO installation not found."
    pause
    exit 1
fi

success "Quantum ESPRESSO detected."
echo "Location : $QE_DIR"
echo

############################################################
# Check / Download ThermoPW
############################################################

info "Checking ThermoPW..."

if [ ! -d "$THERMOPW_DIR" ]; then

    info "Downloading ThermoPW..."

    cd "$QE_DIR" || exit 1

    git clone https://github.com/dalcorso/thermo_pw.git

    if [ $? -ne 0 ]; then
        error "Failed to download ThermoPW."
        pause
        exit 1
    fi

    success "ThermoPW downloaded successfully."

else

    success "ThermoPW already exists."

fi

echo

############################################################
# Integrate with QE
############################################################

info "Integrating ThermoPW with Quantum ESPRESSO..."

cd "$THERMOPW_DIR" || exit 1

make join_qe
echo
info "Configuring Quantum ESPRESSO..."

cd "$QE_DIR" || exit 1

./configure

if [ $? -eq 0 ]; then

    success "Configuration completed successfully."
echo
info "Compiling ThermoPW..."

CORES=$(nproc)

echo "Using $CORES CPU cores..."

make thermo_pw -j"$CORES"

if [ $? -eq 0 ]; then

    success "ThermoPW compiled successfully."

else

    error "ThermoPW compilation failed."

    pause

    exit 1

fi

echo
else

    error "Configuration failed."

    pause

    exit 1

fi

echo
if [ $? -eq 0 ]; then
    success "ThermoPW integrated successfully."
else
    error "ThermoPW integration failed."
    pause
    exit 1
fi

echo
pause
