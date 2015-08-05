#!/bin/bash

echo "Obtaining IP addresses of the nodes in the cluster..."
MACHINES_IP=$(curl -s ${COREOS_PRIVATE_IPV4}:4001/v2/machines | sed -e 's/ //g' -e 's/http:\/\///g' -e 's/:[0-9]\{4,5\}//g')
echo "Cluster IPs: ${MACHINES_IP}"

echo "Creating firewall Rules..."
# Firewall Template
template=$(cat <<EOF
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
:Firewall-INPUT - [0:0]
-A INPUT -j Firewall-INPUT
-A FORWARD -j Firewall-INPUT
-A Firewall-INPUT -i lo -j ACCEPT
-A Firewall-INPUT -p icmp --icmp-type echo-reply -j ACCEPT
-A Firewall-INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
-A Firewall-INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
# Ping
-A Firewall-INPUT -p icmp --icmp-type echo-request -j ACCEPT
# Accept any established connections
-A Firewall-INPUT -m conntrack --ctstate  ESTABLISHED,RELATED -j ACCEPT
# Enable the traffic between the nodes of the cluster
-A Firewall-INPUT -s ${MACHINES_IP} -j ACCEPT
# Allow connections from docker container
-A Firewall-INPUT -i docker0 -j ACCEPT
# Accept ssh, http, https and git
-A Firewall-INPUT -m conntrack --ctstate NEW -m multiport -p tcp --dports 22,2222,80,443 -j ACCEPT
# Log and drop everything else
-A Firewall-INPUT -j LOG
-A Firewall-INPUT -j REJECT
COMMIT
EOF
)

if [[ -z "$DEBUG" ]]; then
  echo "$template"
fi

echo "Saving firewall Rules"
echo "$template" | sudo tee /var/lib/iptables/rules-save > /dev/null


echo "Done"
