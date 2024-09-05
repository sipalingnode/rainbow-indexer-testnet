<p style="font-size:14px" align="right">
<a href="https://t.me/airdropasc" target="_blank">Join our telegram <img src="https://user-images.githubusercontent.com/50621007/183283867-56b4d69f-bc6e-4939-b00a-72aa019d1aea.png" width="30"/></a>
</p>

<p align="center">
  <img height="300" height="auto" src="https://user-images.githubusercontent.com/109174478/209359981-dc19b4bf-854d-4a2a-b803-2547a7fa43f2.jpg">
</p>

# Rainbow-Indexer-Testnet

|  Hardware/VPS |  Minimum |
| ------------ | ------------ |
| CPU  | Multi-core processor  |
| RAM | 4 GB RAM |
| Penyimpanan  | 50GB Storage |
| Internet | Stable internet connection |

## Auto Install
```
wget -O rbo.sh https://raw.githubusercontent.com/sipalingnode/rainbow-indexer-testnet/main/rbo.sh && chmod +x rbo.sh && ./rbo.sh
```
## Manual Instalation

### Instal Docker
```
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
```
### Create Direktori & Repo
```
mkdir -p /root/project/run_btc_testnet4/data
git clone https://github.com/rainbowprotocol-xyz/btc_testnet4
cd btc_testnet4
```
### Download Docker-Compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
### Connect Conntainer & Create Wallet
```
docker-compose up -d
docker exec -it bitcoind /bin/bash
```
```
bitcoin-cli -testnet4 -rpcuser=demo -rpcpassword=demo -rpcport=5000 createwallet rbo
```
**Jika sudah buat wallet. Lanjut ketik `exit`**
### Clone Repo Indexer
```
cd
git clone https://github.com/rainbowprotocol-xyz/rbo_indexer_testnet && cd rbo_indexer_testnet
```
```
wget https://github.com/rainbowprotocol-xyz/rbo_indexer_testnet/releases/download/v0.0.1-alpha/rbo_worker
chmod +x rbo_worker
```
### Edit File Compose.yml
```
nano docker-compose.yml
```
**Lalu isikan dengan teks dibawah ini**
```
version: '3'
services:
  bitcoind:
    image: mocacinno/btc_testnet4:bci_node
    privileged: true
    container_name: bitcoind
    volumes:
      - /root/project/run_btc_testnet4/data:/root/.bitcoin/
    command: ["bitcoind", "-testnet4", "-server","-txindex", "-rpcuser=demo", "-rpcpassword=demo", "-rpcallowip=0.0.0.0/0", "-rpcbind=0.0.0.0:5000"]
    ports:
      - "8333:8333"
      - "48332:48332"
      - "5000:5000"
```
**CTRL+XY Enter buat simpan file**
### Configurasi Docker-Compose
```
docker-compose up -d
```
**Kalo nemu eror seperti gambar dibawah. Solusinya kalian hapus dulu docker yang lama**
<p align="center">
  <img height="150" height="auto" src="https://github.com/sipalingnode/rainbow-indexer-testnet/blob/main/eror.jpg">
</p>

```
docker stop <paste your container id>
docker rm <paste your container id>
```
**Lanjut Docker Compose Lagi. Maka hasilnya akan berbeda**

<p align="center">
  <img height="150" height="auto" src="https://github.com/sipalingnode/rainbow-indexer-testnet/blob/main/fixed.jpg">
</p>

```
docker-compose up -d
```
### Run Indexer
```
sudo apt-get install screen
```
```
sudo ufw allow ssh
```
```
sudo ufw enable
```
```
screen -S rainbow
```
```
./rbo_worker worker --rpc http://127.0.0.1:5000 --password demo --username demo --start_height 42000
```
**Kalo dah sukses tampilannya akan seperti gambar**
<p align="center">
  <img height="300" height="auto" src="https://github.com/sipalingnode/rainbow-indexer-testnet/blob/main/log.png">
</p>

### Cek Principal ID & Submit on Website
```
nano ~/rbo_indexer_testnet/identity/principal.json
```
**Submit your Pricipal ID on Website : [Here](https://testnet.rainbowprotocol.xyz/explorer)**
### Backup Wallet
```
nano ~/rbo_indexer_testnet/identity/private_key.pem
```
