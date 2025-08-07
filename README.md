cat > ~/terminal-master/README.md << 'EOF'
# 🧠 terminal-master

Suíte profissional de automação Linux via terminal com módulos integrados, logs criptografados, backup seguro, monitoramento do sistema e estrutura modular extensível.  
Feito para sysadmins, devs, pentesters e entusiastas que querem poder absoluto sobre o sistema.

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
# Ver ajuda
bash terminal-master.sh --help

# Executar monitoramento do sistema
bash terminal-master.sh --monitor

# Executar backup criptografado
bash terminal-master.sh --backup
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
│   └── monitor/
├── backups/
├── modules/
│   ├── logger/
│   │   └── logger.sh
│   ├── monitor/
│   │   └── monitor.sh
│   └── backup/
│       └── backup.sh
\`\`\`

---

## 🔐 Módulo Logger (com Criptografia)

Registra eventos em diferentes níveis com criptografia AES-256 nos logs.

\`\`\`bash
# Logar manualmente (caso deseje)
bash modules/logger/logger.sh --info "Sistema iniciado"
bash modules/logger/logger.sh --error "Erro crítico"
bash modules/logger/logger.sh --debug "Modo debug ativado"

# Criptografar logs antigos
bash modules/logger/logger.sh --encrypt

# Descriptografar para leitura
bash modules/logger/logger.sh --decrypt
\`\`\`

📁 Logs criptografados são salvos automaticamente em \`logs/YYYY-MM-DD/terminal.log.enc\`

---

## 📊 Módulo Monitor

Coleta dados básicos do sistema (RAM, CPU, espaço em disco, temperatura, uptime etc.)

\`\`\`bash
bash terminal-master.sh --monitor
\`\`\`

📁 Gera log criptografado em \`logs/monitor/monitor.log.enc\`

---

## 💾 Módulo Backup

Cria backup compactado e criptografado do diretório desejado.

\`\`\`bash
bash terminal-master.sh --backup
\`\`\`

📦 Gera:
- \`backup_TIMESTAMP.tar.gz\`
- \`backup_TIMESTAMP.tar.gz.enc\`

📁 Salvos em: \`~/terminal-master/backups\`

---

## ⚙️ Variáveis de Ambiente

Essas variáveis ficam em \`.env/vars.sh\` e são carregadas automaticamente. Exemplo:

\`\`\`bash
export LOG_ENCRYPTION_KEY="sua-chave-forte-aqui"
export PROJECT_ROOT="\$HOME/terminal-master"
export LOGGER_MODULE="\$PROJECT_ROOT/modules/logger/logger.sh"
export BACKUP_SOURCE="\$HOME/Documentos"
export BACKUP_DIR="\$PROJECT_ROOT/backups"
\`\`\`

Carregar:

\`\`\`bash
source ~/.env/vars.sh
\`\`\`

---

## 🧪 Módulos Prontos

| Flag             | Descrição                         | Status |
|------------------|-----------------------------------|--------|
| \`--monitor\`       | Coleta dados do sistema + log     | ✅ OK  |
| \`--backup\`        | Backup com compressão + criptografia | ✅ OK  |
| \`--logger\`        | Logger modular com AES-256        | ✅ OK  |

---

## 🔮 Próximos Módulos (em construção)

| Flag             | Descrição                              |
|------------------|------------------------------------------|
| \`--health\`       | Verificação de integridade do sistema    |
| \`--watchdog\`     | Detecção ativa de falhas                |
| \`--cron\`         | Execução programada automática (cron)   |
| \`--telegram\`     | Envio de alertas via bot Telegram       |
| \`--update\`       | Atualizações automáticas do projeto     |
| \`--logrotate\`    | Limpeza e rotação dos logs antigos      |

---

## 🤝 Contribuindo

1. Faça um fork  
2. Crie um branch com sua feature: \`git checkout -b minha-feature\`  
3. Faça commit: \`git commit -m 'feat: minha nova feature'\`  
4. Push: \`git push origin minha-feature\`  
5. Crie um Pull Request

---

## 🔒 Segurança

- Criptografia AES-256 via OpenSSL  
- Sem coleta de dados  
- Backup e logs locais, protegidos por chave definida pelo usuário  
- Ideal para automações pessoais ou profissionais

---

## 🧑‍💻 Autor

Feito com ⚡ foco técnico e ☕ café por [ruan18](https://github.com/ruan18)

---

## 🌐 Licença

[MIT](https://choosealicense.com/licenses/mit/) — use com responsabilidade, aprimore com liberdade.
EOF

echo "[OK] README.md atualizado em ~/terminal-master/README.md"
