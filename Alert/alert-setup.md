set up a notification system that sends Sei node information to mail and telegram bot
# Create Telegram bot
- Using [@BotFather](https://t.me/BotFather) go to /newbot to create your BOT, then store HTTP API of your BOT carefully
![image](https://user-images.githubusercontent.com/80441573/194982631-aea4b52c-33fe-475c-b6f5-50f9f6abd06c.png)
- Set environment variable for your API BOT
```
echo export TG_API='5792628568:AA*****************-sJAsIGpfD6Eozoc' >> $HOME/.bash_profile
source $HOME/.bash_profile
```
- Create your own Telegram group, then add the bot to the group as Administrator, send a message in your Tele group.

- Set environment variable for chat ID of your Tele group
```
TG_ID=$(curl -s https://api.telegram.org/bot$TG_API/getUpdates| jq | grep "\"id\"" |tail -n 1 |awk '{print $2}' | tr -d ",")
echo export TG_ID=$TG_ID >> $HOME/.bash_profile
source $HOME/.bash_profile
```
# Install SSMTP for sending mail from Linux
```
sudo apt install ssmtp
sudo apt install sendmail
sudo apt install sendmail-cf
sed -i.bak -e "s/\(^127\.0\.0\.1 .*\)/\1 `hostname`/" /etc/hosts
```

# Install script of alerting
```
mkdir $HOME/.alert/ && cd $HOME/.alert/
wget -O alert.sh https://raw.githubusercontent.com/thonguyen14/Sei-node/main/Alert/alert.sh
```

# Edit alert.sh file following your chain
```
vi $HOME/.alert/alert.sh
```
```
# If alert script and your node are in different machine, you have to expose your RPC node to public internet. then replace YOUR_RPC="http://YOUR_NODE_IP:YOUR_RPC_PORT"
if alert and your node are in one machine YOUR_RPC="http://127.0.0.1:YOUR_RPC_PORT"

# set YOUR_VAL
example : YOUR_VAL="seivaloper1lnrcc6w873h4759em8yar2kdcwkxs8sh34apas"

# Select a public trusted RPC as standard node to compare
example : TRUSTED_RPC="https://sei-testnet-rpc.brocha.in"

# name the alert string
example : YOUR_NODE_NAME="SEI-test"

# set your_email 
example : YOUR_EMAIL="tu99248@gmail.com"

```

# Run crontab as command
```
crontab -e -u root
* * * * *  /bin/bash $HOME/.alert/alert.sh
```
