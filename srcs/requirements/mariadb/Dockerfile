FROM debian:bookworm

# Update container and install mariadb
RUN apt update -y \
		&& apt upgrade -y \
		&& apt install -y mariadb-server \
		&& apt clean

# Copy the setup script and give the container permission to execute it
COPY tools/mariadb_setup.sh /usr/bin
RUN chmod 755 /usr/bin/mariadb_setup.sh

# Copy the config file over
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Open the port
EXPOSE 3306

# Launch the start script
CMD ["/bin/mariadb_setup.sh"]
