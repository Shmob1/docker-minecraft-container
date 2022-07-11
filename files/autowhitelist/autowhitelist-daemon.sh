#!/bin/bash

# needed for the clients connected function residing in autopause
. /autopause/autopause-fcns.sh

# shellcheck source=start-utils
. ${SCRIPTS:-/}start-utils

whitelist_file=/data/whitelist.json

# wait for java process to be started
while :
do
  if java_process_exists ; then
    break
  fi
  sleep 0.1
done

while :
do
  # get the new whitelist file
  curl -X GET -s --output ${whitelist_file} $WHITELIST_FILE
  mc-send-to-console whitelist reload
  log "autowhitelist updated whitelist" 
  sleep $AUTOWHITELIST_TIMEOUT
done