#!/usr/bin/env bash

if [[ -z ${R_S_ENV+x} ]]; then
  if [[ ! -z ${GITPOD_REPO_ROOT+x} ]]; then
    R_S_ENV=gitpod
  elif [[ -d /coder ]]; then
    R_S_ENV=coder
  elif [[ ${PWD} =~ termux ]]; then
    R_S_ENV=termux
  else
    echo "Can't detect environment"
  fi
fi

bash .setup/$R_S_ENV
