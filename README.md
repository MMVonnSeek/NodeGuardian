# NodeGuardian

<div align="center">
  
### Monitoramento Inteligente de Infraestrutura com Alertas em Tempo Real via Telegram
  
<img src="https://img.shields.io/badge/Autor-Max Muller-darkblue?style=for-the-badge" />
<img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash" />
<img src="https://img.shields.io/badge/Linux-Compatible-orange?style=for-the-badge&logo=linux" />
<img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />

<p align="center">
<a href="#-visão-geral">Visão Geral</a> •
<a href="#-arquitetura">Arquitetura</a> •
<a href="#-funcionalidades">Funcionalidades</a> •
<a href="#-instalação">Instalação</a> •
<a href="#-configuração">Configuração</a> •
<a href="#-execução">Execução</a> •
<a href="#-logs">Logs</a>
</p>

</div>

---

## Visão Geral

**NodeGuardian** é uma ferramenta de monitoramento de infraestrutura leve, portátil e orientada a produção, desenvolvida em **Bash**, com foco em **observabilidade contínua** e **alertas automatizados via Telegram**.

Projetado para ambientes Linux, o NodeGuardian simula o comportamento de ferramentas reais utilizadas em operações de DevOps e SRE, mantendo simplicidade operacional e rápida implantação.

---

## Diferenciais

- Monitoramento contínuo de **CPU, memória e disco**
- Alertas em tempo real via **Telegram**
- Instalação automatizada em segundos
- Estrutura compatível com ambientes de produção
- Zero dependência de frameworks pesados
- Totalmente open source

---

## Arquitetura

O projeto segue padrões reais de organização de ferramentas de sistema:
/etc/nodeguardian/watch.conf → Configuração  
/usr/local/bin/nodeguardian → Executável global  
/var/log/nodeguardian.log → Logs persistentes


---

## Funcionalidades

### Monitoramento de Recursos

| Recurso | Descrição |
|--------|----------|
| CPU | Uso percentual em tempo real |
| Memória | Consumo relativo (%) |
| Disco | Uso da partição raiz |

---

### Sistema de Alertas

- Integração direta com API do Telegram
- Mensagens formatadas com:
  - Host
  - Timestamp
  - Métrica excedida
- Comunicação via `curl`

---

### Logging Estruturado

Formato padrão:

[2026-04-22 10:18:30][server01] CPU:85% MEM:70% DISK:60%


---

## Instalação

### Pré-requisitos

- Linux (Ubuntu/Debian recomendado)
- Permissão sudo
- Internet ativa

---

### Instalação Rápida

```bash
git clone https://github.com/SEU_USUARIO/nodeguardian.git
cd nodeguardian
chmod +x install.sh
./install.sh
```

## Configuração

Arquivo de configuração:
```
/etc/nodeguardian/watch.conf
```

### Exemplo:
```
CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=85

TELEGRAM_BOT_TOKEN="SEU_TOKEN_AQUI"
TELEGRAM_CHAT_ID="SEU_CHAT_ID_AQUI"
```
## Execução

### Manual
```
nodeguardian
```

Automática (cron)
```
crontab -e
```

Adicione:
```
*/1 * * * * /usr/local/bin/nodeguardian
```

## Logs

Localização:
```
/var/log/nodeguardian.log
```

Visualizar em tempo real:
```
tail -f /var/log/nodeguardian.log
```

## Segurança

-   Tokens não são versionados
-   Configuração isolada em `/etc`
-   Permissões controladas
-   Execução independente do diretório do projeto

----------

## Roadmap

-   Controle de cooldown de alertas
-   Execução como daemon (systemd)
-   Monitoramento distribuído
-   Integração com Slack / Discord
-   Dashboard web

----------

## Tecnologias

| Tecnologia | Uso | 
| ---------- | -----| 
| Bash | Script principal |
| curl | Requisições HTTP |
| bc | Cálculos |
| Linux | Ambiente |

# Contribuição

```
git checkout -b feature/nova-feature
git commit -m "feat: nova feature"
git push origin feature/nova-feature
```

## Licença
MIT License

---

##  Apoie este projeto

Se este projeto te ajudou, considere apoiar ❤️

Você pode contribuir com um apoio único ou mensal e ajudar a manter este projeto ativo.

 https://github.com/sponsors/MMVonnSeek

Seu apoio ajuda diretamente no desenvolvimento de novas ferramentas e conteúdos 🙌

---

## Contato
**Max Muller**
- Linkedin: https://linkedin.com/in/max-muller-685705248/


## Posicionamento

NodeGuardian não é apenas um script.

É uma simulação prática de ferramentas reais de monitoramento utilizadas em ambientes profissionais de infraestrutura e DevOps.

----------

<div align="center"> <strong>Construído para cenários reais de produção</strong> </div> 
<div align="center"> <sub> Feito por <strong>Prof. Max Muller - MMVonnSeek</strong> para a comunidade de segurança </sub>

  
  

[![Stars](https://img.shields.io/github/stars/MMVonnSeek/NodeGuardian?style=social)](https://github.com/MMVonnSeek/passcheck-pro/stargazers)
[![Forks](https://img.shields.io/github/forks/MMVonnSeek/NodeGuardian?style=social)](https://github.com/MMVonnSeek/passcheck-pro/network/members)
[![Follow](https://img.shields.io/github/followers/MMVonnSeek?style=social)](https://github.com/MMVonnSeek)

<a href="https://wa.me/5561986194426?text=Olá%20tudo%20bem%20Max%3F%20Eu%20vim%20pelo%20seu%20repositorio%20do%20github.%20Podemos%20conversar%20sobre%3F" target="_blank">
  <img src="https://img.shields.io/badge/WhatsApp-Fale%20Comigo-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" />
</a>

<br>

  [Voltar ao topo](#-NodeGuardian)

</div>