#!/bin/bash

# Carrega variáveis de ambiente
ENV_FILE="$HOME/terminal-master/config/.env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "[ERRO] Arquivo .env não encontrado em $ENV_FILE"
    exit 1
fi

# Validação das variáveis essenciais
for var in LOG_DIR LOG_FILE_PREFIX NETWORK_INTERFACE MEMINFO_CMD; do
    if [ -z "${!var}" ]; then
        echo "[ERRO] Variável $var não está definida no .env"
        exit 1
    fi
done

# Timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Criação do diretório de log, se não existir
mkdir -p "$LOG_DIR"

# Caminho completo do log
logfile="$LOG_DIR/${LOG_FILE_PREFIX}_healthcheck.log"

# Função para logar
log() {
    echo "[$timestamp] $1" | tee -a "$logfile"
}

log "Iniciando healthcheck"

# CPU Load Average
loadavg=$(cut -d ' ' -f1 /proc/loadavg)
log "CPU Load Average: $loadavg"

# Memória RAM com free -m
read mem_used mem_total <<< $(eval "$MEMINFO_CMD")
mem_pct=$(( 100 * mem_used / mem_total ))
log "Memória usada: ${mem_used} MB / ${mem_total} MB (${mem_pct}%)"

# Disco
disk_info=$(df / | awk 'END {print $3, $2}')
disk_used=$(echo "$disk_info" | cut -d' ' -f1)
disk_total=$(echo "$disk_info" | cut -d' ' -f2)
disk_pct=$(( 100 * disk_used / disk_total ))
log "Disco usado: ${disk_used} KB / ${disk_total} KB (${disk_pct}%)"

# Rede
rx_bytes=$(cat /sys/class/net/${NETWORK_INTERFACE}/statistics/rx_bytes)
tx_bytes=$(cat /sys/class/net/${NETWORK_INTERFACE}/statistics/tx_bytes)
log "Network ${NETWORK_INTERFACE} - RX bytes: $rx_bytes, TX bytes: $tx_bytes"

log "Healthcheck finalizado"
