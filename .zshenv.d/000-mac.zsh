if [[ "$(uname)" == "Darwin" ]]; then
  # add homebrew to path if it exists
  [ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)" || true
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi
