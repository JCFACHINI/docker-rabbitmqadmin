FROM debian:jessie

MAINTAINER fredcamps fred.tecnologia@gmail.com

ENV DEBIAN_FRONTEND noninteractive

ADD https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/rabbitmq_v3_5_4/bin/rabbitmqadmin /usr/sbin/rabbitmqadmin
ADD ./run.sh /run.sh
RUN apt-get -qq update > /dev/null && \
    apt-get -qq -y install python > /dev/null && \
    apt-get -qq -y install rabbitmq-server > /dev/null && \
    apt-get -qq clean > /dev/null && \
    rabbitmq-plugins enable rabbitmq_management && \
    rabbitmq-plugins enable rabbitmq_shovel && \
    chmod +x /run.sh && chmod 775 /run.sh && \
    chmod +x /usr/sbin/rabbitmqadmin && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/*

VOLUME ["/etc/rabbitmq", "/var/lib/rabbitmq", "/var/log/rabbitmq"]

EXPOSE 5672 15672 4369

ENTRYPOINT ["/run.sh"]
