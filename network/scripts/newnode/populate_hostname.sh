#!/bin/bash

set -ev

ENV_LOCATION=$PWD/.env
echo $ENV_LOCATION
source $ENV_LOCATION

FLAG="-i"
ARCH=$(uname)
if [ "$ARCH" == "Linux" ]; then
  FLAG="-i"
elif [ "$ARCH" == "Darwin" ]; then
  FLAG="-it"
fi


# ORG4
ORG4_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org4.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME/g" $ORDERER3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME/g" $PEER_ORG4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME/g" $SERVICE_ORG4_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG4_CA_PATH#g" $SERVICE_ORG4_COMPOSE_PATH



if [ "$ARCH" == "Darwin" ]; then
  rm */**.ymlt
fi
