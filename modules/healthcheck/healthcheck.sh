#!/bin/bash

# Caminhos
PROJECT_ROOT="$HOME/terminal-master"
LOGGER_MODULE="$PROJECT_ROOT/modules/logger/logger.sh"
LOG_DIR="$PROJECT_ROOT/logs/healthcheck"
LOG_FILE="$LOG_DIR/healthcheck.log"
ENCRYPTED_LOG="$LOG_FILE.enc"
LOG_ENCRYPTION_KEY="${LOG_ENCRYPTION_KEY:-sua-chave-forte-aqui}"

# Carregar logger
source "$LOGGER_MODULE" || {
    echo "[ERRO] Falha ao carregar logger"
    exit 1
}

mkdir -p "$LOG_DIR"

# Captura de dados do sistema
UPTIME=$(uptime -p | sed 's/up //')

# RAM total e usada usando grep e awk para garantir formato
RAM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
RAM_USADO=$(free -h | grep Mem | awk '{print $3}')

# Disco
DISK_INFO=$(df -h / | awk 'NR==2 {print $3 " usados de " $2 " (" $5 ")"}')

# Load average
LOAD_AVG=$(uptime | awk -F'load average: ' '{print $2}')

# Mensagem
HEALTH_MSG="[HEALTH] $(date '+%a %d %b %Y %T %Z') | Uptime: $UPTIME | RAM: $RAM_USADO usados de $RAM_TOTAL | Disco: $DISK_INFO | Load: $LOAD_AVG"
echo "$HEALTH_MSG" > "$LOG_FILE"
log_info "$HEALTH_MSG"

# Criptografar log
openssl enc -aes-256-cbc -salt -pbkdf2 -in "$LOG_FILE" -out "$ENCRYPTED_LOG" -k "$LOG_ENCRYPTION_KEY" 2>/dev/null
log_info "Log criptografado salvo em $ENCRYPTED_LOG"
