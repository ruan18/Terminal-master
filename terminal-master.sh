#!/bin/bash

# health.sh - Verifica integridade do sistema (CPU, RAM, Disco, Serviços)
# Autor: Seu nome
# Versão: 1.0

project_dir="$(dirname "$(dirname "$(realpath "$0")")")"
log_dir="$project_dir/logs/health"
mkdir -p "$log_dir"

log_file="$log_dir/health.log"
enc_log_file="$log_file.enc"
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d'.' -f1)
ram_usage=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
disk_usage=$(df / | awk 'END {print $5}' | tr -d '%')

check_service() {
  systemctl is-active --quiet "$1" && echo "[OK] Serviço $1 está ativo" || echo "[CRITICAL] Serviço $1 está INATIVO"
}

echo "[$timestamp] Health Check Report:" > "$log_file"
echo "[OK] CPU: $cpu_usage%" >> "$log_file"
echo "[OK] RAM: $ram_usage%" >> "$log_file"
echo "[OK] Disco /: $disk_usage%" >> "$log_file"

check_service "ssh" >> "$log_file"
check_service "NetworkManager" >> "$log_file"

openssl enc -aes-256-cbc -pbkdf2 -salt -in "$log_file" -out "$enc_log_file" -k "terminalmasterkey" 2>/dev/null

rm -f "$log_file"

echo "[INFO] Log criptografado salvo em $enc_log_file"
