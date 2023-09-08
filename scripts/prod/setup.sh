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

source "${SCRIPTS_DIR}/prod/funcs.sh"

cp /etc/passwd /etc/group "${DATA_DIR}/etc"


# dc_base build --build-arg _USER=${USER} \
#     || exit 1 && dc_base run --remove-orphans --rm copper-protocol-smart-contracts-evm yarn \
#     || exit 1 && dc_base run --remove-orphans --rm copper-protocol-smart-contracts-evm yarn hardhat compile \
#     || exit 1 && dc_dev run --remove-orphans --rm frontend-dev yarn  \
#     || exit 1 && dc_dev run --remove-orphans --rm frontend-dev yarn build \
#     || exit 1 && 
    dc_dev run --remove-orphans --rm api-dev yarn \
    || exit 1 && backup_ssl_dhparams
