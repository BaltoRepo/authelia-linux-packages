#!/usr/bin/env bash
# Prerm script for Authelia.
set -e

ACTION=$1
case ${ACTION} in

  remove)
    systemctl disable authelia
    ;;

esac
