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

while true
do

clear

echo "=============================================================="
echo "           SCF Convergence Assistant"
echo "=============================================================="
echo
echo "Official Quantum ESPRESSO Examples"
echo
echo "1. Silicon (SCF)"
echo "2. Silicon (Relax)"
echo "3. Silicon (Band Structure)"
echo "4. Silicon (Density of States)"
echo
echo "0. Back"
echo

read -p "Select Example : " example

case $example in

1)

echo
echo "Silicon SCF selected."
echo
read -p "Press ENTER to continue..."
;;

2|3|4)

echo
echo "This example will be available soon."
echo
read -p "Press ENTER to continue..."
;;

0)

break
;;

*)

echo
echo "Invalid selection."
sleep 2
;;

esac

done
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
