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
--output-document $HOME/txs.json
```
##Tx Broadcast
```
seid tx broadcast --node https://sei-testnet-rpc.brocha.in:443 $HOME/txs.json 
```

# 2.Place market order on Vortex 
thank kj89 and zoia queen#7436 guided
# 3. Place multiple orders in one transaction
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
seid tx broadcast --node https://sei-testnet-rpc.brocha.in:443 $HOME/txs.json 
```
If successful, you will get code = 0
# 4. Get liquidated on Vortex
```
seid tx dex liquidate sei1466nf3zuxpya8q9emxukd7vftaf6h4psr0a07srl5zw74zh84yjqpeheyc YOUR_ADDR --from YOUR_WALLET_NAME --chain-id atlantic-1 --fees 20000usei -y
```
