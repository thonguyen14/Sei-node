```
SEI_ADDR_2=sei1lnrcc6w873h4759em8yar2kdcwkxs8sh06v0uq
wallet_2=thonguyen
SETUP_PATH=SEI_ACT4_2
echo "export PATH=$PATH:$SEI_ACT4_2" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
- Download all script files
```
cd /root && mkdir SEI_ACT4_2
cd SEI_ACT4_2

wget -O vortex_limit_vm.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/multiVM/vortex_limit_vm.sh && chmod +x vortex_limit_vm.sh
wget -O vortex_bundle_vm.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/multiVM/vortex_bundle_vm.sh && chmod +x vortex_bundle_vm.sh
wget -O vortex_market_vm.sh https://github.com/thonguyen14/Sei-node/blob/main/task/ACT-4/multiVM/vortex_market_vm.sh && chmod +x vortex_market_vm.sh
wget -O gen_limit_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_limit_tx.json && chmod +x gen_limit_tx.json
wget -O gen_market_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_market_tx.json && chmod +x gen_market_tx.json
wget -O gen_bundle_tx.json https://raw.githubusercontent.com/thonguyen14/Sei-node/main/task/ACT-4/gen_bundle_tx.json && chmod +x gen_bundle_tx.json
```
- Replace your address into script
```
sed -i "s|^SEI_ADDR_2=.*|SEI_ADDR_2=$SEI_ADDR_2|" vortex_limit_vm.sh
sed -i "s|^SEI_ADDR_2=.*|SEI_ADDR_2=$SEI_ADDR_2|" vortex_market_vm.sh
sed -i "s|^SEI_ADDR_2=.*|SEI_ADDR_2=$SEI_ADDR_2|" vortex_bundle_vm.sh
sed -i "s|^wallet_2=.*|wallet_2=$wallet_2|" vortex_bundle_vm.sh
sed -i "s|^wallet_2=.*|wallet_2=$wallet_2|" vortex_limit_vm.sh
sed -i "s|^wallet_2=.*|wallet_2=$wallet_2|" vortex_market_vm.sh

sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR_2\",|" gen_limit_tx.json
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR_2\",|" gen_market_tx.json
sed -i "s|\"creator\": .*|\"creator\": \"$SEI_ADDR_2\",|" gen_bundle_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR_2\",|" gen_limit_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR_2\",|" gen_market_tx.json
sed -i "s|\"account\": .*|\"account\": \"$SEI_ADDR_2\",|" gen_bundle_tx.json

sed -i "s|SEI_ACT4_2$|$SETUP_PATH|g" vortex_bundle_vm.sh
sed -i "s|SEI_ACT4_2$|$SETUP_PATH|g" vortex_market_vm.sh
sed -i "s|SEI_ACT4_2$|$SETUP_PATH|g" vortex_limit_vm.sh
```
- check the files .sh , json . Once you are sure, run the following command
- Setup crontab
```
cd
crontab -e -u root
0 * * * * /root/SEI_ACT4_2/vortex_bundle_vm.sh
17 * * * * /root/SEI_ACT4_2/vortex_limit_vm.sh
32 * * * * /root/SEI_ACT4_2/vortex_market_vm.sh
```
- Check recorded txh in /root/SEI_ACT4_2/txh.log
