FROM centos:6
MAINTAINER Bogdan Katyński <bogdan.katynski@gmail.com>

EXPOSE 636
# Install stunnel
RUN yum -y install stunnel

# Create a self-signed keypair
RUN openssl req -x509 \
  -newkey rsa:2048 \
  -keyout /etc/stunnel/key.pem -out /etc/stunnel/cert.pem \
  -days 3650 \
  -nodes -subj "/C=US/ST=Oregon/L=Portland/O=TEST/OU=TEST/CN=www.example.com"

ADD ldap.conf /etc/stunnel/
ADD my_init.sh /sbin/

ENTRYPOINT ["/sbin/my_init.sh"]
