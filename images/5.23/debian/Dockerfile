FROM osrm/osrm-backend:v5.23.0

ENV OSRM_ALGORITHM=mld \
    OSRM_THREADS=2 \
    OSRM_PORT=5000 \
    OSRM_PROFILE=/opt/car.lua \
    OSRM_MAP_NAME= \
    OSRM_GEOFABRIK_PATH= \
    OSRM_NOTIFY_FILEPATH=

# Add requirements and install application
RUN set -ex; \
    apt-get update -q; \
    apt-get install -y --allow-unauthenticated \
        curl \
        inotify-tools \
        netcat \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    useradd --uid 5001 --create-home osrm; \
    mkdir -p /data; \
    chown -R osrm:osrm /data

USER osrm:osrm
WORKDIR /home/osrm

VOLUME [ "/data" ]

COPY --chown=osrm:osrm ./entrypoint.sh /home/osrm

ENTRYPOINT ["/home/osrm/entrypoint.sh"]
CMD ["run"]

# Arguments to label built container
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION=v5.23.0

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>" \
      product="OSRM Backend" \
      version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Monogramm/docker-osrm-backend" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="OSRM Backend" \
      org.label-schema.description="Open Source Routing Machine" \
      org.label-schema.url="http://project-osrm.org/" \
      org.label-schema.vendor="Project OSRM" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/Monogramm/docker-osrm-backend" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="OSRM Backend" \
      org.opencontainers.image.description="Open Source Routing Machine" \
      org.opencontainers.image.url="http://project-osrm.org/" \
      org.opencontainers.image.vendor="Project OSRM" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.authors="Monogramm maintainers <opensource at monogramm dot io>"
