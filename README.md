Terminal Master

🎯 Suíte de Automação Terminal Profissional

Projeto modular e poderoso para automações em terminal Linux com logs criptografados, alertas e integração entre scripts.

🔧 Instalação

# Clone o repositório
git clone https://github.com/seu-usuario/terminal-master.git
cd terminal-master

# Torne o instalador executável e execute
chmod +x install.sh
bash install.sh

✅ Após a instalação, ative as variáveis:




source ~/.env/vars.sh


---

🚀 Funcionalidades Implementadas

✅ Logger (com criptografia)

Gera logs com níveis: INFO, ERROR, DEBUG

Organiza por pasta/data

Criptografa e descriptografa automaticamente com OpenSSL


# Exemplo:
bash logger.sh --info "Sistema iniciado com sucesso"
bash logger.sh --error "Erro de autenticação"
bash logger.sh --encrypt
bash logger.sh --decrypt


---

✅ Monitoramento do Sistema

Mostra uso de CPU, RAM e disco

Salva tudo em log criptografado automaticamente


# Executar via script principal
bash terminal-master.sh --monitor

# Ou diretamente
bash modules/monitor/monitor.sh


---

📦 Estrutura de Pastas

terminal-master/
├── terminal-master.sh          # Script principal
├── install.sh                  # Instalador automático
├── save.sh                     # Script para salvar via Git
├── .env/vars.sh                # Variáveis do projeto (criptografia, logs)
├── logs/                       # Logs organizados por módulo/data
│   └── monitor/
│       └── monitor.log.enc
├── modules/                    # Módulos separados
│   ├── logger/                 # Logger principal
│   └── monitor/                # Monitor do sistema
└── README.md                   # Este arquivo


---

🔐 Segurança

Logs protegidos com OpenSSL AES-256-CBC

Chave criptográfica configurável em .env/vars.sh



---

📤 Salvamento com Git

Para salvar seu progresso e subir ao GitHub:

bash save.sh


---

✨ Em breve

Módulo de Backup automático com log e alerta Telegram

Watchdog de serviços

Atualizador inteligente de pacotes

Documentação técnica com Makefile



---

🤖 Modo Hacker

Comandos úteis:

source ~/.env/vars.sh      # Carrega variáveis do projeto
bash terminal-master.sh    # Executa o sistema


---

🧠 Autor

Feito por @ruan100pressa com o 🔥 nas veias e o terminal na cabeça.

Se curtiu, ⭐ dá uma estrela no repositório!
