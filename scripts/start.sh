#!/usr/bin/env bash

SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

cd ${SCRIPT_DIR}/..
BASE_DIR=${PWD}

WEBSITES=("betteryourweb.com" "kookie.betteryourweb.com")
dc_file=

chmod +x -R ${SCRIPT_DIR}

${SCRIPT_DIR}/build.sh

for site in ${WEBSITES[@]}; do
  echo "SITE: ${site}"
  _dc_file="${site}.webserver.yml"
  echo "_DC_FILE: ${_dc_file}"
  docker compose -f ${_dc_file} up  -d
done
docker compose -f betteryourweb-loadbalancer.yml up -d --build


# docker-compose.[type].[domain].yml