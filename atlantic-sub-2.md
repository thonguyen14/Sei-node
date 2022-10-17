# fist delete old node
```
cd $HOME
sudo systemctl stop seid && sudo systemctl disable seid
rm -rf $HOME/sei-chain $HOME/.sei $(which seid)
```
# Update APT
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
```
# Install GO
```
rm -r /usr/local/go
rm -r /usr/lib/go-1.13
wget https://golang.org/dl/go1.18.3.linux-amd64.tar.gz; \
rm -rv /usr/local/go; \
tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz && \
rm -v go1.18.3.linux-amd64.tar.gz && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile && \
source ~/.bash_profile && \
go version
```
# Build binary
```
cd $HOME
git clone https://github.com/sei-protocol/sei-chain
cd $HOME/sei-chain
git checkout master && git pull
git checkout 1.1.2beta-internal
make install
mv $HOME/go/bin/seid /usr/bin/
```
# Add the sings (changer"YOURNODENAME" and "YOURWALLETNAME" not "<>")
```
NODENAME=<your-node-name>
WALLETNAME=<your-wallet-name>
echo export NODENAME=${NODENAME} >> $HOME/.bash_profile
echo export WALLETNAME=${WALLETNAME} >> $HOME/.bash_profile
echo export CHAIN_ID=atlantic-sub-2 >> $HOME/.bash_profile
source ~/.bash_profile
```
# make init
```
seid init $NODENAME --chain-id $CHAIN_ID
```
# Add chain-id in config
```
seid config chain-id $CHAIN_ID
```
# Restore your wallet
```
seid keys add $WALLETNAME --recover
```
# Create gentx

- Add the account to your local genesis file with a given amount and key
```
seid add-genesis-account $WALLETNAME 10000000usei
```
- Create gentx (security-contact, website, details, identity is optional flags)
```
 seid gentx $WALLETNAME 10000000usei \
 --chain-id=$CHAIN_ID \
 --moniker=$NODENAME \
 --commission-rate=0.05 \
 --commission-max-rate=0.1 \
 --commission-max-change-rate=0.06 \
 --pubkey $(seid tendermint show-validator) \
 --details="YOUR-OPTION" \
 -y
```
# Create Pull Request to the  https://github.com/sei-protocol/testnet/tree/main/atlantic-subchains/atlantic-sub-2/gentx
 with the file your_validator_moniker.json

---> Genesis transaction written to "/root/.sei/config/gentx/gentx-acb969ffe4dd7377a10c51010ae6d5d0369e2408.json"

-  Gentx file is created under the folder $HOME/.sei/config/gentx. Check and show name/content of the file
```
ls $HOME/.sei/config/gentx
cat $HOME/.sei/config/gentx/gentx*.json
```
- Open the link https://github.com/sei-protocol/testnet/tree/main/sei-incentivized-testnet/gentx and choose "Create new file"
https://github.com/sei-protocol/testnet/tree/main/atlantic-subchains/atlantic-sub-2/gentx

- Type your file name , and copy content of the file gentx to Edit new file

- Press the green button Propose new file

- Press Create Pull Request

- Press Create Pull Request again

- So your gentx has been created under the link 

# Create SYSTEMD
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
12.ADD PEER
```
cd $HOME                                
wget -O $HOME/.sei/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/atlantic-subchains/atlantic-sub-2/genesis.json"
```
```
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001usei"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning = "default"|pruning = "custom"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|g' $HOME/.sei/config/app.toml
sed -i 's|pruning-interval = "0"|pruning-interval = "10"|g' $HOME/.sei/config/app.toml
seid tendermint unsafe-reset-all --home $HOME/.sei --keep-addr-book

