FROM debian:bookworm

# Update container and install mariadb
RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server

# Copy the setup script and give the container permission to execute it
COPY tools/mariadb_setup.sh /bin
RUN chmod 755 /bin/mariadb_setup.sh

# Copy the config file over
COPY conf/mariadb.comf /etc/mysql/mariadb.conf.d/50-server.cnf

# Open the port
EXPOSE 3306

CMD ["/bin/mariadb_setup.sh"]
