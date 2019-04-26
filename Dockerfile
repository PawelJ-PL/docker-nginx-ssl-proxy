ARG BASE_IMAGE_TAG

FROM nginx:${BASE_IMAGE_TAG}

RUN apt-get update; \
    apt-get install -y iproute2 openssl

ENV LISTEN_PORT=8443
ENV DST_PORT=80
ENV CERT_CN=127.0.0.1

COPY rootCA.crt /tmp/rootCA.crt
COPY rootCA.key /tmp/rootCA.key
COPY proxy_ssl.conf.template /tmp/proxy_ssl.conf.template
COPY run_command.sh /run_command.sh

CMD ["/bin/bash", "-c", "/run_command.sh"]