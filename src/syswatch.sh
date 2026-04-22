#!/bin/bash

CONFIG_FILE="/etc/nodeguardian/watch.conf"
LOG_FILE="/var/log/nodeguardian.log"

# Carrega config
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Erro: Config não encontrada em $CONFIG_FILE"
    exit 1
fi

# Função alerta
send_alert() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_CHAT_ID" \
        -d text="$message" \
        -d parse_mode="HTML" > /dev/null
}

# Métricas
CPU_USAGE=$(awk '/^cpu / {usage=($2+$4)*100/($2+$4+$5)} END {print usage}' /proc/stat | tr ',' '.')
MEM_USAGE=$(free | awk '/Mem:/ {print ($3/$2)*100}' | tr ',' '.')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

HOSTNAME=$(hostname)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Segurança
CPU_USAGE=${CPU_USAGE:-0}
MEM_USAGE=${MEM_USAGE:-0}
DISK_USAGE=${DISK_USAGE:-0}

# Log
echo "[$TIMESTAMP][$HOSTNAME] CPU:${CPU_USAGE}% MEM:${MEM_USAGE}% DISK:${DISK_USAGE}%" >> "$LOG_FILE"

# Alertas
if (( $(echo "$CPU_USAGE > $CPU_LIMIT" | bc -l) )); then
    send_alert "🚨 CPU alta - ${CPU_USAGE}%"
fi

if (( $(echo "$MEM_USAGE > $MEM_LIMIT" | bc -l) )); then
    send_alert "🚨 RAM alta - ${MEM_USAGE}%"
fi

if (( DISK_USAGE > DISK_LIMIT )); then
    send_alert "🚨 Disco cheio - ${DISK_USAGE}%"
fi
