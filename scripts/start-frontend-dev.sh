#!/usr/bin/env bash

SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

cd "${SCRIPT_DIR}/.."

source .vars

echo "Attempting to start Frontend (DEV MODE)"

[[ -d "${DATA_DIR}" ]] || mkdir -p "${DATA_DIR}/etc"

cp /etc/passwd "${DATA_DIR}/etc"
cp /etc/group "${DATA_DIR}/etc"

docker compose -f docker-compose.base.yml build frontend copper-protocol-smart-contracts-evm --build-arg _USER="${USER}" \
  && docker compose -f docker-compose.base.yml run copper-protocol-smart-contracts-evm sh -c "yarn && npx hardhat compile" \
  && docker compose run frontend-dev yarn \
  && docker compose up frontend-dev
