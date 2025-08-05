#!/usr/bin/env bash

set -e

# Caminhos
BACKUP_DIR="./backup"
LOG_DIR="./logs"
ENCRYPTED_BACKUP_DIR="./encrypted/backup"
ENCRYPTED_LOG_DIR="./encrypted/logs"

# Verifica se GPG está instalado
if ! command -v gpg &> /dev/null; then
    echo "[ERRO] GPG não está instalado. Instale com: sudo apt install gnupg"
    exit 1
fi

# Cria pastas se não existirem
mkdir -p "$ENCRYPTED_BACKUP_DIR" "$ENCRYPTED_LOG_DIR"

# Define destinatário (usuário do GPG)
GPG_USER="terminal-master"

# Verifica se chave existe
if ! gpg --list-keys "$GPG_USER" > /dev/null 2>&1; then
    echo "[ERRO] Chave GPG '$GPG_USER' não encontrada. Crie com: gpg --full-generate-key"
    exit 1
fi

echo "[+] Criptografando backups..."
for file in "$BACKUP_DIR"/*.tar.gz; do
    [ -e "$file" ] || continue
    output="$ENCRYPTED_BACKUP_DIR/$(basename "$file").gpg"
    gpg --yes --batch --output "$output" --encrypt --recipient "$GPG_USER" "$file"
    echo "[✓] $file criptografado para $output"
done

echo "[+] Criptografando logs..."
find "$LOG_DIR" -type f -name "*.log" | while read -r file; do
    filename=$(basename "$file")
    output="$ENCRYPTED_LOG_DIR/${filename}.gpg"
    gpg --yes --batch --output "$output" --encrypt --recipient "$GPG_USER" "$file"
    echo "[✓] $file criptografado para $output"
done

echo "[✔] Criptografia finalizada com sucesso."
