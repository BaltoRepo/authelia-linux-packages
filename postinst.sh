#!/usr/bin/env bash
# Postinst script for Authelia.
set -e

ACTION=$1
case ${ACTION} in

  configure)
    systemctl enable authelia
    ;;

esac
