#!/bin/bash

PATH=/root/.cargo/bin:/root/.hermes/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/root/SEI_ACT4_2

SEI_ADDR_2=sei1khj89n6epj6e6dl20sa5zh6dv5ec9l2r8u29dq
wallet_2=tunguyen

touch $HOME/SEI_ACT4_2/txh.log
rm -rf $HOME/SEI_ACT4_2/bundle_tx.json

ACC_2=$(sei2d q account $SEI_ADDR_2 -o json --home $HOME/.sei2 --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .account_number); sleep 7;
seq_2=$(sei2d q account $SEI_ADDR_2 -o json --home $HOME/.sei2 --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .sequence); sleep 7;

#seid tx sign $HOME/SEI_ACT4/gen_bundle_tx.json -s $seq_2 -a $ACC_2 --offline --from $wallet_2 --chain-id atlantic-1 --home $HOME/.sei2 --output-document $HOME/SEI_ACT4_2/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443; sleep 7;
sei2d tx sign $HOME/SEI_ACT4_2/gen_bundle_tx.json -s $seq_2 -a $ACC_2 --offline --from $wallet_2 --chain-id atlantic-1 --home $HOME/.sei2 --output-document $HOME/SEI_ACT4_2/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443; sleep 10;

date -R >> $HOME/SEI_ACT4_2/txh.log;
echo "Bundled order:" >> $HOME/SEI_ACT4_2/txh.log
sei2d tx broadcast $HOME/SEI_ACT4_2/bundle_tx.json --node https://sei-testnet-rpc.brocha.in:443 | grep txhash >> $HOME/SEI_ACT4_2/txh.log;
sleep 15;
