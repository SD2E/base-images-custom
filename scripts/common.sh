

UNDER_CI=0
CI_PLATFORM=
CI_UID=$(id -u ${USER})
CI_GID=$(id -g ${USER})

function die(){
    echo "[ERROR] $1"
    exit 1
}

function log(){
    echo "[INFO] $1"
}

function detect_ci() {

  ## detect whether we're running under continous integration
  if [ ! -z "${TRAVIS}" ]; then
    if [ "${TRAVIS}" == "true" ]; then
      UNDER_CI=1
      CI_PLATFORM="Travis"
      CI_UID=$(id -u travis)
      CI_GID=$(id -g travis)
    fi
  fi

  if [ ! -z "${JENKINS_URL}" ]; then
    UNDER_CI=1
    CI_PLATFORM="Jenkins"
    CI_UID=$(id -u jenkins)
    CI_GID=$(id -g jenkins)
  fi

  if ((UNDER_CI)); then
    log "Continuous integration detected ($CI_PLATFORM)"
  else
    log "Not running under continous integration"
  fi

}

function random_hex() {

  if [ -z "$1" ]; then
    length_hex=16
  else
    length_hex=$1
  fi
  cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w $length_hex | head -n 1

}
