# execute remaining code only on MacOS (Darwin)
if [[ "$(uname)" == "Darwin" ]]; then

	# add homebrew to path if it exists
	if [ -x /usr/local/bin/brew ]; then
		eval "$(/usr/local/bin/brew shellenv)"
	elif [ -x /opt/homebrew/bin/brew ]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	# enable FZF integration if required components exist
	if [ -x "$(command -v fzf)" ] && [ -x "$(command -v zoxide)" ]; then
		export ZSH_USE_FZF=1
	fi

	if [ -x "$(command -v nvim)" ]; then
		export EDITOR=nvim
		export VISUAL=nvim
	fi
fi
