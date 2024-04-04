#!/bin/bash

set -e

if [ -z "$BOSH_TARGET" ] || [ -z "$STACK_NAME" ] || [ -z "$STEMCELL_SHA1" ] || [ -z "$STEMCELL_VERSION" ]
then
cat << EOF
  ERROR: Missing environment variable(s).
  
  Required: 

    BOSH_TARGET: The name of the bosh target alias. Example: toolingbosh.
    STACK_NAME: The name of the stack. Example: westa-hub.
    STEMCELL_SHA1: The SHA1 of the stemcell to use. 
    STEMCELL_VERSION: The version of the stemcell. Example: 1.406

  Please be sure the required environment variables are set and run this script again.
EOF
exit 1
fi

# CLONE 
workspace="$HOME/deploy/credhub"
rm -fr $workspace
mkdir -p $workspace
mkdir -p ${workspace}/cloud-gov
pushd ${workspace}/cloud-gov
    git clone https://github.com/cloud-gov/deploy-credhub.git
    cd deploy-credhub
    git checkout f140
popd

# STEMCELL 
bosh -e $BOSH_TARGET upload-stemcell --sha1 ${STEMCELL_SHA1} \
  https://bosh.io/d/stemcells/bosh-aws-xen-hvm-ubuntu-jammy-go_agent?v=${STEMCELL_VERSION}


# RELEASES 
bosh -e $BOSH_TARGET upload-release \
    --sha1 64e5f24f1592f57aed71e764888896e21e118c37 \
    "https://bosh.io/d/github.com/pivotal-cf/credhub-release?v=2.12.67"    
bosh -e $BOSH_TARGET upload-release --sha1 9c571c3463818ec1f8afe63d2da98c24381f7dda \
  "https://bosh.io/d/github.com/cloudfoundry/bpm-release?v=1.2.17"    
bosh -e $BOSH_TARGET upload-release --sha1 55b3dced813ff9ed92a05cda02156e4b5604b273 \
  "https://bosh.io/d/github.com/cloudfoundry/bosh-dns-aliases-release?v=0.0.4"


# Config 
config_dir=${workspace}/config
rm -fr $config_dir
mkdir -p $config_dir

bosh interpolate ${workspace}/cloud-gov/deploy-credhub/bosh-deployment/manifest.yml \
  --vars-store ${config_dir}/secrets.yml

aws s3 cp "s3://${STACK_NAME}-terraform-state/${STACK_NAME}/state.yml" ${config_dir}/state.yml --sse AES256
aws s3 cp "s3://${STACK_NAME}-cloud-gov-varz/${STACK_NAME}-protobosh.yml" ${config_dir}/protobosh.yml --sse AES256


pushd $workspace
  bosh -e $BOSH_TARGET deploy -d credhub cloud-gov/deploy-credhub/bosh-deployment/manifest.yml \
    -o cloud-gov/deploy-credhub/operations/production.yml \
    -l cloud-gov/deploy-credhub/variables/westa.yml \
    -l cloud-gov/deploy-credhub/variables/postgres-tls.yml \
    -l ${config_dir}/protobosh.yml \
    -l ${config_dir}/secrets.yml \
    -l ${config_dir}/state.yml
popd
