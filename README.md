# <p align="center">ft_onion</p>
> *Projet d'introduction à la mise en œuvre d'un service caché sur Tor.*
>
> *L'objectif de ce projet est de créer une page web accessible uniquement depuis le réseau Tor en configurant un service caché. Un service caché est un service web dissimulé sur le réseau Tor.*

## Preview
![](https://media.githubusercontent.com/media/Skalyaeve/images-2/main/ft_onion.gif)

## Install
```bash
sudo apt update -y
sudo apt install -y make
sudo apt install -y docker.io
```
```bash
git clone https://github.com/Skalyaeve/ft_onion.git
cd ft_onion
```
```bash
echo "USR_PASS=exemple" > .env
mkdir ssh && cp ~/.ssh/id_rsa.pub ssh/authorized_keys
sudo make
```

## Usage
```
sudo docker exec -it ft_onion bash
```
```bash
cat home/nginx/tor-hostname
exit
# then browse to the link from the Tor browser
```
```bash
sudo make stop
sudo make fclean
```
