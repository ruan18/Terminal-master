#!/bin/bash
set -euo pipefail

source "$HOME/.env/vars.sh"

log_info() { echo -e "[INFO]  $*"; }
log_error() { echo -e "[ERROR] $*" >&2; }

log_info "Iniciando backup de $BACKUP_SOURCE"

if [ ! -d "$BACKUP_SOURCE" ]; then
  log_error "Diretório de origem $BACKUP_SOURCE não existe."
  exit 1
fi

mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

if tar -czf "$BACKUP_FILE" -C "$(dirname "$BACKUP_SOURCE")" "$(basename "$BACKUP_SOURCE")"; then
  log_info "Backup criado: $BACKUP_FILE"
else
  log_error "Falha ao criar o backup."
  exit 1
fi

BACKUP_ENC="$BACKUP_FILE.enc"
if openssl enc -aes-256-cbc -salt -pbkdf2 -k "$LOG_ENCRYPTION_KEY" -in "$BACKUP_FILE" -out "$BACKUP_ENC"; then
  log_info "Backup criptografado salvo em: $BACKUP_ENC"
  rm -f "$BACKUP_FILE"
else
  log_error "Falha na criptografia do backup."
  exit 1
fi

log_info "Backup finalizado com sucesso!"
