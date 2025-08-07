⚠️ *Aviso legal:* Este projeto está protegido por licença com restrição de uso comercial.Uso comercial, distribuição ou modificação para fins comerciais só com autorização prévia.

cat > ~/terminal-master/README.md << 'EOF'
# 🧠 terminal-master

Suíte profissional de automação Linux via terminal com módulos integrados, logs criptografados, backup seguro, monitoramento do sistema, healthcheck detalhado e estrutura modular extensível.  
Feito para sysadmins, devs, pentesters e entusiastas que querem controle absoluto e segurança total no sistema.

---

## 🚀 Instalação

\`\`\`bash
# Clone o projeto
git clone https://github.com/ruan18/terminal-master.git
cd terminal-master

# Torne o instalador executável e rode
chmod +x install.sh
bash install.sh
\`\`\`

---

## 🧩 Execução via Terminal

\`\`\`bash
# Ver ajuda geral
bash terminal-master.sh --help

# Executar monitoramento do sistema
bash terminal-master.sh --monitor

# Executar backup criptografado
bash terminal-master.sh --backup

# Executar healthcheck detalhado do sistema
bash terminal-master.sh --health
\`\`\`

---

## 🧠 Estrutura de Pastas

\`\`\`bash
terminal-master/
├── install.sh
├── terminal-master.sh
├── .env/
│   └── vars.sh
├── logs/
│   ├── monitor/
│   ├── healthcheck/
│   └── logger/
├── backups/
├── modules/
│   ├── logger/
│   │   └── logger.sh
│   ├── monitor/
│   │   └── monitor.sh
│   ├── backup/
│   │   └── backup.sh
│   └── healthcheck/
│       └── healthcheck.sh
\`\`\`

---

## 🔐 Módulo Logger (com Criptografia)

Registra eventos em diferentes níveis com criptografia AES-256 via OpenSSL para máxima segurança dos logs.

\`\`\`bash
# Exemplos de uso do logger
bash modules/logger/logger.sh --info "Sistema iniciado"
bash modules/logger/logger.sh --error "Erro crítico detectado"
bash modules/logger/logger.sh --debug "Modo debug ativado"

# Criptografar logs antigos manualmente
bash modules/logger/logger.sh --encrypt

# Descriptografar logs para leitura
bash modules/logger/logger.sh --decrypt
\`\`\`

📁 Logs criptografados são salvos automaticamente em \`logs/YYYY-MM-DD/terminal.log.enc\`

---

## 📊 Módulo Monitor

Coleta dados essenciais do sistema: uso de RAM, CPU, espaço em disco, temperatura, uptime, carga da CPU.

\`\`\`bash
bash terminal-master.sh --monitor
\`\`\`

📁 Gera log criptografado em \`logs/monitor/monitor.log.enc\`

---

## 💾 Módulo Backup

Cria backup compactado e criptografado do diretório definido nas variáveis de ambiente.

\`\`\`bash
bash terminal-master.sh --backup
\`\`\`

📦 Gera:

- \`backup_TIMESTAMP.tar.gz\`
- \`backup_TIMESTAMP.tar.gz.enc\`

📁 Salvos em: \`~/terminal-master/backups\`

---

## 🩺 Módulo Healthcheck (Checkup Completo do Sistema)

Realiza checagens detalhadas de integridade, uso de recursos e saúde geral do sistema.  
Gera logs criptografados que ajudam no monitoramento e troubleshooting.

\`\`\`bash
bash terminal-master.sh --health
\`\`\`

📁 Logs em \`logs/healthcheck/healthcheck.log.enc\`

---

## ⚙️ Variáveis de Ambiente

Configurações críticas ficam em \`.env/vars.sh\`, carregadas automaticamente pelo script principal. Exemplo:

\`\`\`bash
export LOG_ENCRYPTION_KEY="sua-chave-forte-aqui"
export PROJECT_ROOT="\$HOME/terminal-master"
export LOGGER_MODULE="\$PROJECT_ROOT/modules/logger/logger.sh"
export BACKUP_SOURCE="\$HOME/Documentos"
export BACKUP_DIR="\$PROJECT_ROOT/backups"
\`\`\`

Carregue as variáveis manualmente se desejar:

\`\`\`bash
source ~/.env/vars.sh
\`\`\`

---

## 🧪 Módulos Prontos e Testados

| Flag            | Descrição                               | Status  |
|-----------------|-----------------------------------------|---------|
| \`--monitor\`      | Coleta dados do sistema + gera log      | ✅ OK   |
| \`--backup\`       | Backup com compressão + criptografia    | ✅ OK   |
| \`--logger\`       | Logger modular com criptografia AES-256 | ✅ OK   |
| \`--health\`       | Healthcheck detalhado do sistema         | ✅ OK   |

---

## 🔮 Próximos Módulos (Em desenvolvimento)

| Flag          | Descrição                                |
|---------------|------------------------------------------|
| \`--watchdog\`  | Monitoramento ativo de falhas             |
| \`--cron\`     | Execução automática via cron               |
| \`--telegram\` | Envio de alertas e notificações via Telegram |
| \`--update\`   | Atualização automática do projeto          |
| \`--logrotate\`| Rotação e limpeza automática dos logs      |

---

## 🤝 Como Contribuir

1. Faça um fork do projeto  
2. Crie um branch para sua feature: \`git checkout -b minha-feature\`  
3. Faça commit das alterações: \`git commit -m 'feat: descrição da feature'\`  
4. Envie o branch: \`git push origin minha-feature\`  
5. Abra um Pull Request

---

## 🔒 Segurança

- Criptografia AES-256 com OpenSSL para logs e backups  
- Sem coleta externa de dados  
- Arquivos locais, protegidos por chave definida pelo usuário  
- Foco em automações profissionais seguras e auditáveis

---

## 🧑‍💻 Autor

Desenvolvido com ⚡ foco técnico e ☕ café por [ruan18](https://github.com/ruan18)

---

## 🌐 Licença

[MIT](https://choosealicense.com/licenses/mit/) — use com responsabilidade e aprimore com liberdade.
EOF
