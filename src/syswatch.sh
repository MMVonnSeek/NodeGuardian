#!/bin/bash

# ================================
# InfraWatch - System Monitor
# ================================

# Caminhos padrão (produção)
CONFIG_FILE="/etc/infrawatch/watch.conf"
LOG_FILE="/var/log/infrawatch.log"

# ================================
# Validação de configuração
# ================================
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Erro: Arquivo de configuração não encontrado em $CONFIG_FILE"
    exit 1
fi

# ================================
# Função de alerta (Telegram)
# ================================
send_alert() {
    local message="$1"

    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_CHAT_ID" \
        -d text="$message" \
        -d parse_mode="HTML" > /dev/null
}

# ================================
# Coleta de métricas
# ================================
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_USAGE=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

HOSTNAME=$(hostname)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ================================
# Log estruturado
# ================================
echo "[$TIMESTAMP][$HOSTNAME] CPU:${CPU_USAGE}% MEM:${MEM_USAGE}% DISK:${DISK_USAGE}%" >> "$LOG_FILE"

# ================================
# Lógica de alerta
# ================================

# CPU
if (( $(echo "$CPU_USAGE > $CPU_LIMIT" | bc -l) )); then
    send_alert "<b>Alerta de CPU</b>%0AHost: $HOSTNAME%0AUso: ${CPU_USAGE}% (Limite: ${CPU_LIMIT}%)%0A $TIMESTAMP"
fi

# RAM
if (( $(echo "$MEM_USAGE > $MEM_LIMIT" | bc -l) )); then
    send_alert "<b>Alerta de RAM</b>%0AHost: $HOSTNAME%0AUso: ${MEM_USAGE}% (Limite: ${MEM_LIMIT}%)%0A $TIMESTAMP"
fi

# Disco
if (( DISK_USAGE > DISK_LIMIT )); then
    send_alert "<b>Alerta de Disco</b>%0AHost: $HOSTNAME%0AUso: ${DISK_USAGE}% (Limite: ${DISK_LIMIT}%)%0A $TIMESTAMP"
fi