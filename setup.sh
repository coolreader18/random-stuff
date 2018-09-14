if [[ ! -z ${GITPOD_REPO_ROOT+x} ]]; then
  setup/gitpod.sh
elif [[ -d /coder ]]; then
  ./setup/coder.sh
else
  echo "Can't detect environment"
fi

