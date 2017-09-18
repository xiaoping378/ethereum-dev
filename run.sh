#!/bin/sh
set -e
set -x

[ ! -d /root/.ethereum/geth/chaindata ] && geth init /config/genesis.json

[ $RPC ] && RPCOPT="--rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi eth,net,web3,admin,personal"

[ $WS ] && WSOPT="--ws --wsaddr 0.0.0.0"

[ $SINGER ] && MINE="--mine --etherbase $ACCOUNT --unlock $ACCOUNT --password /config/password"

[ $NETWORKID ] && NETWORK="--networkid $NETWORKID"

ENODE=`bootnode --nodekey=/home/boot.key -writeaddress`
BOOTNODEIP=`getent hosts bootnode | awk '{ print $1 }'`
BOOTNODE="--bootnodes enode://$ENODE@[$BOOTNODEIP]:30301"

KEYSTORE=/root/.ethereum/keystore
cp /config/keystore/* $KEYSTORE

geth \
    $RPCOPT  --rpccorsdomain "*" \
    $WSOPT \
    $MINE \
    $NETWORK \
    $BOOTNODE \
    --verbosity $LOGGING_LEVEL
