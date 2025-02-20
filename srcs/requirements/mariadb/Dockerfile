FROM debian:buster


RUN apt-get update -y && apt-get -y install mariadb-server \
											mariadb-client

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf


COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

CMD ["/usr/local/bin/mariadb.sh"]
