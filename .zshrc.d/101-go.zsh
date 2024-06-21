export GOPATH="${HOME}/go"
export GOROOT="${HOME}/.go"
mkdir -p "${HOME}/go/bin" "${HOME}/.go"
if [ ! -x "${HOME}/go/bin/g" ]; then
	(
		g_version=0.10.0
		g_url=https://github.com/stefanmaric/g/raw/${g_version}/bin/g
		curl -L --silent "${g_url}" > "${HOME}/go/bin/g" && chmod +x "${HOME}/go/bin/g"
	)
fi
export PATH="${GOROOT}/bin:${PATH}:${GOPATH}/bin"
rehash
