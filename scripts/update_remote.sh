#!/usr/bin/env bash


tar czf - --exclude="*node_modules*" --exclude="*data/mongo*" . |
  ssh administrator@betteryourweb.com "cd /docker/hosting && tar zxfv - -C ." && \
  ssh administrator@betteryourweb.com "cd /docker/hosting && ./scripts/start.sh" && \
    ssh administrator@betteryourweb.com 'sed -i "s|5880:|80:|" /docker/hosting/betteryourweb-loadbalancer.yml && sed -i "s|5443:|443:|" /docker/hosting/betteryourweb-loadbalancer.yml && /docker/hosting/scripts/start.sh'