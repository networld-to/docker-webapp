#################################################################
# This docker image build file creates an image that contains
# nginx, passenger, rvm with ruby on rails.
#
#                    ##        .
#              ## ## ##       ==
#           ## ## ## ##      ===
#       /""""""""""""""""\___/ ===
#  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
#       \______ o          __/
#         \    \        __/
#          \____\______/
#
# Component:    docker-webapp
# Author:       Alex Oberhauser <alex.oberhauser@networld.to>
# Copyright:    (c) 2013-2014 Sigimera Ltd. All rights reserved.
#################################################################
# 12.04 LTS version
FROM ubuntu:precise
MAINTAINER Alex Oberhauser <alex.oberhauser@networld.to>

# reduce output from debconf
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Setup all needed dependencies
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install cron curl libcurl4-gnutls-dev git libxslt-dev libxml2-dev libpq-dev libffi-dev imagemagick

# Install rvm
RUN (\curl -sSL http://get.rvm.io | bash -s stable --rails); echo 0
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN /bin/bash -l -c 'rvm requirements'
RUN /bin/bash -l -c 'rvm install 2.1.2 && rvm use 2.1.2 --default'
RUN /bin/bash -l -c 'rvm rubygems current'

RUN /bin/bash -l -c 'gem install passenger --version 4.0.41'
RUN /bin/bash -l -c 'passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx'

RUN /bin/bash -l -c 'gem install bundler'
RUN /bin/bash -l -c 'rvm cleanup all'

# Configure nginx
RUN mkdir -p /var/log/nginx
RUN echo "daemon off;" >> /opt/nginx/conf/nginx.conf
ADD nginx.conf /opt/nginx/conf/nginx.conf
ADD 50x.html /var/www/50x.html
ADD start.sh /start.sh

RUN apt-get -y autoclean

RUN /bin/bash -l -c 'usermod -s /bin/bash nobody'
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
CMD []
ENTRYPOINT ["/start.sh"]

