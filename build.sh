#!/usr/bin/env bash

set -e
set -x

(cd src && make)

rm pkg/*

for variant in jpeg jxl; do
    for kind in apk deb rpm archlinux; do
	nfpm package -p "${kind}" --config "nfpm-${variant}.yaml" --target pkg 
    done
done

# for file in pkg/*.apk; do
#     curl --user cadey:$GITEA_TOKEN \
#          --upload-file $file \
#          https://tulpa.dev/api/packages/testuser/alpine/any/main
# done

for file in pkg/*.deb; do
    curl --user cadey:$GITEA_TOKEN \
         --upload-file $file \
         https://tulpa.dev/api/packages/Techaro/debian/pool/any/wallpapers/upload
done

for file in pkg/*.rpm; do
    curl --user cadey:$GITEA_TOKEN \
         --upload-file $file \
         https://tulpa.dev/api/packages/Techaro/rpm/upload
done
