#!/bin/bash

# Token do bot
BOT_TOKEN="7760230057:AAENyGcDwdNk7P4ygsXGIfDIhkBdWJAKcHE"

# Seu chat ID (pode pegar no getUpdates, ou no resultado do curl)
CHAT_ID="7812876856"

# Mensagem que quer enviar
MESSAGE="Teste do bot funcionando 🔥"

# Envia a mensagem via API Telegram
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown"
