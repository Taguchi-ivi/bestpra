#!/bin/sh
# echo "run start-server.sh" &
# rails server

# TCP通信の必要がなくなったため、rails serverコマンドからポートとバインドの設定を削除
echo "run start-server.sh" &
rails server -p 3000 -b 0.0.0.0