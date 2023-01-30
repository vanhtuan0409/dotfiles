#!/bin/env bash

profile=$1

case $profile in
  anduin)
    YKMAN_OATH_CREDENTIAL_NAME="Amazon Web Services:tuanvuong@anduintransaction" aws-vault exec anduin --json -d 24h --prompt=ykman
    ;;
  personal)
    YKMAN_OATH_CREDENTIAL_NAME="Amazon Web Services:tuanvuong@vanhtuan0409" aws-vault exec personal --json -d 24h --prompt=ykman
    ;;
  seaweedfs)
    aws-vault exec seaweedfs --no-session --json
    ;;
  *)
    echo "Unknown profile"
    exit 1
esac
