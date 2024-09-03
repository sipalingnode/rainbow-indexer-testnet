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

read -p "Submit Username (bebas): " RPC_USER
read -sp "Submit Password: " RPC_PASSWORD
echo
read -p "Submit IPVPSMU (Contoh http://ipvps:5000): " RPC_URL
read -p "Start Block (isi 45000): " START_HEIGHT
read -p "Nama Wallet: " WALLET_NAME

BITCOIN_CORE_REPO="https://github.com/mocacinno/btc_testnet4"
INDEXER_URL="https://github.com/rainbowprotocol-xyz/rbo_indexer_testnet/releases/download/v0.0.1-alpha/rbo_worker"
BITCOIN_CORE_DATA_DIR="/root/project/run_btc_testnet4/data"
DOCKER_COMPOSE_FILE="docker-compose.yml"
ENV_FILE=".env"

apt-get update
apt-get install -y docker.io docker-compose wget

mkdir -p $BITCOIN_CORE_DATA_DIR

git clone $BITCOIN_CORE_REPO
cd btc_testnet4

git switch bci_node

rm -f $DOCKER_COMPOSE_FILE

cat <<EOF > $DOCKER_COMPOSE_FILE
version: '3'
services:
  bitcoind:
    image: mocacinno/btc_testnet4:bci_node
    privileged: true
    container_name: bitcoind
    volumes:
      - /root/project/run_btc_testnet4/data:/root/.bitcoin/
    command: ["bitcoind", "-testnet4", "-server", "-txindex", "-rpcuser=demo", "-rpcpassword=demo", "-rpcallowip=0.0.0.0/0", "-rpcbind=0.0.0.0:5000"]
    ports:
      - "8333:8333"
      - "48332:48332"
      - "5000:5000"
EOF

cat $DOCKER_COMPOSE_FILE

docker-compose up -d

sleep 20

docker exec -it bitcoind /bin/bash -c "bitcoin-cli -testnet4 -rpcuser=demo -rpcpassword=demo -rpcport=5000 createwallet $WALLET_NAME"
docker exec -it bitcoind /bin/bash -c "exit"

wget $INDEXER_URL
chmod +x rbo_worker

echo "INDEXER_LOGGER_FILE=./logs/indexer" > $ENV_FILE

./rbo_worker worker --rpc http://127.0.0.1:5000 --password demo --username demo --start_height $START_HEIGHT
