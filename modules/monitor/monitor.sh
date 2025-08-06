#!/bin/bash

# Módulo de monitoramento do sistema
source "$HOME/.env/vars.sh"

mkdir -p "$(dirname "$MONITOR_LOG")"

echo "[INFO] Iniciando monitoramento..." | tee -a "$MONITOR_LOG"
uptime >> "$MONITOR_LOG"
df -h >> "$MONITOR_LOG"
free -m >> "$MONITOR_LOG"
echo "[INFO] Monitoramento finalizado" | tee -a "$MONITOR_LOG"

# Criptografar log
openssl enc -aes-256-cbc -salt -pbkdf2 -pass pass:"$LOG_ENCRYPT_PASS" \
    -in "$MONITOR_LOG" -out "${MONITOR_LOG}.enc"

if [[ $? -eq 0 ]]; then
    echo "[INFO] Log criptografado salvo em ${MONITOR_LOG}.enc"
    shred -u "$MONITOR_LOG"
else
    echo "[ERROR] Falha ao criptografar log."
fi
