#!/usr/bin/env bash

set -e

if [[ -z ${R_S_ENV+x} ]]; then
  if [[ ! -z ${GITPOD_REPO_ROOT+x} ]]; then
    R_S_ENV=gitpod
  elif [[ -d /coder ]]; then
    R_S_ENV=coder
  elif [[ ${PWD} =~ termux ]]; then
    R_S_ENV=termux
  else
    echo "Can't detect environment"
    exit 1
  fi
fi

if [[ $(find kahoot-hack -maxdepth 0 -empty -exec echo {} is empty. \;) ]]; then
  git submodule init
  git submodule update
fi


. .setup/$R_S_ENV.sh
