FROM prom/pushgateway:v1.6.2 AS PUSHGATEWAY
FROM prom/prometheus:v2.48.1
COPY --from=PUSHGATEWAY /bin/pushgateway /bin/
COPY prometheus.yml /etc/prometheus/prometheus.yml
EXPOSE 9091