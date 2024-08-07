#!/bin/sh

# shellcheck disable=SC1091
. /etc/profile

JWT_PATH="/security/${NETWORK}/jwtsecret.hex"

post_jwt_to_dappmanager "${JWT_PATH}"

# shellcheck disable=SC2086
exec erigon --datadir="${DATA_DIR}" \
    --chain="${NETWORK}" \
    --http.addr=0.0.0.0 \
    --http.vhosts=* \
    --http.corsdomain=* \
    --ws \
    --private.api.addr=0.0.0.0:9090 \
    --metrics \
    --metrics.addr=0.0.0.0 \
    --metrics.port=6060 \
    --pprof \
    --pprof.addr=0.0.0.0 \
    --pprof.port=6061 \
    --port="${P2P_PORT}" \
    --authrpc.jwtsecret="${JWT_PATH}" \
    --authrpc.addr 0.0.0.0 \
    --authrpc.vhosts=* \
    --db.size.limit=8TB ${EXTRA_OPTS}
