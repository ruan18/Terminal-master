#!/usr/bin/env bash

# logger.sh - Módulo de logging profissional com criptografia
# Parte da suíte terminal-master

# Carrega variáveis
source "$(dirname "$0")/.env/vars.sh" 2>/dev/null || {
  echo "[ERRO] Variáveis de ambiente não encontradas."
  exit 1
}

# Cria diretório de logs com base na data atual
DATE=$(date '+%Y-%m-%d')
LOG_DIR="$(dirname "$0")/logs/$DATE"
mkdir -p "$LOG_DIR"

# Arquivo de log final
LOG_FILE="$LOG_DIR/terminal.log"

# Função de log com níveis
log() {
  local level="$1"
  local message="$2"
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

# Criptografa o log
encrypt_log() {
  openssl enc -aes-256-cbc -pbkdf2 -salt \
    -in "$LOG_FILE" \
    -out "${LOG_FILE}.enc" \
    -pass pass:"$LOG_SECRET"
  echo "[INFO] Log criptografado: ${LOG_FILE}.enc"
}

# Descriptografa o log criptografado
decrypt_log() {
  openssl enc -d -aes-256-cbc -pbkdf2 \
    -in "${LOG_FILE}.enc" \
    -out "${LOG_FILE}.dec" \
    -pass pass:"$LOG_SECRET"
  echo "[INFO] Log descriptografado: ${LOG_FILE}.dec"
}

# Argumentos diretos (modo stand-alone)
case "$1" in
  --info)
    log "INFO" "$2"
    ;;
  --error)
    log "ERROR" "$2"
    ;;
  --debug)
    log "DEBUG" "$2"
    ;;
  --encrypt)
    encrypt_log
    ;;
  --decrypt)
    decrypt_log
    ;;
  *)
    if [[ -n "$1" ]]; then
      echo "[USO] logger.sh [--info|--error|--debug <msg>] [--encrypt|--decrypt]"
    fi
    ;;
esac
