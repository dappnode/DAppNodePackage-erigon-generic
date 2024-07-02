ARG UPSTREAM_VERSION

FROM thorax/erigon:${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT

USER root

COPY /security /security
COPY /erigon/entrypoint.sh /usr/local/bin/entrypoint.sh

ENV DATADIR=/home/erigon/.local/share \
    NETWORK=${NETWORK} \
    P2P_PORT=${P2P_PORT} \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/execution_tools.sh /etc/profile.d/

RUN chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/execution_tools.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]