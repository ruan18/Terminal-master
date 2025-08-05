#!/bin/bash

# Configurações do bot Telegram
BOT_TOKEN="7760230057:AAENyGcDwdNk7P4ygsXGIfDIhkBdWJAKcHE"
CHAT_ID="7812876856"  # Seu chat ID privado ou grupo

# Mensagem que será enviada
MESSAGE="$1"

# Envia a mensagem via Telegram API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"
