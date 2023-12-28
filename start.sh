#!/bin/sh
if [ "$PUSHGATEWAY_USER" -a "$PUSHGATEWAY_PASS" ];then
    PUSHGATEWAY_AUTH=$(echo "$PUSHGATEWAY_PASS" | htpasswd -niB -C 10 "$PUSHGATEWAY_USER"|sed 's#:#: #'| tr -d '\n')
fi
if [ "$PUSHGATEWAY_AUTH" ];then
  cat <<EOF > /pushgateway.conf
http_server_config:
  http2: true
  headers:
    # Content-Security-Policy:
    # X-Frame-Options:
    # X-Content-Type-Options:
    # X-XSS-Protection:
    # Strict-Transport-Security:
basic_auth_users:
  $PUSHGATEWAY_AUTH
EOF
    /bin/pushgateway --web.config.file /pushgateway.conf &
else
    /bin/pushgateway &
fi
/bin/prometheus "--config.file=/etc/prometheus/prometheus.yml" \
  "--storage.tsdb.path=/prometheus" \
  "--web.console.libraries=/usr/share/prometheus/console_libraries" \
  "--web.console.templates=/usr/share/prometheus/consoles"
