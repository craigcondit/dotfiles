# load .d files
if [ -d "${HOME}/.zprofile.d" ]; then
  for rc in "${HOME}"/.zprofile.d/*.zsh(N) ; do
    source "${rc}"
  done
fi
