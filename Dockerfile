ARG BASE_IMAGE_TAG

FROM nginx:${BASE_IMAGE_TAG}

RUN apt-get update; \
    apt-get install -y iproute2

ENV LISTEN_PORT=8443
ENV DST_PORT=80

COPY cert.pem /tmp/cert.pem
COPY key.pem /tmp/key.pem
COPY proxy_ssl.conf.template /tmp/proxy_ssl.conf.template
COPY run_command.sh /run_command.sh

CMD ["/bin/bash", "-c", "/run_command.sh"]