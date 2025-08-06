#!/bin/bash

# Caminho onde as variáveis serão salvas
ENV_DIR="$HOME/.env"
ENV_FILE="$ENV_DIR/vars.sh"

# Cria diretório se não existir
mkdir -p "$ENV_DIR"

# Gera arquivo com variáveis essenciais
cat << 'EOF' > "$ENV_FILE"
#!/bin/bash

# Caminhos do projeto
export TM_DIR="$HOME/terminal-master"
export TM_LOG_DIR="$TM_DIR/logs"
export TM_KEY="$TM_DIR/.secret.key"
export TM_LOG_ENC_DIR="$TM_LOG_DIR/encrypted"
export TM_LOG_DEC_DIR="$TM_LOG_DIR/decrypted"

# Telegram Bot (preencher depois)
export TELEGRAM_BOT_TOKEN=""
export TELEGRAM_CHAT_ID=""

# Configurações de criptografia
export OPENSSL_CIPHER="aes-256-cbc"
export OPENSSL_PBKDF="pbkdf2"  # Use pbkdf2 para evitar warning
export OPENSSL_ITER=100000
EOF

# Ajusta permissões
chmod +r "$ENV_FILE"

# Saída amigável
echo ""
echo "[OK] Arquivo de variáveis criado com sucesso em $ENV_FILE"
echo "[INFO] Execute o seguinte comando para ativar as variáveis no terminal:"
echo ""
echo "source $ENV_FILE"
echo ""
