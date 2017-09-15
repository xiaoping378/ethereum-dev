#!/bin bash
set -e
set -x

[ ! -d /root/.ethereum/geth/chaindata ] && geth init /config/genesis.json
[ $RPC ] && RPCOPT="--rpc --rpccorsdomain \"*\" --rpcapi $RPCAPI"

[ $SINGER ] && MINE="--mine"
[ $SINGER ] && ETHERBASE_UNLOCK_PASSWORD="--etherbase $ACCOUNT --unlock $ACCOUNT --password /config/password"

[ $NETWORKID ] && NETWORK="--networkid $NETWORKID"

ENODE=`bootnode --nodekey=/home/boot.key -writeaddress`
BOOTNODEIP=`getent hosts bootnode | awk '{ print $1 }'`
BOOTNODE="--bootnodes enode://$ENODE@[$BOOTNODEIP]:30301"

KEYSTORE=/root/.ethereum/keystore
cp /config/keystore/* $KEYSTORE

geth \
    $MINE \
    $RPCOPT \
    $ETHERBASE_UNLOCK_PASSWORD \
    $NETWORK \
    $BOOTNODE \
    --verbosity $LOGGING_LEVEL \
