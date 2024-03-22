#!/usr/bin/env bash

function nfpm() {
	nfpm -- $*
}

(cd src && make)

for variant in jpeg jxl; do
    for kind in apk deb rpm archlinux; do
	nfpm package -p "${kind}" --target -f "nfpm-${variant}.yaml" pkg 
    done
done
