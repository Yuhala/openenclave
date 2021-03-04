#!/usr/bin/env bash

# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.

set -o errexit

DIR=$(dirname "$0")

if which yum > /dev/null; then
    yum install git python3-pip -y
elif which apt-get > /dev/null; then
    echo "Checking for dpkg locks..."
    while fuser /var/lib/dpkg/lock > /dev/null 2>&1 || fuser /var/lib/dpkg/lock-frontend > /dev/null 2>&1; do
        sleep 1
    done
    apt-get update
    apt-get install libssl-dev libffi-dev python3-pip -y
else
    echo "ERROR: Only these package managers are supported: yum, apt-get"
    exit 1
fi

pip3 install -U -r "$DIR/requirements.txt"
