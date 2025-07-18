FROM alpine:3.22

# Update container and install mariadb
RUN apk update \
		&& apk upgrade \
		&& apk add --no-cache mariadb \
							mariadb-client \
		&& adduser -D -g 'www' www

# Copy the setup script and give the container permission to execute it
COPY tools/mariadb_setup.sh /usr/bin/mariadb_setup.sh
RUN chmod 755 /usr/bin/mariadb_setup.sh

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN sed -i '/skip-networking/d' /etc/my.cnf.d/mariadb-server.cnf

# Open the port
EXPOSE 3306

# Launch the start script
ENTRYPOINT ["sh", "/usr/bin/mariadb_setup.sh"]
