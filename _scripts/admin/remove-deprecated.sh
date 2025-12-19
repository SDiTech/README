#!/usr/bin/env bash

: '
Script: remove-deprecated.sh
Author: SDiTech
Subject: Remove unnecessary resources following package updates
# '

declare -A osInfo;
osInfo[/etc/redhat-release]=dnf
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]]; then
        pkgManager="${osInfo[$f]}"

        # redhat derivatives
        if [[ "$pkgManager" =~ "dnf" ]]; then
            old_kernels=($(dnf repoquery --installonly --latest-limit=-1 -q))
            if [ "${#old_kernels[@]}" -eq 0 ]; then
                echo "No old kernels found"
                exit 0
            fi

            if ! dnf remove "${old_kernels[@]}"; then
                echo "Failed to remove old kernels"
                exit 1
            fi

            echo "Removed old kernels"
            exit 0
        fi

        # debian derivatives
        if [[ "$pkgManager" =~ "apt-get" ]]; then
            # this doesn't work yet...
            echo "Attempting to remove unnecessary packages";
            apt autoremove
            exit 0

        fi
    fi
done
