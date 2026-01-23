# execute below code only on Debian (forky)
if [[ "$(uname)" == "Linux" ]]; then
	if [ -x "$(command -v lsb_release)" ]; then
		if [[ "$(lsb_release -cs 2>/dev/null)" == "forky" ]]; then
			if [ -x "$(command -v nvim)" ]; then
				export EDITOR=nvim
				export VISUAL=nvim
			fi
		fi
	fi
fi
