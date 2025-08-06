#!/bin/bash

LOG_DIR="$HOME/terminal-master/logs/logger"
mkdir -p "$LOG_DIR"
ENCRYPTION_PASS="chave_forte_123"
LOG_FILE="$LOG_DIR/test-minimal.log"
ENCRYPTED_LOG_FILE="$LOG_FILE.enc"

echo "Mensagem de teste mínima $(date)" > "$LOG_FILE"

openssl enc -aes-256-cbc -salt -pbkdf2 -in "$LOG_FILE" -out "$ENCRYPTED_LOG_FILE" -pass pass:"$ENCRYPTION_PASS"

openssl enc -d -aes-256-cbc -pbkdf2 -in "$ENCRYPTED_LOG_FILE" -out "${LOG_FILE}.decrypted" -pass pass:"$ENCRYPTION_PASS"

cat "${LOG_FILE}.decrypted"
