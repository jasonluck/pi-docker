#!/bin/bash

# Allow SSH and HTTPS traffic
iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 22 -j ACCEPT

# Allow DNS and DHCP
iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT -p udp -m udp --dport 67 -j ACCEPT

# Block all other incoming connections
iptables -A INPUT -j REJECT

# Allow all outbound traffic
iptables -A OUTPUT -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

