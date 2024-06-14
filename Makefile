.phony: install
install:
	mkdir -p "${HOME}/.config"
	mkdir -p "${HOME}/.alacritty"
	mkdir -p "${HOME}/nvim"
	mkdir -p "${HOME}/tmux"
	if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm ; \
	fi
	stow .
