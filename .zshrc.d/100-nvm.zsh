export NVM_DIR="${HOME}/.nvm"
(
  nvm_url=https://github.com/nvm-sh/nvm.git
  nvm_tag=v0.39.7
	# clone nvm if not present
	if [ ! -d "${HOME}/.nvm" ]; then
		cd "${HOME}"
		git clone --quiet "${nvm_url}" "${NVM_DIR}"
	fi

  # switch to proper tag
  cd "${NVM_DIR}" && (
		if [ "$(git describe --exact-match --tags 2>/dev/null)x" != "${nvm_tag}x" ]; then
			git fetch --all --tags --quiet
			git checkout --quiet "${nvm_tag}"
		fi
	)
)

# source nvm
. "${NVM_DIR}"/nvm.sh
