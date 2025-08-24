#!/bin/bash
sudo yum update -y 
sudo yum install -y nginx
sudo systemctl enable --now nginx

sudo bash -c 'cat <<CONF > /etc/nginx/conf.d/reverse-proxy.conf
${nginx_config}
CONF'

sudo systemctl restart nginx
