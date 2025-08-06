#!/usr/bin/env bash

LOG_DIR="logs/$(date +%Y-%m-%d)"
mkdir -p "$LOG_DIR"

LOG_ENCRYPT_KEY="${LOG_ENCRYPT_KEY:-default_key}"

LEVEL="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
MESSAGE="$2"
TIMESTAMP="$(date +'%Y-%m-%d %H:%M:%S')"
LOG_FILE="$LOG_DIR/$LEVEL.log"

LOG_FORMAT="[$TIMESTAMP] $LEVEL: $MESSAGE"

# Cria o log temporário
echo "$LOG_FORMAT" > /tmp/log.raw

# Criptografa com OpenSSL (modo seguro com -pbkdf2)
openssl enc -aes-256-cbc -salt -pbkdf2 -pass pass:"$LOG_ENCRYPT_KEY" -in /tmp/log.raw -out "$LOG_FILE"

# Limpa temporário
rm -f /tmp/log.raw
