#!/bin/bash
PHPINILOC=/etc/php/8.1/apache2/php.ini

if [[ -f /var/webaarix/assets/php.ini ]]
then
  cp /var/webaarix/assets/php.ini $PHPINILOC
fi

if [[ -z $REDIS_HOST || -z $REDIS_PORT || -z $REDIS_PASSWORD ]]
then
  echo "ERROR: You have to define these environment vars:"
  echo "REDIS_HOST, REDIS_PORT, REDIS_PASSWORD"
  exit 1
fi

sed -i "s/HEREGOESTHEREDISHOST/$REDIS_HOST/" $PHPINILOC
sed -i "s/HEREGOESTHEREDISPORT/$REDIS_PORT/" $PHPINILOC
sed -i "s/HEREGOESTHEREDISPASSWORD/$REDIS_PASSWORD/" $PHPINILOC

apachectl -D FOREGROUND
