#! /bin/bash

set -e

NAME_MIXNODE=${NAME_MIXNODE:-"docker-mixnode"}
MIXNODES_DIR=~/.nym/mixnodes/${NAME_MIXNODE}



if [ ! -d ${MIXNODES_DIR} ]; then
   echo "Init nym client"
    if [[ -v ANNOUNCE_HOST ]]; then
   	./nym-mixnode init --id $NAME_MIXNODE  --announce-host $ANNOUNCE_HOST --host 0.0.0.0 --wallet-address $WALLET_ADDRESS
    else
        ./nym-mixnode init --id $NAME_MIXNODE --announce-host $(curl ifconfig.me)  --host 0.0.0.0 --wallet-address $WALLET_ADDRESS
    fi
fi

echo "Run nym client"
./nym-mixnode run --id $NAME_MIXNODE

