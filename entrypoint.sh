#!/bin/sh
sudo /usr/sbin/service ssh start
sudo /usr/sbin/service tor start
sudo /usr/bin/cat /var/lib/tor/hidden_service/hostname >> /home/nginx/tor-hostname
exec "$@"
