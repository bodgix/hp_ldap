#!/bin/sh

LDAP_SERVER_TOKEN="<%LDAP_SERVER%>"
STUNNEL_CFG="/etc/stunnel/ldap.conf"

# We're use indirect reference, to find out what is
# the ldap server IP:Port

ldap_ip_port_env_name="LDAP_PORT"
if [ ! -z $LDAP_ALIAS ]; then
  upcase_alias=$(echo $LDAP_ALIAS | tr '[:lower:]' '[:upper:]')
  ldap_ip_port_env_name=${upcase_alias}_PORT
  echo "LDAP_ALIAS is defined. I'm using"
  echo "$ldap_ip_port_env_name env variable."
fi

eval ldap_port=\$$ldap_ip_port_env_name

if [ -z $ldap_port ]; then
  echo "$ldap_port env variable is not defined."
  echo "This container has to be linked to an ldap container."
  echo "Exiting."
  exit 2
fi

ldap_server=$(echo $ldap_port | awk -F '://' '{ print $2 }')
config=$(mktemp)

sed -e "s/${LDAP_SERVER_TOKEN}/${ldap_server}/" $STUNNEL_CFG > ${config}

echo "Using config:"
cat ${config}

cmd="/usr/bin/stunnel ${config}"
echo
echo "Running: $cmd"

$cmd
