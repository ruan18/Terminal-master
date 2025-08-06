#!/bin/bash
source "$(dirname "$0")/../.env/vars.sh"

log_file="$LOG_DIR/teste.log"

log_info() {
  echo "[INFO] $1" | tee -a "$log_file"
}

log_error() {
  echo "[ERROR] $1" | tee -a "$log_file"
}

encrypt_log() {
  openssl enc -aes-256-cbc -salt -in "$log_file" -out "${log_file}.enc" -pass pass:"$ENCRYPT_KEY"
  echo "[OK] Log criptografado: ${log_file}.enc"
}

decrypt_log() {
  openssl enc -d -aes-256-cbc -in "${log_file}.enc" -out "${log_file}" -pass pass:"$ENCRYPT_KEY"
  echo "[OK] Log descriptografado: ${log_file}"
}
