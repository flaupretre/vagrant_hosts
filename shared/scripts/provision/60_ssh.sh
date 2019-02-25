
#-------------
echo "---- Configuring SSH client"

sf_check_block -agent /etc/ssh/ssh_config <<EOF

Host *
  ForwardAgent yes
  TCPKeepAlive yes
  ServerAliveInterval 60
EOF

#--- Authorize flp -> root

auth_file=/root/.ssh/authorized_keys

sf_create_dir `dirname $auth_file` root 400

sf_check_line $auth_file flaupretre 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiVvF64S+l8f5mTTe+yHvJx+AsSXOZQvwehp9T9DMf/MMeTlIe9zpBzj9EwSBliJPowLQy3J0Wla8gZDekJpZeNDSDwq+66GKF3TnRwsQZYqzUK5oW/1fNM19OZphlqU4y8T6kqnu2ywLpE9XEtXubJsbF0vUs7i03P9WdAbfiGs8veVNSQEnJ8noDAbMnphbG+M4X4mrtfpug1mBBrCPZSBCQY0wd2Zm8J4BghGYXhUtW6xPhu2PI/jghwlL3USMJURBx59IM3Y4HZHC5/sm48hoDLisKXT+xZCABatLWS6Lvk+8co4S3ZJMjdmyGWL1t/ZA7S4mGMeUh4EVkcP+SQ== flaupretre@win'

sf_chmod 400 $auth_file
