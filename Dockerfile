FROM debian:stable-slim

LABEL maintainer="richard.benko"

ENV EXPORTER_VERSION=0.1.0

RUN apt update && apt install -y wget \
    && cd /tmp \
    && wget https://github.com/RobustPerception/nrpe_exporter/releases/download/$EXPORTER_VERSION/nrpe_exporter-0.1.0.linux-amd64.tar.gz \
    && tar -xvf nrpe_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz \
    && mv nrpe_exporter /usr/local/bin/nrpe_exporter \
    && rm -f nrpe_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9275
ENTRYPOINT [ "/usr/local/bin/nrpe_exporter" ]