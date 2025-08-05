#!/usr/bin/env bash

# Chave padrão de criptografia simétrica
export ENCRYPTION_PASSWORD="senha_super_segura_aqui"

# Caminho base do projeto
export BASE_DIR="$HOME/terminal-master"

# Caminho para logs
export LOG_DIR="$BASE_DIR/logs"

# Caminho para logs do módulo de monitoramento
export MONITOR_LOG_DIR="$LOG_DIR/monitor"

# Caminho completo para o log criptografado do monitoramento
export MONITOR_LOG_FILE="$MONITOR_LOG_DIR/monitor.log.enc"

# Caminho para binários específicos, se necessário no futuro
export BIN_DIR="$BASE_DIR/bin"
