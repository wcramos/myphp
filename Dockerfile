FROM ubuntu:18.10
MAINTAINER Wagner Correa Ramos <w6ramos@gmail.com>
LABEL Description="PHP7 and Apache2.4 stack, based on Ubuntu 18.06 LTS. Includes .htaccess support and popular PHP7 features, including composer." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HTTPS WWW PORT]:443 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST WWW LOG DIR]:/var/log/apache2 -v [APACHE CONFIG DIR]:/etc/apache2 wcramos/myphp" \
	Version="1.0"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y zip unzip
RUN apt-get install -y \
	php7.2 \
	php7.2-bz2 \
	php7.2-cgi \
	php7.2-cli \
	php7.2-common \
	php7.2-curl \
	php7.2-dev \
	php7.2-enchant \
	php7.2-fpm \
	php7.2-gd \
	php7.2-gmp \
	php7.2-imap \
	php7.2-interbase \
	php7.2-intl \
	php7.2-json \
	php7.2-ldap \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-odbc \
	php7.2-opcache \
	php7.2-pgsql \
	php7.2-phpdbg \
	php7.2-pspell \
	php7.2-readline \
	php7.2-recode \
	php7.2-snmp \
	php7.2-sqlite3 \
	php7.2-sybase \
	php7.2-tidy \
	php7.2-xmlrpc \
	php7.2-xsl \
	php7.2-zip
RUN apt-get install apache2 libapache2-mod-php7.2 -y
RUN apt-get install mysql-common mysql-client -y
RUN apt-get install git nodejs npm composer nano tree vim curl ftp -y
RUN npm install -g yarn grunt-cli gulp

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC
ENV TERM dumb

COPY run-lamp.sh /usr/sbin/

RUN a2enmod rewrite
RUN chmod +x /usr/sbin/run-lamp.sh

VOLUME /var/www/html
VOLUME /var/log/apache2
VOLUME /etc/apache2

EXPOSE 80
EXPOSE 443 

CMD ["/usr/sbin/run-lamp.sh"]
