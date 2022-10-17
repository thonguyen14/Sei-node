# delete old seid - Sei-testnet-2 (if not installed , skip it)
```
systemctl stop seid && systemctl disable seid && rm -rf $HOME/.sei/
```
# install seid to 1.0.6 version ( check seid version is there , then skip it )
```
seiversion="1.0.6beta"
cd $HOME && rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout $seiversion
make install
seid version
```
# Create gentx 
```
SEID_CHAIN="atlantic-1"
SEID_MONIKER="YOUR-MONIKER-NAME" 
SEID_WALLET="YOUR-WALLET-NAME"
```
```
seid init $SEID_MONIKER --chain-id $SEID_CHAIN
seid config chain-id $SEID_CHAIN
seid config keyring-backend test
```

- Create new wallet OR Recover previous wallet with your mnemonic
```
seid keys add $SEID_WALLET
seid keys add $SEID_WALLET --recover
```
``` 
seid add-genesis-account $(seid keys show $SEID_WALLET -a) 10000000usei
```
- Create gentx
```
seid gentx $SEID_WALLET 10000000usei \
--chain-id $SEID_CHAIN \
--moniker=$SEID_MONIKER \
--commission-max-change-rate=0.01 \
--commission-max-rate=0.20 \
--commission-rate=0.05 \
--details="YOUR-OPTION"   
```

  ----> Genesis transaction written to "/root/.sei/config/gentx/gentx-cc3eb32b40eb88e33c3654a66870572f8af29a08.json"

# Upload gentx to https://github.com/sei-protocol/testnet/tree/main/sei-incentivized-testnet/gentx

- Gentx file is created under the folder $HOME/.sei/config/gentx. Check and show name/content of the file
```
ls $HOME/.sei/config/gentx
cat $HOME/.sei/config/gentx/gentx*.json
```
- Open the link https://github.com/sei-protocol/testnet/tree/main/sei-incentivized-testnet/gentx and choose "Create new file"

- Type your file name , and copy content of the file gentx to Edit new file

- Press the green button Propose new file

- Press Create Pull Request

- Press Create Pull Request again

- So your gentx has been created under the link 

https://github.com/sei-protocol/testnet/pull/XXX

# Go to discord faucet token, check balance
 
```
seid q bank balances < WALLET-ADRESS>

```
# Create Systemd
```
sudo tee /etc/systemd/system/seid.service > /dev/null << EOF
[Unit]
Description=Sei Protocol Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which seid) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```
# ADD PEER
```
cd ~/.sei

curl -s https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-incentivized-testnet/genesis.json > $HOME/.sei/config/genesis.json

curl -s https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-incentivized-testnet/addrbook.json > $HOME/.sei/config/addrbook.json
```
```
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001usei"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning = "default"|pruning = "custom"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning-interval = "0"|pruning-interval = "10"|g' $HOME/.sei/config/app.toml
seid tendermint unsafe-reset-all --home $HOME/.sei --keep-addr-book

PEERS=$(curl -sS http://rpc2.bonded.zone:21157/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"' | awk -F ':' '{printf $1":"$(NF)} { printf(",") }'| sed 's/.$//')
sed -i "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/;" $HOME/.sei/config/config.toml
```
```
sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid
```
```
sudo journalctl -u seid -f --no-hostname -o cat

seid status 2>&1 | jq .SyncInfo
seid status 2>&1 | jq .SyncInfo.catching_up
```
Khi nào sync ---> false thì làm tiếp phần dưới đây 

# Create validator
```
seid tx staking create-validator \
--amount=900000usei \
--pubkey=$(seid tendermint show-validator) \
--moniker=thonguyen \
--chain-id=atlantic-1 \
--commission-rate=0.1 \
--commission-max-rate=0.2 \
--commission-max-change-rate=0.05 \
--min-self-delegation=1 \
--from=thonguyen \
--details="I LOVE SEI" \
-y
```
****ok ok ok******
