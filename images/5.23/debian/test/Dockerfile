FROM alpine:3

COPY docker_test.sh /docker_test.sh

RUN set -ex; \
    apk add --update \
        curl \
    ; \
    chmod 755 /docker_test.sh;

CMD ["/docker_test.sh"]
