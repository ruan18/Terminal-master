#!/bin/bash

# Caminho raiz do projeto
PROJECT_ROOT="$HOME/terminal-master"

# 1. Corrigir o source do vars.sh dentro do logger.sh
LOGGER_FILE="$PROJECT_ROOT/modules/logger/logger.sh"
sed -i 's|source .*vars\.sh|source ~/.env/vars.sh|' "$LOGGER_FILE"

# 2. Corrigir o BACKUP_SOURCE no arquivo de variáveis
VARS_FILE="$HOME/.env/vars.sh"
sed -i 's|^export BACKUP_SOURCE=.*|export BACKUP_SOURCE="$HOME/terminal-master"|' "$VARS_FILE"

# 3. Recarregar as variáveis
source "$VARS_FILE"

# 4. Rodar backup
echo "[INFO] Rodando teste de backup agora..."
bash "$PROJECT_ROOT/modules/backup/backup.sh"
