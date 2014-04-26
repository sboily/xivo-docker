FROM debian:7.4
MAINTAINER Sylvain Boily "sboily@avencall.com"

ADD http://mirror.xivo.fr/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
RUN apt-get -qq -y install wget
RUN chmod +x /root/xivo_install_current.sh
RUN /root/xivo_install_current.sh 2> /dev/null 1>/dev/null

EXPOSE 443 80 5003 50051
