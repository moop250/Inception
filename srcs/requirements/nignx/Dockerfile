FROM debian:buster

# Install required programs
RUN	apt-get update
RUN	apt-get install -y nginx \
						openssl

# Nginx ssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out /etc/nginx/ssl/hlibine.crt \
		-keyout /etc/nginx/ssl/hlibine.key \
		-subj "/C=CH/ST=Vaud/L=Lausanne/O=42 School/OU=hlibine/CN=hlibine/"

# Copy the config over
COPY ./conf/nginx.conf /etc/nginx/conf.d

# make a directory for nginx
RUN mkdir -p /run/nginx

# Expose the port
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
