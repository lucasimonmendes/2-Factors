#!/usr/bin/env bash
#########################################################################################
# Name: Lucas Simon
# Email: lucasimonmendes@gmail.com
#
#
# Program name:2-Factors
# Version: 2.0
# Licence: GPLv2
# Description: 2FA password generator
#
# CHANGELOG:
# 04/09/2024 - Lucas Simon
#   - [Added]  newKey, list and generate 2fa password functions.
# 06/09/2024 - Lucas Simon
#   - [Added] remove service feature and fix error function.
#########################################################################################
set -e
################################## Variables
export SOURCE="${HOME}/.2faStore"

################################## Tests
# gpg (symmetric encryption), oathtools (generate 2fa password)
for check in 'gpg' 'oathtool'; do
  if ! which $check &>/dev/null; then
    echo "Need the software $check instaled"
    exit 1
  fi
done
################################## Functions
function USAGE() {
  cat <<EOF
2Factors - 2FA Password Generator.
2-Factors.sh [--option] [service]

--new    | -n 
              Add a new key.
--totp   | -t 
              Generate a 2FA password, 30 seconds.
--list   | -l
              List of avaliabe services.
--remove | -r 
              Remove service.
EOF
  exit 0
}

function start() {
  if [[ ! -d "$SOURCE" ]]; then
    mkdir -v "$SOURCE"
    chmod 0700 "$SOURCE"
  fi
}

function die() {
  echo "$@"
  exit 1
}

function newKey() { # Add new key
  if [[ -n "$1" ]]; then
    local service="$1"
  else
    read -ep "What is the name of the service? " service
    [[ -z "$service" ]] && die "Need service name."
  fi
  service="${service,,}"
  read -ep "Secret key of service ${service}: " secretKey
  [[ -z "$secretKey" ]] && die "Need secret key."
  gpg --quiet --symmetric --out ${SOURCE}/${service} <<<"$secretKey"
}

function list() {
  cd $SOURCE
  for list in *; do
    if [[ "$list" = '*' ]]; then
      echo "No services are avaliable."
      exit 0
    else
      echo "----> $list"
    fi
  done
}

function totp() {
  if [[ -n "$1" ]]; then
    local service="$1"
  else
    read -ep "What is the service? " service
    [[ -z "$service" ]] && die "Need service name."
  fi
  # decript file of service
  generate="$(gpg --quiet <${SOURCE}/$service)"
  oathtool --base32 --totp "$generate"

}

function removeService() {
  local service=${1,,}

  if [[ ! -f "${SOURCE}/$service" ]]; then
    die "Service $service does not exist."
  else
    rm "${SOURCE}/$service"
    echo "Service $service removed successfully!"
    exit 0
  fi
}
################################## Main
start

# 1. Add new key
# 2. Generate a password
# 3. List avaliable services

case $1 in
--new | -n) newKey "$2" ;;
--totp | -t) totp "$2" ;;
--list | -l) list ;;
--remove | -r) removeService "$2" ;;
*) USAGE ;;
esac
