FROM alpine:latest

COPY srcs/landing.html landing.html
COPY srcs/style.css style.css

COPY tools/init.sh /usr/bin/init.sh

RUN chmod +x /usr/bin/init.sh

CMD ["sh", "/usr/bin/init.sh"]
