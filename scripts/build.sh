#!/usr/bin/env bash

SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

WEBSITES=("coppernetwork.io" "*.coppernetwork.io")

LOADBALANCERS=("coppernetwork")
dc_file=

for site in ${WEBSITES[@]}; do
  echo "SITE: ${site}"
  # dc_file="${dc_file} -f ${site}.webserver.yml"
  # dc_file="${dc_file} -f docker-compose.dev.${site}.yml"
  # echo "DC FILE: ${dc_file}"
  # echo docker compose -f docker-compsoe.dev.${site}.yml run ${site}
  _dc_file="${site}.webserver.yml"
  # echo "_DC_FILE: ${_dc_file}"
  # echo "_dc_file: ${_dc_file}"

  [[ ! -z ${_dc_file} ]] && {
    docker compose -f docker-compose.dev.${site}.yml run frontend sh -c "yarn && yarn build" &&
      docker compose -f ${site}.webserver.yml build
  }
done
# for loadbalancer in ${LOADBALANCERS[@]}; do
#   echo "LOADBALANCER: ${loadbalancer}"
#   dc_file="${dc_file} -f ${loadbalancer}-loadbalancer.yml"
#   echo "DC FILE: ${dc_file}"
#   echo docker compose -f docker-compose.dev.${loadbalancer}.yml frontend yarn build
# done

