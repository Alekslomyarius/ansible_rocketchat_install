#!/bin/bash
usage() { 
    echo "Usage: $0 -f <rocketchat folder> -v <rocketchat version>";
    exit 1;
}

while getopts ":f:v:" o; do
    case "${o}" in
        f)
            ROCKETCHAT_FOLDER=${OPTARG}
            ;;
        v)
            ROCKETCHAT_VERSION=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${ROCKETCHAT_FOLDER}" ] || [ -z "${ROCKETCHAT_VERSION}" ]; then
    usage
fi

cd $ROCKETCHAT_FOLDER && \
docker pull registry.rocket.chat/rocketchat/rocket.chat:"$ROCKETCHAT_VERSION"
docker-compose stop
docker-compose rm
docker-compose up -d