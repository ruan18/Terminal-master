#!/usr/bin/env bash

#==========================#
#  Terminal Master - ALERT #
#==========================#

# Variáveis
BOT_TOKEN="7760230057:AAENyGcDwdNk7P4ygsXGIfDIhkBdWJAKcHE"
CHAT_ID="7812876856"

# Função para enviar mensagem
send_telegram() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
         -d chat_id="${CHAT_ID}" \
         -d text="${message}" \
         -d parse_mode="Markdown" > /dev/null
}

# Se chamado diretamente com argumento
if [[ "$1" != "" ]]; then
    send_telegram "$@"
fi

