#!/usr/bin/env bash

# Invoke code for a Reactor in an environment
# that closely emulates the Abaco runtime

# Required Globals
#   CONTAINER_IMAGE
# Optional Globals
#   REACTOR_RUN_OPTS
#   REACTOR_USE_TMP
#   REACTOR_CLEANUP_TMP
#   REACTOR_LOCALONLY
#   CONTAINER_REPO
#   CONTAINER_TAG
#   AGAVE_CACHE_DIR
#   REACTOR_JOB_DIR
#
# Required inputs
#   MESSAGE - File containing JSON message body
#   CONFIG - Reactor config file (reactor.rc)


COMMANDS="$@"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/common.sh"

if [ -z "$CONTAINER_IMAGE" ]; then
    die "CONTAINER_IMAGE not set"
fi

# API integration
AGAVE_CREDS="${AGAVE_CACHE_DIR}"
if [ ! -d "${AGAVE_CREDS}" ]; then
    AGAVE_CREDS="${HOME}/.agave"
fi
if [ ! -f "${AGAVE_CREDS}/current" ]; then
    die "No API credentials found in ${AGAVE_CREDS}"
fi

# Emphemeral directory
#  Can be specified with REACTOR_JOB_DIR
#  Can be turned off with REACTOR_NO_TMP=1
WD=${PWD}
TEMP=""
if ((REACTOR_USE_TMP )); then
    if [ ! -z "${REACTOR_JOB_DIR}" ]; then
        rm -rf "${REACTOR_JOB_DIR}";
        mkdir -p "${REACTOR_JOB_DIR}"
        TEMP=${REACTOR_JOB_DIR}
    else
        TEMP=`mktemp -d $PWD/tmp.XXXXXX`
    fi
    WD=${TEMP}
fi
log "Working directory: ${WD}"

# Volume mounts
MOUNTS="-v ${WD}:/mnt/ephemeral-01"
if [ -d "${AGAVE_CREDS}" ]; then
    MOUNTS="$MOUNTS -v ${AGAVE_CREDS}:/root/.agave:rw"
fi

envopts=""
# API_KEY=$(jq -r ._REACTOR_SLACK_WEBHOOK ${DIR}/../secrets.json)
# envopts="${envopts} -e _REACTOR_SLACK_WEBHOOK=$API_KEY"

if ((! REACTOR_LOCALONLY )); then
    envopts="${envopts} -e LOCALONLY=1"
fi

# Tweak config for Docker depending on if we're running under CI
dockeropts="${REACTOR_RUN_OPTS}"
detect_ci
if ((UNDER_CI)); then
  # If running a Dockerized process with a volume mount
  # written files will be owned by root and unwriteable by
  # the CI user. We resolve this by setting the group, which
  # is the same approach we use in the container runner
  # that powers container-powered Agave jobs
  dockeropts=" --user=0:${CI_GID}"
fi

docker run -it ${dockeropts} ${envopts} ${MOUNTS} ${CONTAINER_IMAGE} ${@}
DOCKER_RUN_EXIT_CODE="$?"

# Clean up: Set permissions and ownership on volume mount
if ((UNDER_CI)); then
    docker run ${dockeropts} -t -v ${WD}:/mnt/ephemeral-01 -w /mnt/ephemeral-01 ${CONTAINER_IMAGE} find . -type d -exec chmod 0777 {} \;
    docker run ${dockeropts} -t -v ${WD}:/mnt/ephemeral-01 -w /mnt/ephemeral-01 ${CONTAINER_IMAGE} find . -type f -exec chmod 0666 {} \;
    docker run ${dockeropts} -t -v ${WD}:/mnt/ephemeral-01 -w /mnt/ephemeral-01 ${CONTAINER_IMAGE} find . -exec chown ${CI_UID}:${CI_GID} {}
fi

if ((REACTOR_CLEANUP_TMP)) && [ -z "${TEMP}" ]; then
    log "Cleaning up ${TEMP}"
    rm -rf ${TEMP}
fi

exit ${DOCKER_RUN_EXIT_CODE}
