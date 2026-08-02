#!/bin/bash

VERSION="0.1"

clear

while true
do

clear

echo "=============================================================="
echo "                 CACR Research Studio"
echo "                Technology Preview"
echo "                    Version 2.0a"
echo "=============================================================="
echo

echo "Available Research Modules"
echo

echo " 1. SCF Convergence Assistant        (Preview)"
echo " 2. Structural Optimization          (Coming in v2.1)"
echo " 3. Mechanical Properties            (Coming in v2.2)"
echo " 4. Electronic Properties            (Coming in v2.2)"
echo " 5. Optical Properties               (Coming in v2.3)"
echo " 6. Thermal Properties               (Coming in v2.3)"
echo
echo " 0. Return to Main Menu"
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
echo "Research Workflows"
echo

echo "1. Silicon Crystal (SCF)            [Preview]"
echo "2. Silicon Crystal (Relax)          [Coming in v2.1]"
echo "3. Band Structure Analysis          [Coming in v2.2]"
echo "4. Density of States (DOS)          [Coming in v2.2]"
echo
echo "Future Modules"
echo
echo "5. Mechanical Properties            [Coming in v2.3]"
echo "6. Optical Properties               [Coming in v2.3]"
echo "7. Thermal Properties               [Coming in v2.3]"
echo
echo "0. Back"
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
