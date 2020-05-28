FROM ubuntu:20.04

RUN true \
    && apt-get update \
    && apt-get \
        --yes \
        install \
        openconnect \
        haproxy \
    && apt-get clean

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY entrypoint.sh /

EXPOSE 1111

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["openconnect"]
