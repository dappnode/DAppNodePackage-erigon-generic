#!/bin/sh

set_jwt_path() {
    CLIENT=$1
    echo "Using $CLIENT JWT"
    JWT_PATH="/security/$CLIENT/jwtsecret.hex"
}

set_network_specific_config() {
    CONSENSUS_DNP=$1
    P2P_PORT=$2

    echo "[INFO - entrypoint] Initializing $NETWORK specific config for client"

    # If consensus client is prysm-prater.dnp.dappnode.eth --> CLIENT=prysm
    CLIENT=$(echo "$CONSENSUS_DNP" | cut -d'.' -f1 | cut -d'-' -f1)

    set_jwt_path "$CLIENT"
}

case "$NETWORK" in
"gnosis") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_GNOSIS" 31305 ;;
"holesky") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY" 30406 ;;
"mainnet") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET" 30405 ;;
*)
    echo "Unsupported network: $NETWORK"
    exit 1
    ;;
esac

JWT=$(cat "${JWT_PATH}")

curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}" || {
    echo "[ERROR - entrypoint] JWT could not be posted to package info"
}

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
