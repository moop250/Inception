FROM debian:bookworm

RUN apt update -y \
		&& apt upgrade -y \
		&& apt install -y redis \
		&& apt clean

COPY tools/redis_setup.sh /usr/bin/redis_setup.sh

RUN chmod +x /usr/bin/redis_setup.sh

EXPOSE 6379

CMD ["sh", "/usr/bin/redis_setup.sh"]
