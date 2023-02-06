#! /bin/bash

set -e

NAME_MIXNODE=${NAME_MIXNODE:-"docker-mixnode"}
MIXNODES_DIR=~/.nym/mixnodes/${NAME_MIXNODE}
FORCE_INIT=${FORCE_INIT:-false}

EXEC_VERSION=$(./nym-mixnode -V | sed 's:nym-mixnode::' |xargs)

if [ -f "${MIXNODES_DIR}/config/config.toml" ]; then
	CONFIG_VERSION=$(cat "${MIXNODES_DIR}/config/config.toml" | awk -F "=" '/version/ {print $2}' | xargs)
fi

if [[ ! -v ANNOUNCE_HOST || $EXEC_VERSION != $CONFIG_VERSION || $FORCE_INIT == true ]];then 
   echo "Init nym client"
   if [[ -v ANNOUNCE_HOST ]]; then
      	./nym-mixnode init --id $NAME_MIXNODE  --announce-host $ANNOUNCE_HOST --host 0.0.0.0 --wallet-address $WALLET_ADDRESS
       else
        ./nym-mixnode init --id $NAME_MIXNODE --announce-host $(curl ifconfig.me)  --host 0.0.0.0 --wallet-address $WALLET_ADDRESS
   fi
fi

echo "Run nym client"
./nym-mixnode run --id $NAME_MIXNODE

