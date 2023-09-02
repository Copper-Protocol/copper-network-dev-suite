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

echo "Updating all git repositories"

GIT_REPOS=("frontend" "api" "smart-comtracts")
cd "${BASE_DIR}"

BRANCH="${1}"
COMMENT="${1}"

[[ -z "${BRANCH}" ]] && {
    echo "BRANCH NOT SELECTED"
    exit 1
}
[[ -z "${COMMENT}" ]] && {
    echo "WARNING: COMMENT NOT ADDED"
    read 
}

for repo in "${GIT_REPOS[@]}"; do
    echo "REPO: ${repo}"
    pushd "${BASE_DIR}/${repo}"
    git add .
    git commit -m "Updating: ${COMMENT}"
done