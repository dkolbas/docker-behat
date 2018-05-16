# Docker - Customer Portal Drupal - API Behat tests
#
# VERSION       dev
# Behat docker image for Drupal Customer Portal API
FROM fedora
MAINTAINER Dan Kolbas <dkolbas@redhat.com>

USER root

# Required packages
RUN yum install -y \
      vim \
      wget \
      gcc \
      gcc-c++ \
      make \
      python \
      git \
      openssl-devel \
      freetype \
      fontconfig \
      libfreetype.so.6 \
      libfontconfig.so.1 \ 
      libstdc++.so.6 \
      nodejs \ 
      npm \ 
      php \
      bzip2

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN mkdir /opt/cpdrupal-api-behat

ADD composer.json /opt/cpdrupal-api-behat/composer.json

ENV PATH /root/.composer/vendor/bin:$PATH
RUN cd /opt/cpdrupal-api-behat ; composer install ;
RUN sed -i "s,;date.timezone =,date.timezone = \'America/New_York\'," /etc/php.ini
ADD features /opt/cpdrupal-api-behat/features
ADD behat.yml /opt/cpdrupal-api-behat/behat.yml

USER root
WORKDIR /opt/cpdrupal-api-behat
