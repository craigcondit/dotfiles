# execute below code only on Debian (trixie)
if [[ "$(uname)" == "Linux" ]]; then
	if [ -x "$(command -v lsb_release)" ]; then
		if [[ "$(lsb_release -cs 2>/dev/null)" == "trixie" ]]; then
			# check for locally installed nvim
			if [ -d "/opt/nvim/bin" ]; then
				export PATH=/opt/nvim/bin:$PATH
				rehash
			fi
			if [ -x "$(command -v nvim)" ]; then
				export EDITOR=nvim
				export VISUAL=nvim
			fi
		fi
	fi
fi
