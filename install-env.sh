#!/bin/bash

set -e
sudo -v
# 設定 Go 版本
GO_VERSION=1.20.14
GO_TAR=go$GO_VERSION.linux-amd64.tar.gz

# 1. 安裝 Go
if ! command -v go &>/dev/null; then
    echo "安裝 Go $GO_VERSION..."
    wget https://go.dev/dl/$GO_TAR
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $GO_TAR
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    source ~/.bashrc
    rm $GO_TAR
else
    echo "Go 已安裝，版本為 $(go version)"
fi

# 2. 安裝 jq
if ! command -v jq &>/dev/null; then
    echo "安裝 jq..."
    sudo apt-get update
    sudo apt-get install -y jq
else
    echo "jq 已安裝，版本為 $(jq --version)"
fi

# 3. 下載 fabric-samples 並取得 binaries
if [ ! -d "fabric-samples" ]; then
    echo "下載 fabric-samples..."
    git clone https://github.com/hyperledger/fabric-samples.git
    cd fabric-samples
    git checkout main
    echo "執行 bootstrap.sh 下載 binaries 和 docker 映像..."
    chmod +x scripts/bootstrap.sh
    ./scripts/bootstrap.sh
else
    echo "fabric-samples 資料夾已存在"
fi

echo "環境設定完成！請重新打開 terminal 或執行 'source ~/.bashrc'"
