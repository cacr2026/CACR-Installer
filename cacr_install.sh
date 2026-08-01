#!/bin/bash
set -e
QE_VERSION="7.5"
INSTALL_DIR="$HOME/CACR"
SOFTWARE_DIR="$INSTALL_DIR/software"
QE_DIR="$SOFTWARE_DIR/qe-$QE_VERSION"
LOG_DIR="$INSTALL_DIR/logs"
mkdir -p "$SOFTWARE_DIR" "$LOG_DIR"
echo "=== CACR Quantum ESPRESSO Installer v1.0 ==="
grep -q Ubuntu /etc/os-release || { echo "Ubuntu not detected"; exit 1; }
ping -c1 github.com >/dev/null 2>&1 || ping -c1 google.com >/dev/null 2>&1 || { echo "No internet"; exit 1; }
sudo -v
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential gcc g++ gfortran make cmake git wget curl unzip tree pkg-config vim htop zip openmpi-bin libopenmpi-dev libopenblas-dev liblapack-dev libfftw3-dev libscalapack-openmpi-dev libelpa-dev libxc-dev libhdf5-openmpi-dev libxml2-dev
cd "$SOFTWARE_DIR"
if [ ! -d "$QE_DIR" ]; then
 wget -O qe.tar.gz https://gitlab.com/QEF/q-e/-/archive/qe-${QE_VERSION}/q-e-qe-${QE_VERSION}.tar.gz
 tar -xzf qe.tar.gz
 mv q-e-qe-${QE_VERSION} qe-${QE_VERSION}
 rm qe.tar.gz
fi
cd "$QE_DIR"
./configure > "$LOG_DIR/configure.log" 2>&1
make -j$(nproc) pwall > "$LOG_DIR/compile.log" 2>&1
for p in pw.x ph.x bands.x dos.x projwfc.x; do
 [ -f "bin/$p" ] && echo "$p : PASS" || echo "$p : FAIL"
done
echo "Done."
