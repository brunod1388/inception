
#!/bin/sh

while ! mariadb -h$MARIADB_HOSTNAME -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    echo " waiting for database..."
	sleep 3
done

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$WP_DATABASE_USR/g" wp-config-sample.php
	sed -i "s/password_here/$WP_DATABASE_PWD/g" wp-config-sample.php
	sed -i "s/localhost/$MARIADB_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$WP_DATABASE_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	echo $(pwd)
fi

php-fpm7 -F -R