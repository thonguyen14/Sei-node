# Thank @viennguyenbkdn sharing ! CLI AUTOMATIC 
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
- check the files .sh , json . Once you are sure, run the following command
- Setup crontab
```
cd
crontab -e -u root
0 * * * * /root/SEI_ACT4/vortex_bundle.sh
17 * * * * /root/SEI_ACT4/vortex_limit.sh
32 * * * * /root/SEI_ACT4/vortex_market.sh
```
- Check recorded txh in $SETUP_PATH/txh.log
