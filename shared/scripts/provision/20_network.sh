
#-------------
echo "---- Configuring network"

sf_svc_stop NetworkManager
sf_svc_disable NetworkManager

sf_check_line /etc/sysconfig/network '^GATEWAY=' 'GATEWAY="10.0.2.2"'

cat >/etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE="eth0"
BOOTPROTO=none
ONBOOT=yes
IPADDR=10.0.2.15
NETMASK=255.255.255.0
PEERDNS=no
EOF

cat >/etc/resolv.conf <<EOF
search canaltp.local canaltp.prod srv.canaltp.fr canaltp.fr
nameserver 10.50.83.15
nameserver 10.2.0.15
EOF

echo "---- Restarting network"

sf_svc_stop network
sf_svc_start network

