#!/bin/bash

LOGGER="$HOME/terminal-master/modules/logger/logger.sh"

echo "[FIX] Corrigindo sintaxe do logger.sh"

# Refaz o logger.sh com a versão segura e testada
cat > "$LOGGER" << 'EOF'
#!/bin/bash

source ~/.env/vars.sh

log_info() {
    echo "[INFO]  $1"
}

log_error() {
    echo "[ERROR] $1"
}

log_debug() {
    echo "[DEBUG] $1"
}

encrypt_log() {
    local log_file="$1"
    local enc_file="${log_file}.enc"

    openssl enc -aes-256-cbc -pbkdf2 -salt -in "$log_file" -out "$enc_file" -k "$LOG_ENCRYPTION_KEY"
    if [ $? -eq 0 ]; then
        echo "[INFO] Log criptografado: $enc_file"
    else
        echo "[ERROR] Falha na criptografia do log"
    fi
}

decrypt_log() {
    local enc_file="$1"
    local dec_file="${enc_file%.enc}.dec"

    openssl enc -d -aes-256-cbc -pbkdf2 -in "$enc_file" -out "$dec_file" -k "$LOG_ENCRYPTION_KEY"
    if [ $? -eq 0 ]; then
        echo "[INFO] Log descriptografado: $dec_file"
    else
        echo "[ERROR] Falha na descriptografia do log"
    fi
}
EOF

chmod +x "$LOGGER"
echo "[OK] logger.sh corrigido e pronto!"
