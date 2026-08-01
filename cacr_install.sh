#!/bin/bash
###############################################################################
# CACR Materials Characterization Platform
# Installer Version 2.0a
#
# Centre for Advanced Computational Research (CACR)
#
# Commit 1 : Interactive Framework
###############################################################################

############################
# GLOBAL VARIABLES
############################

VERSION="2.0a"

INSTALL_DIR="$HOME/CACR"
SOFTWARE_DIR="$INSTALL_DIR/software"
LOG_DIR="$INSTALL_DIR/logs"

QE_VERSION="7.5"
QE_DIR="$SOFTWARE_DIR/qe-$QE_VERSION"

############################
# COLORS
############################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
NC='\033[0m'

############################
# UTILITY FUNCTIONS
############################

pause() {
    echo
    read -p "Press ENTER to continue..."
}

print_header() {

    clear

    echo -e "${BLUE}"
    echo "=============================================================="
    echo "      CACR Materials Characterization Platform"
    echo "                Installer Version $VERSION"
    echo "=============================================================="
    echo -e "${NC}"

}
############################
# QE HELPER FUNCTIONS
############################

check_system() {

    print_header

    echo "[1/6] Checking operating system..."

    grep -q Ubuntu /etc/os-release || {
        echo
        echo "ERROR : Ubuntu not detected."
        exit 1
    }

    echo "Ubuntu : PASS"

    echo
    echo "[2/6] Checking internet connection..."

    ping -c1 github.com >/dev/null 2>&1 || \
    ping -c1 google.com >/dev/null 2>&1 || {

        echo
        echo "ERROR : Internet connection unavailable."
        exit 1
    }

    echo "Internet : PASS"

    echo
    echo "[3/6] Checking sudo access..."

    sudo -v

    echo "sudo : PASS"

    echo

}

install_dependencies() {

    echo "[4/6] Installing required packages..."
    echo

    sudo apt update

    sudo apt install -y \
        build-essential \
        gcc \
        g++ \
        gfortran \
        make \
        cmake \
        git \
        wget \
        curl \
        unzip \
        tree \
        pkg-config \
        vim \
        htop \
        zip \
        openmpi-bin \
        libopenmpi-dev \
        libopenblas-dev \
        liblapack-dev \
        libfftw3-dev \
        libscalapack-openmpi-dev \
        libelpa-dev \
        libxc-dev \
        libhdf5-openmpi-dev \
        libxml2-dev

}

download_qe() {

    echo
    echo "[5/6] Downloading Quantum ESPRESSO..."

    mkdir -p "$SOFTWARE_DIR"

    cd "$SOFTWARE_DIR"

    if [ ! -d "$QE_DIR" ]; then

        wget -O qe.tar.gz \
https://gitlab.com/QEF/q-e/-/archive/qe-${QE_VERSION}/q-e-qe-${QE_VERSION}.tar.gz

        tar -xzf qe.tar.gz

        mv q-e-qe-${QE_VERSION} qe-${QE_VERSION}

        rm qe.tar.gz

    else

        echo
        echo "Quantum ESPRESSO source already exists."

    fi

}

configure_qe() {

    echo
    echo "Configuring Quantum ESPRESSO..."

    mkdir -p "$LOG_DIR"

    cd "$QE_DIR"

    ./configure > "$LOG_DIR/configure.log" 2>&1

}

compile_qe() {

    echo
    echo "[6/6] Compiling Quantum ESPRESSO..."

    make -j$(nproc) pwall \
        > "$LOG_DIR/compile.log" 2>&1

}

verify_qe() {

    echo
    echo "Verifying executables..."
    echo

    for exe in pw.x ph.x bands.x dos.x projwfc.x
    do

        if [ -f "bin/$exe" ]; then

            echo "✓ $exe"

        else

            echo "✗ $exe"

        fi

    done

    echo
    echo "Quantum ESPRESSO installation completed."

}
############################
# OPTION 1
############################

install_qe() {

    print_header

    echo
    echo "=============================================================="
    echo "        Quantum ESPRESSO ${QE_VERSION} Installation"
    echo "=============================================================="
    echo

    check_system

    install_dependencies

    download_qe

    configure_qe

    compile_qe

    verify_qe

    echo
    echo "=============================================================="
    echo " Quantum ESPRESSO Installation Completed Successfully"
    echo "=============================================================="
    echo

    pause

}

############################
# OPTION 2
############################

install_qe_thermopw() {

    print_header

    echo
    echo "Quantum ESPRESSO + ThermoPW"
    echo
    echo "ThermoPW will be added in Release 2.0b."
    echo

    pause

}

############################
# OPTION 3
############################

verify_installation() {

    print_header

    echo
    echo "Installation Verification"
    echo

    echo "Verification module will be added in Commit 3."

    pause

}

############################
# OPTION 4
############################

recompile_qe() {

    print_header

    echo
    echo "Recompile Quantum ESPRESSO"
    echo

    echo "Recompile module will be added in Commit 4."

    pause

}

############################
# MENU
############################

show_menu() {

while true
do

print_header

echo "1. Install Quantum ESPRESSO 7.5"
echo
echo "2. Install Quantum ESPRESSO 7.5 + ThermoPW"
echo
echo "3. Verify Existing Installation"
echo
echo "4. Recompile Quantum ESPRESSO"
echo
echo "5. Exit"

echo
read -p "Enter your choice : " choice

case $choice in

1)
install_qe
;;

2)
install_qe_thermopw
;;

3)
verify_installation
;;

4)
recompile_qe
;;

5)

echo
echo "Thank you for using CACR Installer."
echo

exit 0
;;

*)

echo
echo "Invalid choice."

sleep 2

;;

esac

done

}

############################
# MAIN
############################

main() {

mkdir -p "$LOG_DIR"

show_menu

}

main
