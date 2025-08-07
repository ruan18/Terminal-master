#!/bin/bash
set -euo pipefail

PROJECT_ROOT="$HOME/terminal-master"
ENV_VARS_FILE="$HOME/.env/vars.sh"
BACKUP_DIR="$PROJECT_ROOT/backups"

if [ -d "$HOME/Documents" ]; then
  BACKUP_SOURCE="$HOME/Documents"
elif [ -d "$HOME/Documentos" ]; then
  BACKUP_SOURCE="$HOME/Documentos"
else
  echo "[WARN] Pasta padrão Documentos não encontrada. Criando..."
  BACKUP_SOURCE="$HOME/Documentos"
  mkdir -p "$BACKUP_SOURCE"
fi

mkdir -p "$(dirname "$ENV_VARS_FILE")"

cat > "$ENV_VARS_FILE" << EOF
export PROJECT_ROOT="$PROJECT_ROOT"
export LOGGER_MODULE="\$PROJECT_ROOT/modules/logger/logger.sh"
export BACKUP_DIR="$BACKUP_DIR"
export BACKUP_SOURCE="$BACKUP_SOURCE"
export LOG_ENCRYPTION_KEY="sua-chave-forte-aqui"
EOF

chmod +rx "$ENV_VARS_FILE"

echo "[OK] Variáveis criadas em $ENV_VARS_FILE"
echo "[INFO] BACKUP_SOURCE definido como: $BACKUP_SOURCE"

mkdir -p "$BACKUP_DIR"
mkdir -p "$PROJECT_ROOT/modules/backup"

cat > "$PROJECT_ROOT/modules/backup/backup.sh" << 'EOB'
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
EOB

chmod +x "$PROJECT_ROOT/modules/backup/backup.sh"

echo "[OK] Script backup.sh criado em $PROJECT_ROOT/modules/backup/backup.sh"

echo "[INFO] Executando teste do backup..."

bash "$PROJECT_ROOT/modules/backup/backup.sh"

echo "[SUCESSO] Backup criado, criptografado e variável corrigida."
