#!/bin/bash

source "./lib/install_helper.sh"
announce "Golang"
require_function grep
require_function tar

TEMP_DIR="${INSTALLER_DIR}/go"
VERSION_FILE="${TEMP_DIR}/go-install-version.txt"
reset_directory "${TEMP_DIR}"
curl_download "https://go.dev/VERSION?m=text" "${VERSION_FILE}"
GO_VERSION="$(cat "${VERSION_FILE}")"
if ! grep -qE '^go[0-9]{1,2}\.[0-9]{1,2}' "${VERSION_FILE}"; then
  echo "Unrecognized version ${GO_VERSION}."
  return 1
fi
skip_installed "${GO_VERSION}"

cd "${TEMP_DIR}" || fail "could not change into ${TEMP_DIR}"
curl_download "https://golang.org/dl/${GO_VERSION}.linux-amd64.tar.gz" "${TEMP_DIR}/go.tar.gz"
reset_directory "/usr/local/lib/go"
tar -xzvf "${TEMP_DIR}/go.tar.gz" || fail "could not extract archive"
mv -v "${TEMP_DIR}/go" "/usr/local/lib/go/${GO_VERSION}" || fail "could not move go directory to local lib"
remove_file "/usr/local/bin/gofmt"
remove_file "/usr/local/bin/go"
ln -sv "/usr/local/lib/go/${GO_VERSION}/bin/go" "/usr/local/bin/go" || fail "could not link go binary"
ln -sv "/usr/local/lib/go/${GO_VERSION}/bin/gofmt" "/usr/local/bin/gofmt" || fail "could not link gofmt binary"
reset_directory "${TEMP_DIR}"

set_installed "${GO_VERSION}"
