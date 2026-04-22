#!/bin/bash

echo "🔧 Instalando NodeGuardian..."

# Atualiza pacotes e instala dependências
sudo apt update
sudo apt install -y bc curl

# Cria diretórios necessários
sudo mkdir -p /etc/nodeguardian

# Copia arquivos
sudo cp config/watch.conf /etc/nodeguardian/watch.conf
sudo cp src/syswatch.sh /usr/local/bin/nodeguardian

# Permissões
sudo chmod +x /usr/local/bin/nodeguardian

# Cria arquivo de log
sudo touch /var/log/nodeguardian.log
sudo chmod 666 /var/log/nodeguardian.log

echo "✅ Instalação concluída!"
echo ""
echo "Execute manualmente:"
echo "nodeguardian"
echo ""
echo "Para execução automática (cron):"
echo "crontab -e"
echo "Adicione:"
echo "*/1 * * * * /usr/local/bin/nodeguardian"
