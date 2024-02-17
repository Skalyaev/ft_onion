#!/bin/sh
sudo /usr/sbin/service ssh start
sudo /usr/sbin/service tor start
exec "$@"
