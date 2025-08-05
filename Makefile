# Makefile da suíte terminal-master

# Caminhos
INSTALL_SCRIPT := ./install.sh
MAIN_SCRIPT := ./scripts/bash/main.sh
LOG_DIR := ./logs
BACKUP_DIR := ./backup
BACKUP_FILE := $(BACKUP_DIR)/backup_$(shell date +%Y-%m-%d_%H-%M-%S).tar.gz
ENCRYPT_SCRIPT := ./scripts/bash/encrypt_logs.sh

.PHONY: install run logs clean backup encrypt

install:
	@echo "[+] Instalando suíte terminal-master..."
	@bash $(INSTALL_SCRIPT)

run:
	@echo "[+] Executando suíte terminal-master..."
	@bash $(MAIN_SCRIPT)

logs:
	@echo "[+] Logs disponíveis em 'logs/'"
	@ls -lh $(LOG_DIR)

clean:
	@echo "[+] Limpando logs e temporários..."
	@rm -rf $(LOG_DIR)/*
	@echo "[+] Logs limpos com sucesso."

backup:
	@echo "[+] Criando backup..."
	@mkdir -p $(BACKUP_DIR)
	@tar --exclude=$(BACKUP_DIR) -czf $(BACKUP_FILE) .

	@echo "[+] Backup criado em $(BACKUP_FILE)"

encrypt:
	@echo "[+] Criptografando logs com AES256..."
	@bash $(ENCRYPT_SCRIPT)
encrypt:
	bash scripts/bash/encrypt.sh


