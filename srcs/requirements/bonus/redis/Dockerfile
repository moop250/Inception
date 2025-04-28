FROM alpine:3.20.6

RUN apk update \
		&& apk upgrade \
		&& apk add --no-cache redis

COPY tools/redis_setup.sh /usr/bin/redis_setup.sh

RUN chmod +x /usr/bin/redis_setup.sh

EXPOSE 6379

CMD ["sh", "/usr/bin/redis_setup.sh"]
