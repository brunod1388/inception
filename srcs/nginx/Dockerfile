FROM	alpine:3.16

RUN		apk update && apk upgrade --no-cache
RUN		apk add --no-cache nginx openssl

COPY	conf/nginx.conf /etc/nginx/http.d/default.conf

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/bgoncalv.crt \
       -keyout /etc/nginx/ssl/bgoncalv.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=bgoncalv/CN=ngoncalv/"

EXPOSE	443

# TEST
RUN		mkdir /var/www/mysite
COPY	tools/mysite.html /var/www/mysite/mysite.html

EXPOSE	80
EXPOSE	81

CMD	["nginx", "-g", "daemon off;"]
