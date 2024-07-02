#!/bin/sh

SUPPORTED_NETWORKS="holesky mainnet gnosis"

# shellcheck disable=SC1091
. /etc/profile

run_client() {
    exec erigon --datadir="${DATADIR}" \
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
        --db.size.limit=8TB \
        "${EXTRA_OPTS}"
}

set_execution_config_by_network "${SUPPORTED_NETWORKS}"
post_jwt_to_dappmanager
run_client
