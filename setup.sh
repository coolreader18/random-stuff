if [[ ! -z ${GITPOD_REPO_ROOT+x} ]]; then
  setup/gitpod.sh
else
  echo "Can't detect environment"
fi