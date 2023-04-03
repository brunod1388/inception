FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client

COPY tools/init_db.sh /tmp/init_db.sh
COPY conf/init.sql /tmp/init.sql

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/init_db.sh"]