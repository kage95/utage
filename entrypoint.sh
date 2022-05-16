#!/bin/bash
set -e

# Railsのpidが存在している場合に削除する/Rails特有の問題への対処
rm -f /utage/tmp/pids/server.pid

# DockerfileのCMDで渡されたコマンド（→Railsのサーバー起動）を実行
exec "$@"