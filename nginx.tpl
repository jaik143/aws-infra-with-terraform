server {
  listen 80;
  location / {
    proxy_pass http://${internal_lb_dns};
  }
}
