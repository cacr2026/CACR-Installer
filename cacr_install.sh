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
###############################################################
# VERIFICATION HELPER FUNCTIONS
###############################################################

pass() {

    printf "${GREEN}%-30s PASS${NC}\n" "$1"

}

fail() {

    printf "${RED}%-30s FAIL${NC}\n" "$1"

}

info() {

    printf "${CYAN}%-30s %s${NC}\n" "$1" "$2"

}

verify_os() {

    echo
    echo "Operating System"
    echo "--------------------------------------------------------------"

    if grep -q Ubuntu /etc/os-release ; then
        VERSION=$(grep VERSION_ID /etc/os-release | cut -d'"' -f2)
        info "Ubuntu Version :" "$VERSION"
    else
        fail "Ubuntu"
    fi

}

verify_hardware() {

    echo
    echo "Hardware"
    echo "--------------------------------------------------------------"

    info "CPU :" "$(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
    info "CPU Threads :" "$(nproc)"
    info "Installed RAM :" "$(free -h | awk '/Mem:/ {print $2}')"
    info "Free Disk :" "$(df -h "$HOME" | awk 'NR==2 {print $4}')"

}

verify_compilers() {

    echo
    echo "Development Tools"
    echo "--------------------------------------------------------------"

    command -v gcc >/dev/null && info "GCC :" "$(gcc -dumpversion)" || fail "GCC"

    command -v gfortran >/dev/null && info "GFortran :" "$(gfortran -dumpversion)" || fail "GFortran"

    command -v mpirun >/dev/null && \
        info "MPI :" "$(mpirun --version | head -1)" || \
        fail "MPI"

}

verify_libraries() {

    echo
    echo "Scientific Libraries"
    echo "--------------------------------------------------------------"

    ldconfig -p | grep -q openblas && pass "OpenBLAS" || fail "OpenBLAS"

    ldconfig -p | grep -q lapack && pass "LAPACK" || fail "LAPACK"

    ldconfig -p | grep -q fftw3 && pass "FFTW3" || fail "FFTW3"

}

verify_qe() {

    echo
    echo "Quantum ESPRESSO"
    echo "--------------------------------------------------------------"

    [ -d "$QE_DIR" ] && pass "Source Directory" || fail "Source Directory"

    [ -f "$LOG_DIR/configure.log" ] && pass "configure.log" || fail "configure.log"

    [ -f "$LOG_DIR/compile.log" ] && pass "compile.log" || fail "compile.log"

    cd "$QE_DIR" 2>/dev/null || return

    for exe in pw.x ph.x bands.x dos.x projwfc.x
    do

        [ -f "bin/$exe" ] && pass "$exe" || fail "$exe"

    done

}

############################
# OPTION 3
############################

verify_installation() {

    print_header

    echo
    echo "=============================================================="
    echo "              CACR System Verification"
    echo "=============================================================="

    verify_os

    verify_hardware

    verify_compilers

    verify_libraries

    verify_qe

    echo
    echo "=============================================================="

    if [ -f "$QE_DIR/bin/pw.x" ]; then

        echo -e "${GREEN}SYSTEM STATUS : READY${NC}"

    else

        echo -e "${RED}SYSTEM STATUS : INCOMPLETE${NC}"

    fi

    echo "=============================================================="

    pause

}

###############################################################
# RECOMPILATION HELPER FUNCTIONS
###############################################################

clean_source() {

    echo
    echo "Checking Quantum ESPRESSO source..."

    if [ ! -d "$QE_DIR" ]; then

        echo
        echo "ERROR : Quantum ESPRESSO source directory not found."
        echo

        return 1

    fi

    cd "$QE_DIR"

    echo
    echo "Source directory found."
    echo

    echo "Choose recompilation mode:"
    echo
    echo "1. Incremental rebuild (Faster)"
    echo "2. Clean rebuild (Recommended)"
    echo

    read -p "Enter your choice : " rebuild

    case $rebuild in

        1)

            echo
            echo "Incremental rebuild selected."

            ;;

        2)

            echo
            echo "Running make veryclean..."

            make veryclean

            ;;

        *)

            echo
            echo "Invalid choice."

            return 1

            ;;

    esac

}

compile_engine() {

    echo
    echo "Configuring Quantum ESPRESSO..."

    ./configure > "$LOG_DIR/configure.log" 2>&1

    echo
    echo "Compiling Quantum ESPRESSO..."

    make -j$(nproc) pwall > "$LOG_DIR/compile.log" 2>&1

    echo
    echo "Compilation finished."

}

verify_recompile() {

    echo
    echo "Verifying executables..."
    echo

    verify_qe

}

############################
# OPTION 4
############################

recompile_qe() {

    print_header

    echo
    echo "=============================================================="
    echo "             Quantum ESPRESSO Recompilation"
    echo "=============================================================="

    clean_source || {

        pause
        return

    }

    compile_engine

    verify_recompile

    echo
    echo "=============================================================="

    if [ -f "$QE_DIR/bin/pw.x" ]; then

        echo -e "${GREEN}Recompilation completed successfully.${NC}"

    else

        echo -e "${RED}Recompilation failed.${NC}"

    fi

    echo "=============================================================="

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
