#!/bin/bash
#
# Copyright Skcript Technologies Pvt. Ltd All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# set -ev

source ${PWD}/.env
export PATH=$PATH:${PWD}/../../bin

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

# generate anchor peer transaction
configtxgen -profile OneOrgChannel -outputAnchorPeersUpdate ./config/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org3MSP..."
  exit 1
fi