FROM alpine:3.4
ENV GRPC_HEALTH_CHECK_TAG 1.0.1
RUN apk add --update sed bash curl supervisor && rm -rf /var/cache/apk/*  

ADD https://github.com/andela/grpc-health/releases/download/v${GRPC_HEALTH_CHECK_TAG}/artifact /healthcheck-artifact
RUN chmod +x /healthcheck-artifact
COPY supervisord-healthcheck.ini /etc/supervisor.d/supervisord-healthcheck.ini
EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]