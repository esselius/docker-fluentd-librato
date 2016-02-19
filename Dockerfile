FROM ruby:2.3

MAINTAINER Brian DeHamer <brian@dehamer.com>

# Need apt-transport-https installed in order to install docker
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https

# Install docker tools from official docker repo
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y docker-engine

RUN gem install fluentd fluent-plugin-librato fluent-plugin-docker-metrics

# Template for fluentd config
COPY fluent.conf /etc/fluent/fluent.conf

# Install start-up script
WORKDIR /tmp
COPY startup.sh /tmp/
RUN chmod +x startup.sh

CMD ["./startup.sh"]
