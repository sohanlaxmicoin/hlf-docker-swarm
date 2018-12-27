#!/bin/bash
#
# Copyright Skcript Technologies Pvt. Ltd All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# set -ev

source ${PWD}/.env
export PATH=$PATH:${PWD}/../../bin
export FABRIC_CFG_PATH=${PWD}

# remove previous crypto material and config transactions
rm -fr config/*
rm -fr crypto-config/*
mkdir -p crypto-config config


# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate anchor peer for My Channel transaction as ORG3 Org
configtxgen -printOrg Org3MSP > ./config/org3.json
if [ "$?" -ne 0 ]; then
  echo "Failed to generate Org3 config json..."
  exit 1
fi