#!/bin/bash

source "./lib/install_helper.sh"
announce "Golang Tools"
require_function go

TEMP_DIR="${INSTALLER_DIR}/gotools"
reset_directory "${TEMP_DIR}"

export GOPATH="${TEMP_DIR}/go"
ensure_directory "/usr/local/bin"
go install "github.com/onsi/ginkgo/v2/ginkgo@latest" || fail "failed to install ginkgo"
mv "${TEMP_DIR}/go/bin/ginkgo" "/usr/local/bin/gingko" || fail "failed to move ginkgo to path"
go install "github.com/golangci/golangci-lint/cmd/golangci-lint@latest" || fail "failed to install golangci-lint"
mv "${TEMP_DIR}/go/bin/golangci-lint" "/usr/local/bin/golangci-lint" || fail "failed to move golangci-lint to path"
go install "github.com/spf13/cobra-cli@latest" || fail "failed to install cobra-cli"
mv "${TEMP_DIR}/go/bin/cobra-cli" "/usr/local/bin/cobra-cli" || fail "failed to move cobra-cli to path"
go install "golang.org/x/tools/cmd/godoc@latest" || fail "failed to install godoc"
mv "${TEMP_DIR}/go/bin/godoc" "/usr/local/bin/godoc" || fail "failed to move godoc to path"
go install "github.com/golang/mock/mockgen@latest" || fail "failed to install mockgen"
mv "${TEMP_DIR}/go/bin/mockgen" "/usr/local/bin/mockgen" || fail "failed to move mockgen to path"

reset_directory "${TEMP_DIR}"
