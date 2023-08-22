#!/usr/bin/env sh
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTS_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
cd $SCRIPTS_DIR/..
BASE_DIR=$(pwd)

sudo chmod +x ${SCRIPTS_DIR}/*.sh
# sudo chown -R ${USER}: ${BASE_DIR}/{mev-bot,mev-frontend,smart-contracts}
