#!/bin/sh

set -e

CONF_FILE=/usr/local/etc/php-fpm.d/www.conf

if [ ! -z ${PM_MAX_CHILDREN+x} ]; then
    sed -ie "s|^pm\.max_children =.*$|pm\.max_children = ${PM_MAX_CHILDREN}|g" $CONF_FILE
fi

if [ ! -z ${PM_START_SERVERS+x} ]; then
    sed -ie "s|^pm\.start_servers =.*$|pm\.start_servers = ${PM_START_SERVERS}|g" $CONF_FILE
fi

if [ ! -z ${PM_MIN_SPARE_SERVERS+x} ]; then
    sed -ie "s|^pm\.min_spare_servers =.*$|pm\.min_spare_servers = ${PM_MIN_SPARE_SERVERS}|g" $CONF_FILE
fi

if [ ! -z ${PM_MAX_SPARE_SERVERS+x} ]; then
    sed -ie "s|^pm\.max_spare_servers =.*$|pm\.max_spare_servers = ${PM_MAX_SPARE_SERVERS}|g" $CONF_FILE
fi

if [ ! -z ${PM_MAX_REQUESTS+x} ]; then
sed -ie "s|^pm\.max_requests =.*$|pm\.max_requests = ${PM_MAX_REQUESTS}|g" $CONF_FILE
fi

exec "$@"