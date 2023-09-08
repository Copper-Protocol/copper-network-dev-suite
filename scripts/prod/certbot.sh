#!/usr/bin/env bash

SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

cd "${SCRIPT_DIR}/../.."

source .vars

function backup_ssl_dhparams () {
    pushd "${BASE_DIR}"
    docker compose -f "${CONFIG_DIR}/docker-compose.prod.yml" run \
        -v "${DATA_DIR}/etc/certbot/:/tmp/certbot" \
        --entrypoint "" certbot cp -r /opt/certbot/src/certbot/certbot/ /tmp/

}
