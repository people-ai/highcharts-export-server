FROM ubuntu:trusty

MAINTAINER wap

# Env
ENV PHANTOMJS_VERSION 1.9.7

# Commands
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y vim wget libfreetype6 libfontconfig curl bzip2 && \
  mkdir -p /srv/var && \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs && \
  apt-get autoremove -y && \
  apt-get clean all


WORKDIR /app

COPY . /app

EXPOSE 3003

# Default command
ENTRYPOINT ["/usr/bin/phantomjs", "highcharts-convert.js", "-host", "0.0.0.0", "-port", "3003"]