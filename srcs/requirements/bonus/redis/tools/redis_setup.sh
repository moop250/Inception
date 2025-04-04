#!/bin/sh

if [ ! -f "/etc/redis/redis.conf.bak" ];
then
	echo "redis already configured"
else

	# Create the .bak to notify the program if it exists
    cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

fi

redis-server --protected-mode no
