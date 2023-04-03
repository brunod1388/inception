
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

    wp core install --url=$DOMAIN_NAME --title="Inception 42" --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
	wp comment delete 1
	wp post delete 1
	wp post create --post_title="Kikou website" --post_content="This is my first post." --post_status='publish'
	wp theme install twentytwentyone --activate --allow-root
	# wp theme activate twentytwentyone

fi

php-fpm7 -F -R
