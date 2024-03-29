#!/bin/bash

PATH=/root/.cargo/bin:/root/.hermes/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/root/SEI_ACT4

SEI_ADDR=sei1khj89n6epj6e6dl20sa5zh6dv5ec9l2r8u29dq
wallet=tunguyen

touch $HOME/SEI_ACT4/txh.log
rm -rf $HOME/SEI_ACT4/bundle_tx.json

ACC=$(seid q account $SEI_ADDR -o json --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .account_number); sleep 7;
seq=$(seid q account $SEI_ADDR -o json --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .sequence); sleep 7;

#seid tx sign $HOME/SEI_ACT4/gen_bundle_tx.json -s $seq -a $ACC --offline --from $wallet --chain-id atlantic-1 --output-document $HOME/SEI_ACT4/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443; sleep 7;
echo abcdef | seid tx sign $HOME/SEI_ACT4/gen_bundle_tx.json -s $seq -a $ACC --offline --from $wallet --chain-id atlantic-1 --output-document $HOME/SEI_ACT4/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443; sleep 10;

date -R >> $HOME/SEI_ACT4/txh.log;
echo "Bundled order:" >> $HOME/SEI_ACT4/txh.log
seid tx broadcast $HOME/SEI_ACT4/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443 | grep txhash >> $HOME/SEI_ACT4/txh.log;
sleep 15;
