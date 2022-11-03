# 1.Place limit order on Vortex
```
seid keys list
SEI_ADDR=sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq
wallet=thonguyen
cd $HOME
```
##Creating a Tx Body
```
echo '{
  "body": {
    "messages": [
      {
        "@type": "/seiprotocol.seichain.dex.MsgPlaceOrders",
        "creator": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
        "orders": [
          {
            "id": "0",
            "status": "PLACED",
            "account": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
            "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
            "price": "11.580000000000000000",
            "quantity": "0.050000000000000000",
            "priceDenom": "UST2",
            "assetDenom": "ATOM",
            "orderType": "LIMIT",
            "positionDirection": "LONG",
            "data": "{\"position_effect\":\"Open\",\"leverage\":\"1\"}",
            "statusDescription": ""
          }
        ],
        "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
        "funds": [
          {
            "denom": "ust2",
            "amount": "11580000"
          }
        ]
      }      
    ],
    "memo": "",
    "timeout_height": "0",
    "extension_options": [],
    "non_critical_extension_options": []
  },
  "auth_info": {
    "signer_infos": [],
    "fee": {
      "amount": [
        {
          "denom": "usei",
          "amount": "200"
        }
      ],
      "gas_limit": "0",
      "payer": "",
      "granter": ""
    }
  },
  "signatures": []
}' > $HOME/gen_limit_tx.json
```
```
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_limit_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_limit_tx.json
```
##Signing the Tx
```
ACC=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .account_number)
seq=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .sequence)
```
##Sign the Tx offline
```
seid tx sign $HOME/gen_limit_tx.json -s $seq -a $ACC --offline \
--from $wallet --chain-id atlantic-1 \
--output-document $HOME/txsl.json
```
##Tx Broadcast
```
seid tx broadcast $HOME/txsl.json --node https://sei-testnet-rpc.brocha.in:443 
```

# 2.Place market order on Vortex 
```
SEI_ADDR=sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq
wallet=thonguyen
cd $HOME
```
##Creating a Tx Body
```
echo '{
  "body": {
    "messages": [
      {
        "@type": "/seiprotocol.seichain.dex.MsgPlaceOrders",
        "creator": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
        "orders": [
          {
            "id": "0",
            "status": "PLACED",
            "account": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
            "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
            "price": "11.60000000000000000",
            "quantity": "0.050000000000000000",
            "priceDenom": "UST2",
            "assetDenom": "ATOM",
            "orderType": "MARKET",
            "positionDirection": "LONG",
            "data": "{\"position_effect\":\"Open\",\"leverage\":\"1\"}",
            "statusDescription": ""
          }
        ],
        "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
        "funds": [
          {
            "denom": "ust2",
            "amount": "11600000"
          }
        ]
      }      
    ],
    "memo": "",
    "timeout_height": "0",
    "extension_options": [],
    "non_critical_extension_options": []
  },
  "auth_info": {
    "signer_infos": [],
    "fee": {
      "amount": [
        {
          "denom": "usei",
          "amount": "200"
        }
      ],
      "gas_limit": "0",
      "payer": "",
      "granter": ""
    }
  },
  "signatures": []
}' > $HOME/gen_market_tx.json
```
```
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_market_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_market_tx.json
```
##Signing the Tx
```
ACC=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .account_number)
seq=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .sequence)
```
##Sign the Tx offline
```
seid tx sign $HOME/gen_market_tx.json -s $seq -a $ACC --offline \
--from $wallet --chain-id atlantic-1 \
--output-document $HOME/txsm.json
```
##Tx Broadcast
```
seid tx broadcast $HOME/txsm.json --node https://sei-testnet-rpc.brocha.in:443 
```
# 3. Place multiple orders in one transaction
thank kj89 and zoia queen#7436 guided
```
seid keys list
SEI_ADDR=sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq
wallet=thonguyen
cd $HOME
```
##Creating a Tx Body
```
echo '{
  "body": {
    "messages": [
      {
        "@type": "/seiprotocol.seichain.dex.MsgPlaceOrders",
        "creator": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
        "orders": [
          {
            "id": "0",
            "status": "PLACED",
            "account": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
            "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
            "price": "11.610000000000000000",
            "quantity": "0.010000000000000000",
            "priceDenom": "UST2",
            "assetDenom": "ATOM",
            "orderType": "LIMIT",
            "positionDirection": "LONG",
            "data": "{\"position_effect\":\"Open\",\"leverage\":\"1\"}",
            "statusDescription": ""
          }
        ],
        "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
        "funds": [
          {
            "denom": "ust2",
            "amount": "11610000"
          }
        ]
      },
      {
        "@type": "/seiprotocol.seichain.dex.MsgPlaceOrders",
        "creator": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
        "orders": [
          {
            "id": "0",
            "status": "PLACED",
            "account": "sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq",
            "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
            "price": "11.620000000000000000",
            "quantity": "0.010000000000000000",
            "priceDenom": "UST2",
            "assetDenom": "ATOM",
            "orderType": "LIMIT",
            "positionDirection": "LONG",
            "data": "{\"position_effect\":\"Open\",\"leverage\":\"1\"}",
            "statusDescription": ""
          }
        ],
        "contractAddr": "sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc",
        "funds": [
          {
            "denom": "ust2",
            "amount": "11620000"
          }
        ]
      }
    ],
    "memo": "",
    "timeout_height": "0",
    "extension_options": [],
    "non_critical_extension_options": []
  },
  "auth_info": {
    "signer_infos": [],
    "fee": {
      "amount": [
        {
          "denom": "usei",
          "amount": "200"
        }
      ],
      "gas_limit": "0",
      "payer": "",
      "granter": ""
    }
  },
  "signatures": []
}' > $HOME/gen_tx.json
```
##Signing the Tx
```
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_tx.json 
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_tx.json
```
```
ACC=$(seid q account $ADDR -o json | jq -r .account_number)
seq=$(seid q account $ADDR -o json | jq -r .sequence)
```
  or If necessary, you can use a public node https://sei-testnet-rpc.brocha.in:443
