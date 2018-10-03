#!/bin/bash

# Exit on first error, print all commands.
set -ev

docker-compose.exe -f composer/docker-compose.yml down
docker-compose.exe -f composer/docker-compose.yml up -d 

# wait for Hyperledger Fabric to start
sleep 5

# Create the channel
docker exec peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c composerchannel -f /etc/hyperledger/configtx/composer-channel.tx

# Join peer to the channel.
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b composerchannel.block
docker exec peer0.org1.example.com mv composerchannel.block /etc/hyperledger/configtx

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" \
    peer1.org1.example.com peer channel join -b \
    /etc/hyperledger/configtx/composerchannel.block

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" \
    peer2.org1.example.com peer channel join -b \
    /etc/hyperledger/configtx/composerchannel.block