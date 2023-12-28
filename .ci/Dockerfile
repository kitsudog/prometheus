FROM prom/pushgateway:v1.6.2 AS PUSHGATEWAY
FROM prom/prometheus:v2.48.1 AS PROMETHEUS
FROM debian:bookworm-slim
RUN apt update && apt install --no-install-recommends --no-install-suggests -y apache2-utils curl procps vim-tiny && rm -fr /var/lib/apt/lists/* /var/log /var/cache/apt 
COPY --from=PUSHGATEWAY /bin/pushgateway /bin/
COPY --from=PROMETHEUS /bin/prometheus /bin/promtool /bin/
COPY --from=PROMETHEUS /usr/share/prometheus/console_libraries/ /usr/share/prometheus/console_libraries/
COPY --from=PROMETHEUS /usr/share/prometheus/consoles/ /usr/share/prometheus/consoles/
COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY start.sh /
USER root
ENV TZ=Asia/Shanghai
ENTRYPOINT /start.sh
EXPOSE 9091
