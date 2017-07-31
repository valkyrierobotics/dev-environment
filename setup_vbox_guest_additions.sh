#!/usr/bin/env bash

set -e
set -u

export DEBIAN_FRONTEND=noninteractive

# Install the kernel sources before the guest additions to guarantee that
# we can compile the kernel module.
apt-get install -q -y linux-headers-amd64
