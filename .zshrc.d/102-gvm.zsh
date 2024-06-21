(
	gvm_version=v0.2.1
	gvm_url=https://github.com/devnw/gvm/releases/download/${gvm_version}/gvm

	if [ ! -x "${HOME}/bin/gvm" ]; then
		curl --silent -L "${gvm_url}" > "${HOME}/bin/gvm" && chmod +x "${HOME}/bin/gvm"
	fi
)
export PATH="${HOME}/.gvm/go/bin:${PATH}"
rehash
