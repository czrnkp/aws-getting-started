#!/bin/bash

set -e

registry="registry-aws.blockapps.net:5000"
usage='
   --start                             Start STRATO 
   --stop                              Stop STRATO
'

function setEnv {
   echo "$1 = ${!1}"
   echo "Setting Env"
    export uiPassword=$(ec2metadata --instance-id)
    export DNS_NAME=$(ec2metadata --public-hostname)
    export NODE_NAME=${DNS_NAME:-localhost}
    export BLOC_URL=http://${DNS_NAME:-localhost}/bloc/v2.2
    export BLOC_DOC_URL=http://${DNS_NAME:-localhost}/docs/?url=/bloc/v2.2/swagger.json
    export STRATO_URL=http://${DNS_NAME:-localhost}/strato-api/eth/v1.2
    export STRATO_DOC_URL=http://${DNS_NAME:-localhost}/docs/?url=/strato-api/eth/v1.2/swagger.json
    export CIRRUS_URL=http://${DNS_NAME:-localhost}/cirrus/search
    export cirrusurl=nginx/cirrus
    export STRATO_GS_MODE=3 # for AWS
    export APEX_URL=${APEX_URL:-http://$DNS_NAME/apex-api}
    #export authBasic={authBasic:-true}
    export authBasic=true
    export SINGLE_NODE=true
}

function runStrato {
    setEnv
    exec docker-compose up -d
    curl http://api.mixpanel.com/track/?data=ewogICAgImV2ZW50IjogInN0cmF0b19nc19pbml0IiwKICAgICJwcm9wZXJ0aWVzIjogewogICAgICAgICJ0b2tlbiI6ICJkYWYxNzFlOTAzMGFiYjNlMzAyZGY5ZDc4YjZiMWFhMCIKICAgIH0KfQ==&ip=1
}

function stopStrato {
    docker-compose kill 
    docker-compose down -v
    echo "Stopped STRATO containers"
}

echo "
    ____  __           __   ___
   / __ )/ /___  _____/ /__/   |  ____  ____  _____
  / __  / / __ \/ ___/ //_/ /| | / __ \/ __ \/ ___/
 / /_/ / / /_/ / /__/ ,< / ___ |/ /_/ / /_/ (__  )
/_____/_/\____/\___/_/|_/_/  |_/ .___/ .___/____/
                              /_/   /_/
"

if ! docker ps &> /dev/null
then
    echo 'Error: docker is required to be installed and configured for non-root users: https://www.docker.com/'
    exit 1
fi

if ! docker-compose -v &> /dev/null
then
    echo 'Error: docker-compose is required: https://docs.docker.com/compose/install/'
    exit 2
fi

case $1 in
  "--start")
     runStrato
     exit 0
     ;;
 "--stop")
     echo "Stopping STRATO containers"
     stopStrato
     exit 0
     ;; 
 "--help")
     echo "$0 usage:"
     echo "$usage"
     exit 0
     ;;
   *)
     echo >&2 "Invalid argument: $1.  Valid arguments are:"
     printf "%s" "$usage"
     exit 1
     ;;
 esac
