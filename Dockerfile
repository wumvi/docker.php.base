FROM debian:stretch-slim
MAINTAINER Vitaliy Kozlenko <vk@wumvi.com>

ENV PHP_VERSION 7.1

RUN DEBIAN_FRONTEND=noninteractive && \
    rm /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian stretch main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirror.yandex.ru/debian stretch main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirror.yandex.ru/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get --no-install-recommends -qq -y install wget git gnupg apt-transport-https lsb-release ca-certificates procps curl cmake build-essential && \
	wget -q https://packages.sury.org/php/apt.gpg -O - | apt-key add - && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list && \
	echo "deb-src https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list && \
    apt-get update && \
    #
    apt-get --no-install-recommends -qq -y install php${PHP_VERSION}-cli \
        php${PHP_VERSION}-curl php${PHP_VERSION}-dev php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip php${PHP_VERSION}-soap php${PHP_VERSION}-memcached php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-pgsql && \
    mkdir /soft/ && \
    #
    cd /soft/ && \
    git clone https://github.com/igbinary/igbinary.git igbinary && \
    cd igbinary && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    #
    cd / && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	apt-get -y remove libboost-all-dev git cmake ssh build-essential php${PHP_VERSION}-dev && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
	echo 'end'