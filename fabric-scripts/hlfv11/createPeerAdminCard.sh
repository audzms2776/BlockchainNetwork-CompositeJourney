#!/bin/bash

echo
# check that the composer command exists at a version >v0.15
if hash composer 2>/dev/null; then
    composer --version | awk -F. '{if ($2<17) exit 1}'
    if [ $? -eq 1 ]; then
        echo 'Sorry, Use createConnectionProfile for versions before v0.15.0' 
        exit 1
    else
        echo Using composer-cli at $(composer --version)
    fi
else
    echo 'Need to have composer-cli installed at v0.16 or greater'
    exit 1
fi
# need to get the certificate 

PRIVATE_KEY=composer/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/f18f967dd9ae9dfaa8e51502f56d22b16798bd32ba010b6ecaac2b7bf242f616_sk
CERT=composer/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/Admin@org1.example.com-cert.pem

if [ "${NOIMPORT}" != "true" ]; then
    CARDOUTPUT=/tmp/PeerAdmin@hlfv1.card
else
    CARDOUTPUT=PeerAdmin@hlfv1.card
fi

composer card create -p conn1.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin --file $CARDOUTPUT
#composer card create -p /tmp/.connection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin --file /tmp/PeerAdmin@hlfv1.card


if [ "${NOIMPORT}" != "true" ]; then
    if composer card list -c PeerAdmin@hlfv1 > /dev/null; then
        composer card delete --card PeerAdmin@hlfv1
    fi

    composer card import --file /tmp/PeerAdmin@hlfv1.card 
    composer card list
    echo "Hyperledger Composer PeerAdmin card has been imported"
    rm /tmp/PeerAdmin@hlfv1.card
else
    echo "Hyperledger Composer PeerAdmin card has been created"
fi
