.phony: install
install:
	mkdir -p "${HOME}/.config"
	mkdir -p "${HOME}/.config/.alacritty"
	mkdir -p "${HOME}/.config/nvim"
	mkdir -p "${HOME}/.config/tmux"
	if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm ; \
	fi
	stow .
