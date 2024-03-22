#!/usr/bin/env bash

set -e
set -x

(cd src && make)

for variant in jpeg jxl; do
    for kind in apk deb rpm archlinux; do
	nfpm package -p "${kind}" --config "nfpm-${variant}.yaml" --target pkg 
    done
done
