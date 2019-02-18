
#-------------
echo "---- Configuring SSH client"

sf_check_block -agent /etc/ssh/ssh_config <<EOF

Host *
  ForwardAgent yes
  TCPKeepAlive yes
  ServerAliveInterval 60
EOF
