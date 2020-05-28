#!/bin/bash

# Exit on any script failures
set -e -o pipefail

# Do not run haproxy without REMOTE_ADDR
if [[ ! -n "${REMOTE_ADDR}" ]]; then
  echo "Environment variable REMOTE_ADDR is not set."
else
  # Tweak haproxy config
  sed -i /etc/haproxy/haproxy.cfg \
      -e "s|REMOTE_ADDR|${REMOTE_ADDR}|g"
  # Run haproxy daemon
  exec haproxy -f /etc/haproxy/haproxy.cfg &
#   exec su-exec root haproxy -f /etc/haproxy/haproxy.cfg &
fi

exec echo ${OC_PASSWORD:?'missing OC_PASSWORD variable'} | openconnect --passwd-on-stdin "$@"
