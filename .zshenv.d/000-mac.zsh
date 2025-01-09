# execute below code only on MacOS (Darwin)
if [[ "$(uname)" == "Darwin" ]]; then
	# reset path for login shells
	if [[ -o login ]]; then
		eval `PATH="" MANPATH="" /usr/libexec/path_helper -s`
	  rehash
	fi
	export TFENV_ARCH=amd64
fi
