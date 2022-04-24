#!/bin/bash

INSTALLED_DIR="/usr/local/share/workvm/installed"
INSTALLER_DIR="/var/share/workvm/install"

function announce() {
  local msg="${1}"
  if [[ "${msg}" == "" ]]; then
    echo "announce check missing msg parameter"
    exit 2
  fi
  echo ""
  echo "***********************************************************"
  echo "  ${msg}"
  echo "***********************************************************"
  echo ""
}

function require_function() {
  local command="${1}"
  if [[ "${command}" == "" ]]; then
    echo "require_function check missing command parameter"
    exit 2
  fi
  type "${command}" >/dev/null 2>&1 && return 0
  echo "missing ${command}"
  exit 1
}

function require_directory() {
  local directory="${1}"
  if [[ "${directory}" == "" ]]; then
    echo "require_directory check missing directory parameter"
    exit 2
  fi
  if [[ -d "${directory}" ]]; then
    return 0
  fi
  echo "missing ${directory}"
  exit 1
}

function require_file() {
  local file="${1}"
  if [[ "${file}" == "" ]]; then
    echo "require_file check missing file parameter"
    exit 2
  fi
  if [[ -f "${file}" ]]; then
    return 0
  fi
  echo "missing ${file}"
  exit 1
}

function ensure_directory() {
  local directory="${1}"
  if [[ "${directory}" == "" ]]; then
    echo "ensure_directory check missing directory parameter"
    exit 2
  fi
  mkdir -p "${directory}"
  if ! [[ -d "${directory}" ]]; then
    echo "path ${directory} could not be created"
    exit 2
  fi
}

function remove_directory() {
  local directory="${1}"
  if [[ "${directory}" == "" ]]; then
    echo "remove_directory check missing directory parameter"
    exit 2
  fi
  rm -rf "${directory}"
  if [[ -d "${directory}" ]]; then
    echo "path ${directory} could not be removed"
    exit 2
  fi
}

function remove_file() {
  local file="${1}"
  if [[ "${file}" == "" ]]; then
    echo "remove_file check missing file parameter"
    exit 2
  fi
  rm "${file}"
  if [[ -f "${file}" ]]; then
    echo "file ${file} could not be removed"
    exit 2
  fi
}

function reset_directory() {
  local directory="${1}"
  if [[ "${directory}" == "" ]]; then
    echo "reset_directory check missing directory parameter"
    return 2
  fi
  remove_directory "${directory}"
  ensure_directory "${directory}"
}

function curl_download() {
  require_function curl

  local url="${1}"
  local output="${2}"
  if [[ "${url}" == "" ]]; then
    echo "curl_download check missing url parameter"
    exit 2
  fi
  if [[ "${output}" == "" ]]; then
    echo "curl_download check missing output parameter"
    exit 2
  fi

  if ! curl --fail -L "${url}" -o "${output}"; then
    echo "curl could not retrieve ${url}"
    exit 2
  fi
  if ! [[ -f "${output}" ]]; then
    echo "file ${output} was not written by curl"
    exit 2
  fi
}

function set_installed() {
  local name="${1}"
  touch "${INSTALLED_DIR}/${name}"
  echo "set ${INSTALLED_DIR}/${name}"
}

function skip_installed() {
  local name="${1}"
  if [[ -f "${INSTALLED_DIR}/${name}" ]]; then
    echo "${name} already installed"
    exit 0
  fi
}

function fail() {
  local msg="${1}"
  echo ""
  echo "${msg}"
  exit 1
}

ensure_directory "${INSTALLED_DIR}"
ensure_directory "${INSTALLER_DIR}"
