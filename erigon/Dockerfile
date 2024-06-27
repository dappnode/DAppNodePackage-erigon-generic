ARG UPSTREAM_VERSION

FROM thorax/erigon:${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT

USER root

COPY /security /security
COPY /erigon/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod u+x /usr/local/bin/entrypoint.sh

ENV DATADIR=/home/erigon/.local/share \
    NETWORK=${NETWORK} \
    P2P_PORT=${P2P_PORT}

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]