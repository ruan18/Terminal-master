#!/bin/bash

# healthcheck.sh - Script completo de verificação de sistema com criptografia moderna e robustez

LOG_DIR="$HOME/terminal-master/logs"
LOG_FILE="$LOG_DIR/healthcheck.log"
ENCRYPTED_LOG_FILE="$LOG_DIR/healthcheck.log.enc"
KEY_FILE="$HOME/terminal-master/.secreta.logkey"

# Cria diretório de logs, se não existir
mkdir -p "$LOG_DIR"

# Garante permissões corretas
chmod -R u+rwX "$LOG_DIR"
chown -R "$USER":"$USER" "$LOG_DIR"

# Gera chave se não existir
if [ ! -f "$KEY_FILE" ]; then
    openssl rand -base64 32 > "$KEY_FILE"
fi

# Início do log
echo "[$(date +'%F %T')] Iniciando healthcheck" >> "$LOG_FILE"

# CPU Load
LOAD=$(awk '{print $1}' /proc/loadavg)
echo "[$(date +'%F %T')] CPU Load Average: $LOAD" >> "$LOG_FILE"

# Memória
MEM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/^Mem:/ {print $3}')
if [[ -n "$MEM_TOTAL" && -n "$MEM_USED" ]]; then
    MEM_PERC=$(( MEM_USED * 100 / MEM_TOTAL ))
    echo "[$(date +'%F %T')] Memória usada: $MEM_USED MB / $MEM_TOTAL MB (${MEM_PERC}%)" >> "$LOG_FILE"
else
    echo "[$(date +'%F %T')] [ERRO] Falha ao obter dados de memória" >> "$LOG_FILE"
fi

# Disco
DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
echo "[$(date +'%F %T')] Disco usado: $DISK" >> "$LOG_FILE"

# Rede
IFACE=$(ip route | grep default | awk '{print $5}')
RX=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
TX=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
echo "[$(date +'%F %T')] Network $IFACE - RX: $RX bytes, TX: $TX bytes" >> "$LOG_FILE"

# Temperatura (somente se lm-sensors instalado)
if command -v sensors &>/dev/null; then
    TEMP=$(sensors | grep -m 1 -Eo '[+-][0-9]+\.[0-9]+°C')
    echo "[$(date +'%F %T')] Temperatura CPU: $TEMP" >> "$LOG_FILE"
else
    echo "[$(date +'%F %T')] Temperatura CPU: [lm-sensors não instalado]" >> "$LOG_FILE"
fi

# Criptografa o log com pbkdf2
openssl enc -aes-256-cbc -pbkdf2 -salt \
    -in "$LOG_FILE" \
    -out "$ENCRYPTED_LOG_FILE" \
    -pass file:"$KEY_FILE"

# Remove log original após criptografia
rm -f "$LOG_FILE"

echo "[$(date +'%F %T')] Log criptografado salvo em $ENCRYPTED_LOG_FILE"
echo "[$(date +'%F %T')] Healthcheck finalizado"
