FROM debian:stretch-slim
MAINTAINER Vitaliy Kozlenko <vk@wumvi.com>

RUN DEBIAN_FRONTEND=noninteractive && \
    rm /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian stretch main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirror.yandex.ru/debian stretch main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirror.yandex.ru/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get --no-install-recommends -qq -y install wget gnupg apt-transport-https lsb-release ca-certificates procps curl && \
	wget -q https://packages.sury.org/php/apt.gpg -O - | apt-key add - && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list && \
	echo "deb-src https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get --no-install-recommends -qq -y install php7.2-cli php7.2-curl  php7.2-sqlite3 php7.2-xml php7.2-zip php7.2-soap php7.2-memcached php7.2-mbstring php7.2-pgsql php7.2-zip && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
	echo 'end'