FROM debian:bookworm

# Update the system and install the required packages
RUN apt update -y \
			&& apt upgrade -y \
			&& apt install -y \
					php \
					php8.2-fpm \
					php-mysql \
					curl \
			&& apt clean \
# Download the WP CLI
			&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			&& chmod +x wp-cli.phar \
			&& mv wp-cli.phar /usr/local/bin/wp

# Copy wordpress config file
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/

RUN mkdir -p /run/php
WORKDIR /var/www/wordpress

# Copy the setup script
COPY /tools/wordpress_setup.sh /usr/bin
RUN chmod +x /usr/bin/wordpress_setup.sh

WORKDIR /var/www/html/

EXPOSE 9000

# Launch the start script
ENTRYPOINT ["/usr/bin/wordpress_setup.sh"]
