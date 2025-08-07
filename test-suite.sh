#!/bin/bash
# test-suite.sh - Teste automático dos módulos do terminal-master

set -euo pipefail

PROJECT_ROOT="$HOME/terminal-master"
LOG_DIR="$PROJECT_ROOT/logs"
BACKUP_DIR="$PROJECT_ROOT/backups"

# Função para checar se comando retornou sucesso
check_status() {
  if [ $1 -eq 0 ]; then
    echo "[OK] $2"
  else
    echo "[FAIL] $2"
  fi
}

echo "=== Iniciando Teste da Suíte terminal-master ==="
echo

# 1) Teste logger
echo "1) Testando módulo Logger..."
bash "$PROJECT_ROOT/modules/logger/logger.sh" --info "Teste de log automático" >/dev/null 2>&1
check_status $? "Logger executado"

# Checa arquivo de log (criptografado)
LATEST_LOG=$(find "$LOG_DIR" -type f -name '*.enc' | sort | tail -n 1 || true)
if [ -n "$LATEST_LOG" ]; then
  echo "[OK] Log criptografado gerado: $LATEST_LOG"
else
  echo "[FAIL] Log criptografado não encontrado."
fi
echo

# 2) Teste monitor
echo "2) Testando módulo Monitor..."
bash "$PROJECT_ROOT/modules/monitor/monitor.sh" >/dev/null 2>&1
check_status $? "Monitor executado"

LATEST_MON_LOG=$(find "$LOG_DIR/monitor" -type f -name '*.enc' | sort | tail -n 1 || true)
if [ -n "$LATEST_MON_LOG" ]; then
  echo "[OK] Log criptografado do monitor gerado: $LATEST_MON_LOG"
else
  echo "[FAIL] Log do monitor não encontrado."
fi
echo

# 3) Teste backup
echo "3) Testando módulo Backup..."
bash "$PROJECT_ROOT/modules/backup/backup.sh" >/dev/null 2>&1
check_status $? "Backup executado"

LATEST_BACKUP=$(find "$BACKUP_DIR" -type f -name '*.enc' | sort | tail -n 1 || true)
if [ -n "$LATEST_BACKUP" ]; then
  echo "[OK] Backup criptografado gerado: $LATEST_BACKUP"
else
  echo "[FAIL] Backup criptografado não encontrado."
fi
echo

# 4) Teste healthcheck
echo "4) Testando módulo Healthcheck..."
bash "$PROJECT_ROOT/modules/healthcheck/healthcheck.sh" >/dev/null 2>&1
check_status $? "Healthcheck executado"
echo

echo "=== Fim do teste da suíte terminal-master ==="
