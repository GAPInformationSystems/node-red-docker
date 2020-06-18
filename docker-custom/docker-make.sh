#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

# Build with lts-slim so we have a glibc linux base image. Alpine doesn't work with SAP NWRFCSDK
export OS="lts-slim" # alpine | buster-slim | stretch-slim

# For testing local changes to node-red-contrib-saprfc
# rm -rf ./node-red-contrib-saprfc;
# cp -r ~/Documents/GitHub/node-red-contrib-saprfc ./;

git clone https://github.com/PaulWieland/node-red-contrib-saprfc.git
git clone https://github.com/SAP/node-rfc.git

#Put the nwrfc.zip file in this directory. download from https://launchpad.support.sap.com/#/softwarecenter/template/products/_APP=00200682500000001943&_EVENT=DISPHIER&HEADER=Y&FUNCTIONBAR=N&EVENT=TREE&NE=NAVIGATE&ENR=01200314690100002214&V=MAINT

# Convert it to a tar gz file so that docker ADD works correctly (zip is not supported)
unzip nwrfc750P_6-70002752.zip;
tar -czf nwrfcsdk.tar.gz nwrfcsdk;
rm -rf nwrfcsdk;
# END SAPNWRFC

docker build --no-cache \
    # --build-arg HTTP_PROXY=http://
    # --build-arg HTTPS_PROXY=http://
    --build-arg ARCH=amd64 \
    --build-arg NODE_VERSION=12 \
    --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
    --build-arg OS=$OS \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --file Dockerfile.$OS.custom \
    --tag pwieland/saprfc-node-red .;

#Cleanup from nwrfcsd zipping
rm nwrfcsdk.tar.gz;
rm -rf META-INF;
rm -rf SIGNATURE.SMF;