PEERS="f48eedfb31854a822129b7f857b43969f2526bad@185.144.99.19:26656,2f1e8842dec0a60c79d8fedfe420697661c837c8@195.3.221.191:26656,f61d6ace9a30d371fa2d1b8e04ec11b66c967a63@167.235.6.228:26656,070650355f3e51d5f1f514759ec7602b993588f1@185.248.24.16:26656,e528e2d19e1b611894745fc1a5d3e7802e606f31@95.214.52.173:26656,dd23e8a8f019ff8030a1238f7cbf99601293050e@213.239.218.199:26656,34c734f3908654b53045f06c5fd262efaa6c0766@65.109.27.156:26656,72e5106ce49cb794f8af7196a14916bc06a36465@5.161.75.216:26656,8acf073665a756fca2df91b647a280ef0d05dc8a@85.114.134.203:26656,263803aef62e933f568ced5df5ca2e24d0f9d329@95.216.40.123:26656,0174c55cc5fb6c7ad0c39e709710adfb1ee6bae8@49.12.15.138:26656,26ff7747fd64c703bd241bdad3cf75bbda5ae72b@85.10.199.157:26656,390be417d37cb2ac0ee72a7c40f2ead6aa98e62b@65.108.60.151:26656,2743782c2bdc22e51250c5edc21048d1e3a7bf01@172.20.0.75:26656,2743782c2bdc22e51250c5edc21048d1e3a7bf01@172.20.0.75:26656,a5b5ee5888f4a8b66a29184611dd19e4c8ce1c28@5.9.71.9:26656,aaa1da62895d2a8daaf09b235ca82a55c8d9efd7@173.212.203.238:26656,ab082b683c6ecfb1148cb87e0153b036b1ea2283@65.108.199.62:26656,b2a4e16ef6ec4e2e42ec7c22e530840c16351bfa@135.181.222.185:26656,2743782c2bdc22e51250c5edc21048d1e3a7bf01@172.20.0.75:26656,a5b5ee5888f4a8b66a29184611dd19e4c8ce1c28@5.9.71.9:26656,070650355f3e51d5f1f514759ec7602b993588f1@185.248.24.16:26656,624bf9fe064fa52d0f69fbac068acb98b7ae62cc@176.104.242.134:26656" 

persistent_peers = "f48eedfb31854a822129b7f857b43969f2526bad@185.144.99.19:26656,2f1e8842dec0a60c79d8fedfe420697661c837c8@195.3.221.191:26656,f61d6ace9a30d371fa2d1b8e04ec11b66c967a63@167.235.6.228:26656,070650355f3e51d5f1f514759ec7602b993588f1@185.248.24.16:26656,e528e2d19e1b611894745fc1a5d3e7802e606f31@95.214.52.173:26656,dd23e8a8f019ff8030a1238f7cbf99601293050e@213.239.218.199:26656,34c734f3908654b53045f06c5fd262efaa6c0766@65.109.27.156:26656,72e5106ce49cb794f8af7196a14916bc06a36465@5.161.75.216:26656,7900d390baf8e6d5ce69225917e8fd64927e94f2@154.12.240.133:26656,8acf073665a756fca2df91b647a280ef0d05dc8a@85.114.134.203:26656,263803aef62e933f568ced5df5ca2e24d0f9d329@95.216.40.123:26656,5cb50c4b80dff5a92d232057d07f97ab82895cea@65.108.246.4:26656,0174c55cc5fb6c7ad0c39e709710adfb1ee6bae8@49.12.15.138:26656,26ff7747fd64c703bd241bdad3cf75bbda5ae72b@85.10.199.157:26656,390be417d37cb2ac0ee72a7c40f2ead6aa98e62b@65.108.60.151:26656,5d0cee85dcac7364fb8861201eec3a767873bdf3@172.31.16.93:26656,62ec353a7c234ef436518a7d07eed422064c01c9@172.31.16.93:26656,2743782c2bdc22e51250c5edc21048d1e3a7bf01@172.20.0.75:26656,2743782c2bdc22e51250c5edc21048d1e3a7bf01@172.20.0.75:26656,a5b5ee5888f4a8b66a29184611dd19e4c8ce1c28@5.9.71.9:26656,aaa1da62895d2a8daaf09b235ca82a55c8d9efd7@173.212.203.238:26656,ab082b683c6ecfb1148cb87e0153b036b1ea2283@65.108.199.62:26656,169685c8550d1663ac44a77d8bb03ba681a9582d@45.84.138.127:26656,b2a4e16ef6ec4e2e42ec7c22e530840c16351bfa@135.181.222.185:26656,89ba32810d917a9db78808df338b60abcb7ae3e2@45.94.209.32:26656,e84bbca3bd80c9effba4451dd797a0edb61cb5d2@135.181.143.26:26656,531980d9574d1c619aad8ba9f42703c2c817d9f8@38.242.255.82:26656"

sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sei/config/config.toml
```
```
sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid
sudo journalctl -u seid -f -o cat
```
# Create validator
```
seid tx staking create-validator \
--amount=900000usei \
--pubkey=$(seid tendermint show-validator) \
--moniker=thonguyen \
--chain-id=atlantic-sub-2 \
--commission-rate=0.07 \
--commission-max-rate=0.1 \
--commission-max-change-rate=0.05 \
--min-self-delegation=1 \
--from=thonguyen \
--details="I LOVE SEI" \
-y
```
