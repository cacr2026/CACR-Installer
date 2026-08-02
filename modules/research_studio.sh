#!/bin/bash

VERSION="0.1"

clear

while true
do

clear

echo "=============================================================="
echo "                 CACR Research Studio"
echo "                     Version $VERSION"
echo "=============================================================="
echo
echo "Available Modules"
echo
echo " 1. SCF Convergence Assistant"
echo " 2. Structural Optimization"
echo " 3. Mechanical Properties"
echo " 4. Electronic Properties"
echo " 5. Optical Properties"
echo " 6. Thermal Properties"
echo
echo " 0. Exit"
echo

read -p "Select Module : " module

case $module in

1)

echo
echo "SCF Convergence Assistant"
echo
echo "This module will be implemented next."
echo
read -p "Press ENTER to continue..."
;;

2|3|4|5|6)

echo
echo "Coming in future releases."
echo
read -p "Press ENTER to continue..."
;;

0)

exit 0
;;

*)

echo
echo "Invalid selection."
sleep 2
;;

esac

done
