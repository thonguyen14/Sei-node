#!/bin/bash

PATH=/root/.cargo/bin:/root/.hermes/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/usr/local/go/bin:/root/go/bin:/root/SEI_ACT4_2

SEI_ADDR_2=sei1zqgw9lmkdu2ngsxzlze49ewq8e69yxvslcfprt
wallet_2=duynguyen

touch $HOME/SEI_ACT4_2/txh.log
rm -rf $HOME/SEI_ACT4_2/limit_tx.json

ACC_2=$(sei2d q account $SEI_ADDR_2 -o json --home $HOME/.sei2 --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .account_number); sleep 7;
seq_2=$(sei2d q account $SEI_ADDR_2 -o json --home $HOME/.sei2 --node https://sei-testnet-rpc.polkachu.com:443 | jq -r .sequence); sleep 7;

#sei2d tx sign $HOME/SEI_ACT4_2/gen_limit_tx.json -s $seq_2 -a $ACC_2 --offline --from $wallet_2 --chain-id atlantic-1 --home $HOME/.sei2 --output-document $HOME/SEI_ACT4_2/limit_tx.json --node https://sei-testnet-rpc.polkachu.com:443; sleep 7;
sei2d tx sign $HOME/SEI_ACT4_2/gen_limit_tx.json -s $seq_2 -a $ACC_2 --offline --from $wallet_2 --chain-id atlantic-1 --home $HOME/.sei2 --output-document $HOME/SEI_ACT4_2/limit_tx.json --node https://sei-testnet-rpc.polkachu.com:443; sleep 10;

#date -R >> $HOME/SEI_ACT4_2/txh.log
echo "Limit order:" >> $HOME/SEI_ACT4_2/txh.log
sei2d tx broadcast $HOME/SEI_ACT4_2/limit_tx.json --home $HOME/.sei2 --node https://sei-testnet-rpc.polkachu.com:443 | grep txhash >> $HOME/SEI_ACT4_2/txh.log

sleep 5;
