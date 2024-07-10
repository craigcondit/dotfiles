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

if [[ ":$PATH:" != *":${GOROOT}/bin:"* ]]; then
	export PATH="${GOROOT}/bin:${PATH}"
fi
if [[ ":$PATH:" != *":${GOPATH}/bin:"* ]]; then
  export PATH="${PATH}:${GOPATH}/bin"
fi
rehash
