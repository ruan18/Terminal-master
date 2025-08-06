#!/bin/bash
source "$(dirname "$0")/../.env/vars.sh"

check_health() {
  uptime=$(uptime -p)
  ram=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
  disk=$(df -h / | awk 'NR==2 {print $3 "/" $2}')
  echo "[HEALTH] $(date) | Uptime: $uptime, RAM: $ram, Disk: $disk"
}
