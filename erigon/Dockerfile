ARG UPSTREAM_VERSION

FROM erigontech/erigon:${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT
ARG STAKER_SCRIPTS_VERSION
ARG DATA_DIR

ENV DATA_DIR=${DATA_DIR} \
    NETWORK=${NETWORK} \
    P2P_PORT=${P2P_PORT} \
    JWT_PATH=/jwtsecret.hex \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/execution_tools.sh /etc/profile.d/

USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt-get update && apt-get install -y curl && \
    chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/execution_tools.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
