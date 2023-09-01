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

echo "Starting the Copper Protocol Production Web Server"

function getBranch () {
    git branch | grep '*' | awk '{print $2}'
}
# pull the git repo
function gitFrontendPull () {
    echo "Updating Frontend repository"
    BRANCH=$1
    DEFAULT_BRANCH=dev

    cd "${FRONTEND_DIR}" \
        && git pull origin $BRANCH \
        && cd "${BASE_DIR}" 
}       
# yarn build on frontend

function frontendYarn () {
    echo "Running yarn"
    docker compose -f "${CONFIG_DIR}/docker-compose.dev.yml" yarn $@
}
# restart servers

function frontendRestart () {
    MODE=$1

    echo "Restarting Frontend"
    _dc=docker compose -f "${CONFIG_DIR}/docker-compose.${MODE}.yml"

    _dc down && _dc up -d frontend-${MODE}
    
}

function frontendBuild () {
    
}
gitFrontendPull && \
    frontendYarn && \
    frontendBuild && \
    frontendRestart