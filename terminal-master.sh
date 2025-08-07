#!/bin/bash

# === terminal-master.sh ===
# Script principal da suíte terminal-master
# Centraliza todos os módulos: logger, monitor, backup...

# === Carrega variáveis ===
PROJECT_ROOT="$HOME/terminal-master"
ENV_FILE="$HOME/.env/vars.sh"
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

# === Exibe ajuda ===
function help_menu() {
    echo -e "\n📦 terminal-master.sh - Módulos disponíveis:"
    echo "  --logger-test       Testar logger com mensagens de info/erro/debug"
    echo "  --encrypt-log       Criptografar log de exemplo"
    echo "  --decrypt-log       Descriptografar log de exemplo"
    echo "  --monitor           Rodar módulo de monitoramento do sistema"
    echo "  --backup            Rodar backup do diretório alvo"
    echo "  --help              Exibir este menu de ajuda"
}

# === Verifica argumentos ===
case "$1" in
    --logger-test)
        bash "$PROJECT_ROOT/modules/logger/logger.sh" --info "Sistema iniciado com sucesso"
        bash "$PROJECT_ROOT/modules/logger/logger.sh" --error "Falha na autenticação"
        bash "$PROJECT_ROOT/modules/logger/logger.sh" --debug "Verificando variáveis"
        exit 0
    ;;

    --encrypt-log)
        bash "$PROJECT_ROOT/modules/logger/logger.sh" --encrypt
        exit 0
    ;;

    --decrypt-log)
        bash "$PROJECT_ROOT/modules/logger/logger.sh" --decrypt
        exit 0
    ;;

    --monitor)
        bash "$PROJECT_ROOT/modules/monitor/monitor.sh"
        exit 0
    ;;

    --backup)
        bash "$PROJECT_ROOT/modules/backup/backup.sh"
        exit 0
    ;;

    --help | *)
        help_menu
        exit 0
    ;;
esac
