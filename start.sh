#!/bin/sh

if [ -f /data/options.json ]; then
  export SERVER_PORT=$(jq -r '.SERVER_PORT // ""' /data/options.json)
  export SECRET_KEY=$(jq -r '.SECRET_KEY // ""' /data/options.json)
  export FRONTEND=$(jq -r '.FRONTEND // ""' /data/options.json)
  export START_ALL_SESSION=$(jq -r '.START_ALL_SESSION // ""' /data/options.json)
  export WEBHOOK_URL=$(jq -r '.WEBHOOK_URL // ""' /data/options.json)
fi

mkdir -p /data/tokens /data/userDataDir
ln -sf /data/tokens /usr/src/wpp-server/tokens
ln -sf /data/userDataDir /usr/src/wpp-server/userDataDir

CMD="node bin/wppserver.js"
[ -n "$SERVER_PORT" ] && CMD="$CMD -p $SERVER_PORT"
[ -n "$SECRET_KEY" ] && CMD="$CMD -k $SECRET_KEY"
[ "$FRONTEND" = "true" ] && CMD="$CMD --frontend"
[ "$START_ALL_SESSION" = "true" ] && CMD="$CMD --startAllSession"
[ -n "$WEBHOOK_URL" ] && CMD="$CMD --webhook-url $WEBHOOK_URL"

exec $CMD 2>&1 | iconv -f ISO-8859-1 -t UTF-8