#!/bin/bash

while getopts "b:u:" opt; do
  case ${opt} in
    b )
      BAM_IP=$OPTARG;;
    u )
      USER=$OPTARG;;
    * )
      exit;;
  esac
done
shift $((OPTIND -1))

echo "===> STARTING GATEWAY <==="
docker run -d -p 80:8000 -p 443:44300 -v /opt/bluecat/data:/bluecat_gateway/ -v /opt/bluecat/logs:/logs/ -e BAM_IP=$BAM_IP --name bluecat_gateway quay.io/bluecat/gateway:latest
