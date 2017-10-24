FROM alpine:3.4

ENV GRPC_HEALTH_CHECK_TAG %GRPC_HEALTH_CHECK_TAG%
ENV PG_SCHEMA default
ENV DEPLOYMENT_TAG %IMG_TAG%

RUN apk add --update bash supervisor curl && rm -rf /var/cache/apk/*

# setup health-check
ADD https://github.com/andela/grpc-health/releases/download/v${GRPC_HEALTH_CHECK_TAG}/artifact /healthcheck-artifact
RUN chmod +x /healthcheck-artifact
COPY /supervisor/supervisord-healthcheck.ini /etc/supervisor.d/supervisord-healthcheck.ini

# setup app
RUN mkdir -p /usr/src/app
ADD ./app/ /usr/src/app/
COPY /supervisor/supervisord-app.ini /etc/supervisor.d/supervisord-app.ini

EXPOSE 8080
EXPOSE 50050

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
