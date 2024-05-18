if [[ "$(uname)" == "Darwin" ]]; then
  # legacy homebrew (intel)
  [ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)" || true

  # modern homebrew (m1)
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)" || true	
fi
