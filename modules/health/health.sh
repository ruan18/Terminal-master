#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Carregar variáveis
if [[ -f ~/terminal-master/.env/vars.sh ]]; then
  source ~/terminal-master/.env/vars.sh
else
  echo "[ERROR] Arquivo de variáveis não encontrado!"
  exit 1
fi

LOG_DIR="${LOG_DIR:-$HOME/terminal-master/logs/health}"
ENCRYPT_KEY="${ENCRYPT_KEY:-chave_forte_123}"

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/health-$TIMESTAMP.log"
ENC_LOG_FILE="$LOG_FILE.enc"
DEC_LOG_FILE="$LOG_DIR/health-decrypted.log"

mkdir -p "$LOG_DIR"

function log() {
  local level=$1
  local message=$2
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
}

function encrypt_log() {
  openssl enc -aes-256-cbc -salt -pbkdf2 -md sha256 \
    -in "$LOG_FILE" -out "$ENC_LOG_FILE" -pass pass:"$ENCRYPT_KEY"
  rm -f "$LOG_FILE"
}

function decrypt_log() {
  if [[ -f "$ENC_LOG_FILE" ]]; then
    openssl enc -d -aes-256-cbc -pbkdf2 -md sha256 \
      -in "$ENC_LOG_FILE" -out "$DEC_LOG_FILE" -pass pass:"$ENCRYPT_KEY"
    echo "[INFO] Log descriptografado salvo em $DEC_LOG_FILE"
    cat "$DEC_LOG_FILE"
  else
    echo "[ERROR] Arquivo criptografado não encontrado: $ENC_LOG_FILE"
  fi
}

function health_check() {
  log "INFO" "Iniciando verificação de integridade do sistema"

  # Exemplo de check básico - uso de disco
  local disk_usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
  log "INFO" "Uso do disco root: $disk_usage%"

  if (( disk_usage > 90 )); then
    log "WARN" "Uso de disco está acima de 90% - atenção!"
  fi

  # Exemplo: Verificar carga média do sistema nos últimos 1 min
  local load_avg=$(cut -d ' ' -f1 /proc/loadavg)
  log "INFO" "Carga média do sistema (1 min): $load_avg"

  # Mais checks podem ser adicionados aqui
  log "INFO" "Verificação de integridade concluída"
}

case "${1:-}" in
  --run)
    health_check
    encrypt_log
    ;;
  --decrypt-log)
    decrypt_log
    ;;
  --test)
    echo "[INFO] Executando teste do módulo health..."
    health_check
    encrypt_log
    echo "[INFO] Teste concluído. Log criptografado salvo em $ENC_LOG_FILE"
    ;;
  *)
    echo "Uso: $0 {--run|--decrypt-log|--test}"
    exit 1
    ;;
esac
