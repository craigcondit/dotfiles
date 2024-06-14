.phony: install
install: ${HOME}/.config ${HOME}/.config/alacritty ${HOME}/.config/nvim ${HOME}/.config/tmux ${HOME}/.tmux/plugins/tpm
	@stow .

${HOME}/.config:
	mkdir -p "${HOME}/.config"

${HOME}/.config/alacritty:
	mkdir -p "${HOME}/.config/alacritty"

${HOME}/.config/nvim:
	mkdir -p "${HOME}/.config/nvim"

${HOME}/.config/tmux:
	mkdir -p "${HOME}/.config/tmux"

${HOME}/.tmux/plugins/tpm:
	@echo "Cloning tmux-plugins/tpm..."
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

