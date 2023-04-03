FROM alpine:3.15

RUN apk update && \
	apk upgrade --no-cache && \
	apk add --no-cache php7 \
			php7-fpm \
			php7-phar \
			php7-json \
			php7-curl \
			php7-mysqli \
			php7-iconv \
			php7-common \
			php7-cli \
			php7-opcache \
			php7-gd \
			php7-zlib \
			curl \
			wget \
			tar \
			mariadb-client

#get wordpress cli and move it to /usr/bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

#Create the folder to enable php start
RUN mkdir /run/php

RUN adduser -S nginx && addgroup -S nginx

COPY tools/wordpress_setup.sh /run
RUN chmod +x /run/wordpress_setup.sh

EXPOSE 9000

WORKDIR /var/www/wordpress
ENTRYPOINT ["sh", "/run/wordpress_setup.sh"]
