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

cat >>/etc/openconnect.cfg <<EOF

user        ${OC_USER:?'missing OC_USER variable'}}
password    ${OC_PASSWORD:?'missing OC_PASSWORD variable'}}

EOF

exec openconnect --config=/etc/openconnect.cfg "$@"
# exec bash -c "$@"
