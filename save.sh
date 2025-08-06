#!/bin/bash

# Caminho do projeto
cd ~/terminal-master || exit 1

# Inicia repositório Git se não existir
if [ ! -d ".git" ]; then
  git init
fi

# Cria .gitignore para proteger variáveis sensíveis e logs criptografados
cat > .gitignore <<EOF
.env/
logs/
*.enc
*.log
*.bak
*.tmp
EOF

# Adiciona todos os arquivos
git add .

# Commit com mensagem técnica
git commit -m "🚀 Monitor v1: logger criptografado, módulo monitor integrado com --monitor"

# Status final
git status

echo -e "\n✅ Projeto salvo localmente com Git."

# Sugestão para push remoto (opcional)
echo -e "\n💡 Dica: para subir no GitHub:"
echo 'git remote add origin git@github.com:SEU_USUARIO/terminal-master.git'
echo 'git push -u origin main'
