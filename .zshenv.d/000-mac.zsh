# execute below code only on MacOS (Darwin)
if [[ "$(uname)" == "Darwin" ]]; then
	if [ -x "$(command -v nvim)" ]; then
		export EDITOR=nvim
		export VISUAL=nvim
	fi
fi
