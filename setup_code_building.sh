#!/usr/bin/env bash

set -e
set -u

export DEBIAN_FRONTEND=noninteractive

readonly PKGS=(
  ssh-askpass
  clang-3.6
  clang-format-3.5
  gfortran
  git
  libblas-dev
  liblapack-dev
  libpython3-dev
  libpython-dev
  python3
  python3-matplotlib
  python3-numpy
  python3-scipy
  python-matplotlib
  python-scipy
  resolvconf
  ruby
  unzip
)

# Set up the backports repo.
cat > /etc/apt/sources.list.d/backports.list <<EOT
deb http://http.debian.net/debian jessie-backports main
EOT

# Set up the LLVM repo.
cat > /etc/apt/sources.list.d/llvm-3.6.list <<EOT
deb  http://llvm.org/apt/jessie/ llvm-toolchain-jessie-3.6 main
deb-src  http://llvm.org/apt/jessie/ llvm-toolchain-jessie-3.6 main
EOT

# Enable user namespace for sandboxing.
cat > /etc/sysctl.d/99-enable-user-namespaces.conf <<EOT
kernel.unprivileged_userns_clone = 1
EOT

# Accept the LLVM GPG key so we can install their packages.
wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

# Install all the packages that we need/want.
apt-get update
for pkg in "${PKGS[@]}"; do
  apt-get install -y -f --force-yes "$pkg"
done

mkdir /tmp/image-making/ -p
wget -qO /tmp/image-making/installer.sh https://github.com/bazelbuild/bazel/releases/download/0.5.2/bazel-0.5.2-installer-linux-x86_64.sh
bash /tmp/image-making/installer.sh && rm -r /tmp/image-making
