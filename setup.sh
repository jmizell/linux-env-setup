#!/bin/bash

export TERM=xterm-256color
source "./lib/install_helper.sh"

TEMP_DIR="${INSTALLER_DIR}/workvm-setup/"
reset_directory "${TEMP_DIR}"
cp -rv install_*.sh lib "${TEMP_DIR}" || fail "could not copy installers to temp dir"
cd "${TEMP_DIR}"|| fail "could not change directory to ${TEMP_DIR}"

ls -aln
for i in install_*.sh; do
  echo "${i}"
  if ! "./${i}"; then
    exit $?
  fi
done
