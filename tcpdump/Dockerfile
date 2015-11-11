FROM centos:6
MAINTAINER Bogdan Katyński <bogdan.katynski@workday.com>

RUN yum -y install tcpdump

ENTRYPOINT  /usr/sbin/tcpdump -i eth0 -s0 -w \
                              /tcpdump/ldap_$(date '+%F_%T').pcap \
                              port 389 -p -n
