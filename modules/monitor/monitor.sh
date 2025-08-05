#!/bin/bash

# ===========================
# Monitor de sistema - terminal-master
# ===========================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
LOG_DIR="$PROJECT_ROOT/logs/monitor"
LOG_FILE="$LOG_DIR/monitor.log"
ENCRYPTED_LOG="$LOG_FILE.enc"
source "$PROJECT_ROOT/.env/vars.sh"

# ===========================
# Funções de coleta
# ===========================

coletar_dados() {
    echo "[INFO] Iniciando monitoramento..."
    
    echo "Monitoramento do Sistema:" > "$LOG_FILE"

    # Load Average
    echo -n "CPU Load Average: " >> "$LOG_FILE"
    uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1-3 >> "$LOG_FILE"

    # Memória (compatível com saída em PT-BR)
    MEM_INFO=$(free -m | grep -i 'Mem')
    TOTAL_MEM=$(echo "$MEM_INFO" | awk '{print $2}')
    USED_MEM=$(echo "$MEM_INFO" | awk '{print $3}')
    echo "Memória usada: ${USED_MEM} MB / ${TOTAL_MEM} MB" >> "$LOG_FILE"

    # Disco
    DISCO=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
    echo "Disco usado: $DISCO" >> "$LOG_FILE"

    # Rede
    IFACE=$(ip route | awk '/default/ {print $5}' | head -n1)
    RX=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes)
    TX=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes)
    echo "Rede ($IFACE) - RX: $RX bytes, TX: $TX bytes" >> "$LOG_FILE"

    # Temperatura CPU (se existir)
    if command -v sensors &>/dev/null; then
        TEMP=$(sensors | grep -i 'cpu temp\|Package id 0' | awk '{print $NF}' | head -n1)
        echo "Temperatura CPU: ${TEMP:-Indisponível}" >> "$LOG_FILE"
    else
        echo "Temperatura CPU: comando 'sensors' não encontrado" >> "$LOG_FILE"
    fi
}

# ===========================
# Função de criptografia
# ===========================

criptografar_log() {
    openssl enc -aes-256-cbc -pbkdf2 -salt -in "$LOG_FILE" -out "$ENCRYPTED_LOG" -pass pass:"$LOG_PASS"
    rm "$LOG_FILE"
    echo "[INFO] Log criptografado salvo em $ENCRYPTED_LOG"
}

# ===========================
# Execução principal
# ===========================

mkdir -p "$LOG_DIR"
coletar_dados
criptografar_log
echo "[INFO] Monitoramento finalizado"

