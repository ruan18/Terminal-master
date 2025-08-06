#!/bin/bash

# =============================
# terminal-master.sh
# Centralizador da suíte terminal-master
# =============================

# Diretórios base
BASE_DIR="$HOME/terminal-master"
MODULES_DIR="$BASE_DIR/modules"
LOGS_DIR="$BASE_DIR/logs"
ENV_FILE="$HOME/.env/vars.sh"
ENCRYPT_CMD="openssl enc -aes-256-cbc -salt -pbkdf2"

# Carrega variáveis do .env
if [[ -f "$ENV_FILE" ]]; then
    source "$ENV_FILE"
else
    echo "[ERROR] Arquivo .env não encontrado em $ENV_FILE"
    exit 1
fi

# =============================
# Funções utilitárias
# =============================

log() {
    local nivel="$1"
    local mensagem="$2"
    local data=$(date '+%Y-%m-%d')
    local hora=$(date '+%H:%M:%S')
    local pasta_log="$LOGS_DIR"
    local nome_script=$(basename "$0" | cut -d. -f1)
    local arquivo_log="$pasta_log/$nome_script/$data.log"
    mkdir -p "$(dirname "$arquivo_log")"
    echo "[$hora] [$nivel] $mensagem" >> "$arquivo_log"

    # Criptografar automaticamente
    if [[ -n "$LOG_ENCRYPT_PASS" ]]; then
        $ENCRYPT_CMD -pass pass:"$LOG_ENCRYPT_PASS" -in "$arquivo_log" -out "$arquivo_log.enc" 2>/dev/null
        shred -u "$arquivo_log"
    fi
}

encrypt_log() {
    local input="$1"
    local output="${input}.enc"

    if [[ ! -f "$input" ]]; then
        echo "[ERROR] Arquivo '$input' não encontrado."
        exit 1
    fi

    $ENCRYPT_CMD -pass pass:"$LOG_ENCRYPT_PASS" -in "$input" -out "$output"
    if [[ $? -eq 0 ]]; then
        echo "[INFO] Log criptografado em: $output"
        shred -u "$input"
    else
        echo "[ERROR] Falha ao criptografar log."
        exit 1
    fi
}

decrypt_log() {
    local input="$1"
    local output="${input%.enc}.dec"

    if [[ ! -f "$input" ]]; then
        echo "[ERROR] Arquivo '$input' não encontrado."
        exit 1
    fi

    $ENCRYPT_CMD -d -pass pass:"$LOG_ENCRYPT_PASS" -in "$input" -out "$output"
    if [[ $? -eq 0 ]]; then
        echo "[INFO] Log descriptografado salvo em: $output"
    else
        echo "[ERROR] Falha ao descriptografar log."
        exit 1
    fi
}

# =============================
# Execução de módulos
# =============================

run_monitor() {
    bash "$MODULES_DIR/monitor/monitor.sh"
}

# =============================
# Flags
# =============================

case "$1" in
    --encrypt-log)
        encrypt_log "$2"
        ;;
    --decrypt-log)
        decrypt_log "$2"
        ;;
    --monitor)
        run_monitor
        ;;
    --help|-h)
        echo "Uso: ./terminal-master.sh [FLAG]"
        echo ""
        echo "  --encrypt-log <arquivo>    Criptografa log com senha do .env"
        echo "  --decrypt-log <arquivo>    Descriptografa log com senha do .env"
        echo "  --monitor                  Executa o módulo de monitoramento"
        echo "  --help, -h                 Mostra este menu de ajuda"
        ;;
    *)
        echo "[ERROR] Flag inválida ou ausente. Use --help para ver as opções."
        ;;
esac
