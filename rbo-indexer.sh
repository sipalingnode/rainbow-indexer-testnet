echo -e "\033[0;35m"
echo "====================================================="
echo "                  AIRDROP ASC                        "
echo "====================================================="
echo -e '\e[35mNode :\e[35m' Rainbow Indexer
echo -e '\e[35mTelegram Channel :\e[35m' @airdropasc
echo -e '\e[35mTelegram Group :\e[35m' @autosultan_group
echo "====================================================="
echo -e "\e[0m"

sleep 5

sudo apt update && sudo apt upgrade -y

sleep 5

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sleep 5

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sleep 5


mkdir -p /root/project/run_btc_testnet4/data

git clone https://github.com/mocacinno/btc_testnet4

echo -e "\033[0;35m"
echo "=====================DONE========================"
echo -e "\e[0m"
