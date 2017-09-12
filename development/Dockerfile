FROM golang

ENV GRPC_HEALTH_CHECK_TAG 1.0.2
ENV PG_SCHEMA default

RUN apt-get update && \
    apt-get install -y bash supervisor curl supervisor

RUN echo $$GOPATH && mkdir -p $$GOPATH/bin && \
    curl https://glide.sh/get | sh && \
    go get github.com/mattn/goveralls && \
    go get golang.org/x/tools/cmd/cover && \
    go get github.com/pilu/fresh && \
    mkdir -p /usr/src/app && \
    rm -rf /var/cache/apk/*

# setup health-check
ADD https://github.com/andela/grpc-health/releases/download/v${GRPC_HEALTH_CHECK_TAG}/artifact /healthcheck-artifact
RUN chmod +x /healthcheck-artifact
COPY /supervisor/supervisord-healthcheck.ini /etc/supervisor/conf.d/supervisord-healthcheck.conf


EXPOSE 8080
EXPOSE 50050

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
