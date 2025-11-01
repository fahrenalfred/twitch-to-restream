#!/bin/bash

TWITCH_URL="https://usher.ttvnw.net/api/channel/hls/${TWITCH_USER}.m3u8"
RESTREAM_URL="rtmp://rtmp.restream.io/live/${RESTREAM_KEY}"
SLEEP_TIME=60

echo "=== Twitch to Restream Relay iniciado ==="
echo "Canal: $TWITCH_USER"
echo "Destino: Restream"

while true; do
  echo "Chequeando si $TWITCH_USER está transmitiendo..."
  if curl -s "$TWITCH_URL" | grep -q "#EXTM3U"; then
    echo "✅ Stream detectado, iniciando FFmpeg relay..."
    ffmpeg -re -i "$TWITCH_URL" -c:v copy -c:a copy -f flv "$RESTREAM_URL" -loglevel warning
    echo "⚠️ Stream finalizado o conexión perdida."
    echo "Reintentando en $SLEEP_TIME segundos..."
  else
    echo "🔴 Offline. Revisa cada $SLEEP_TIME segundos..."
    sleep $SLEEP_TIME
  fi
done
