#!/bin/bash
# my bash template
set -o errexit
set -o nounset
shopt -s nullglob

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function die() {
    echo "ERROR $? IN ${BASH_SOURCE[0]} AT LINE ${BASH_LINENO[0]}" 1>&2
    exit 1
}
trap die ERR

source /etc/pushover.d/session-notify.sh

# requires the following environment variables
# PUSHOVER_API_TOKEN
# PUSHOVER_USER_KEY

message="user:$(id -un) ${1:-no args}"

curl -s \
  --form-string "token=${PUSHOVER_API_TOKEN}" \
  --form-string "user=${PUSHOVER_USER_KEY}" \
  --form-string "message=\"$message\"" \
  https://api.pushover.net/1/messages.json
