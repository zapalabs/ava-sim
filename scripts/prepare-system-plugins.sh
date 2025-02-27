#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

curr="${PWD}"

# Download coreth
coreth_version='v0.8.9-rc.1'
evm_path="${PWD}/build/system-plugins/evm"

if [ ! -d "system-plugins" ]
then
  echo "Building Coreth @ ${coreth_version} ..."
  go get "github.com/ava-labs/coreth@$coreth_version";
  coreth_path="$GOPATH/pkg/mod/github.com/ava-labs/coreth@$coreth_version"
  cd "$coreth_path"
  go build -ldflags "-X github.com/ava-labs/coreth/plugin/evm.Version=$coreth_version" -o "$evm_path" "plugin/"*.go
  cd "$curr"
  go mod tidy
fi