```
ACC=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .account_number)
seq=$(seid q account $ADDR -o json --node https://sei-testnet-rpc.brocha.in:443 | jq -r .sequence)
```
##Sign the Tx offline
```
seid tx sign $HOME/gen_tx.json -s $seq -a $ACC --offline \
--from $wallet --chain-id atlantic-1 \
--output-document $HOME/txs.json
```
##Tx Broadcast
```
seid tx broadcast $HOME/txs.json
```
or 
```
seid tx broadcast $HOME/txs.json --node https://sei-testnet-rpc.brocha.in:443 
```
If successful, you will get code = 0
# 4. Get liquidated on Vortex
```
seid tx dex liquidate sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc YOUR_ADDR --from YOUR_WALLET_NAME --chain-id atlantic-1 --fees 20000usei -y
##example
seid tx dex liquidate sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq --from thonguyen --chain-id atlantic-1 --fees 20000usei -y
```
# CLI AUTOMATIC ( thank viennguyenbkdn sharing )
- Set your wallet name and wallet address
```
SEI_ADDR=YOUR_WALLET_ADDR
wallet=YOUR_WALLET_NAME
SETUP_PATH=YOUR_PATH_stores_SCRIPTS
echo "export PATH=$PATH:$YOUR_PATH" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
example
```
SEI_ADDR=sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq
wallet=thonguyen
SETUP_PATH=SEI_ACT4
echo "export PATH=$PATH:$SEI_ACT4" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
- Download all script files
```
cd /root && mkdir SEI_ACT4
cd SEI_ACT4

wget -O vortex_limit.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/vortex_limit.sh && chmod +x vortex_limit.sh
wget -O vortex_market.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/vortex_market.sh && chmod +x vortex_market.sh
wget -O vortex_bundle.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/vortex_bundle.sh && chmod +x vortex_bundle.sh
wget -O gen_limit_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_limit_tx.json && chmod +x gen_limit_tx.json
wget -O gen_market_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_market_tx.json && chmod +x gen_market_tx.json
wget -O gen_bundle_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_bundle_tx.json && chmod +x gen_bundle_tx.json
```
- Replace your address into script
```
sed -i "s|^SEI_ADDR=.*|SEI_ADDR=$SEI_ADDR|" vortex_limit.sh
sed -i "s|^SEI_ADDR=.*|SEI_ADDR=$SEI_ADDR|" vortex_market.sh
sed -i "s|^SEI_ADDR=.*|SEI_ADDR=$SEI_ADDR|" vortex_bundle.sh
sed -i "s|^wallet=.*|wallet=$wallet|" vortex_bundle.sh
sed -i "s|^wallet=.*|wallet=$wallet|" vortex_limit.sh
sed -i "s|^wallet=.*|wallet=$wallet|" vortex_market.sh

sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_limit_tx.json
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_market_tx.json
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR\",|" gen_bundle_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_limit_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_market_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR\",|" gen_bundle_tx.json

sed -i "s|SEI_ACT4$|$SETUP_PATH|g" vortex_bundle.sh
sed -i "s|SEI_ACT4$|$SETUP_PATH|g" vortex_market.sh
sed -i "s|SEI_ACT4$|$SETUP_PATH|g" vortex_limit.sh
```
- Setup crontab
```
cd
crontab -e -u root
0 * * * * /root/SEI_ACT4/vortex_bundle.sh
17 * * * * /root/SEI_ACT4/vortex_limit.sh
32 * * * * /root/SEI_ACT4/vortex_market.sh
```
- Check recorded txh in $SETUP_PATH/txh.log
