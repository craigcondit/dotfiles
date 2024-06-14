
.phony: install
install: ${HOME}/.config ${HOME}/.config/alacritty ${HOME}/.config/nvim ${HOME}/.config/tmux ${HOME}/.tmux/plugins/tpm alacritty
	stow .

${HOME}/.config:
	mkdir -p "${HOME}/.config"

${HOME}/.config/alacritty:
	mkdir -p "${HOME}/.config/alacritty"

${HOME}/.config/nvim:
	mkdir -p "${HOME}/.config/nvim"

${HOME}/.config/tmux:
	mkdir -p "${HOME}/.config/tmux"

${HOME}/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

.phony: alacritty
alacritty: .config/alacritty/alacritty.toml .config/alacritty/alacritty.yml

.config/alacritty/alacritty.toml: Makefile bin/vars.sh $(shell find vars/alacritty -type f) templates/alacritty/alacritty.template.toml
	@echo "Generating alacritty.toml..."
	@mkdir -p .config/alacritty
	@bin/vars.sh alacritty < templates/alacritty/alacritty.template.toml > .config/alacritty/alacritty.toml.tmp
	@mv -f .config/alacritty/alacritty.toml.tmp .config/alacritty/alacritty.toml
	@chmod 644 .config/alacritty/alacritty.toml

.config/alacritty/alacritty.yml: Makefile bin/vars.sh $(shell find vars/alacritty -type f) templates/alacritty/alacritty.template.yml
	@echo "Generating alacritty.yml..."
	@mkdir -p .config/alacritty
	@bin/vars.sh alacritty < templates/alacritty/alacritty.template.yml > .config/alacritty/alacritty.yml.tmp
	@mv -f .config/alacritty/alacritty.yml.tmp .config/alacritty/alacritty.yml
	@chmod 644 .config/alacritty/alacritty.yml

.phony: pull
pull:
	git pull

.phony: all
all: pull install
