FROM alpine:3.20.6

# Update container and install nginx and openssl
RUN	apk update \
		&& apk add --no-cache nginx \
					openssl \
		&& adduser -D -g 'www' www

RUN mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www

# Use openssl to generate an ssl certificate for ngnix to use
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out /etc/nginx/ssl/hlibine.crt \
		-keyout /etc/nginx/ssl/hlibine.key \
		-subj "/C=CH/ST=Vaud/L=Lausanne/O=42 School/OU=hlibine/CN=hlibine/"

# Copy the ngnix config over
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/entrypoint.sh /usr/bin/

# make a directory for nginx
RUN mkdir -p /run/nginx

# Expose the https port
EXPOSE 443

# Start Nginx
ENTRYPOINT ["/bin/sh", "/usr/bin/entrypoint.sh"]