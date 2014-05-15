FROM debian:7.4
MAINTAINER Sylvain Boily "sboily@avencall.com"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ADD http://mirror.xivo.fr/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
ADD https://raw.githubusercontent.com/sboily/xivo-docker/master/xivo-service /root/xivo-service
RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qq -y install apt-utils locales wget vim net-tools rsyslog udev iptables kmod
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN dpkg-reconfigure locales
RUN chmod +x /root/xivo_install_current.sh
RUN chmod +x /root/xivo-service
RUN /root/xivo_install_current.sh
RUN service postgresql start
RUN xivo-init-db --drop --init

EXPOSE 443 80 5003 50051
CMD /root/xivo-service start
