#!/bin/bash

source "./lib/install_helper.sh"
announce "Goland"
require_function jq
require_function tar

TEMP_DIR="${INSTALLER_DIR}/goland"
VERSION_FILE="${TEMP_DIR}/goland-install-version.txt"
reset_directory "${TEMP_DIR}"
curl_download "https://data.services.jetbrains.com/products/releases?code=GO&latest=true&type=release" "${VERSION_FILE}"
GOLAND_VERSION="$(jq -r '.GO[0].version' "${VERSION_FILE}")"
skip_installed "GoLand-${GOLAND_VERSION}"

cd "${TEMP_DIR}" || fail "could not change into ${TEMP_DIR}"
ensure_directory "/usr/local/bin"
ensure_directory "/usr/local/lib"
ensure_directory "/usr/local/lib/goland-${GOLAND_VERSION}"
curl_download "https://download.jetbrains.com/go/goland-${GOLAND_VERSION}.tar.gz" "${TEMP_DIR}/goland.tar.gz"
tar -C "/usr/local/lib/" -xzvf "${TEMP_DIR}/goland.tar.gz" || fail "could not extract goland to install directory"
rm -f "/usr/local/bin/goland"
ln -s "/usr/local/lib/GoLand-${GOLAND_VERSION}/bin/goland.sh" "/usr/local/bin/goland" || fail "could not link goland to local bin"
reset_directory "${TEMP_DIR}"

set_installed "GoLand-${GOLAND_VERSION}"





