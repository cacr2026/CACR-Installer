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
# OPTION 1
############################

install_qe() {

    print_header

    echo
    echo "Quantum ESPRESSO installation"
    echo
    echo "This feature will be activated in Commit 2."
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
