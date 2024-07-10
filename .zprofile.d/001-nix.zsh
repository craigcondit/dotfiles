# If nix exists, set NIX_PATH
if [ -x "$(command -v nix)" ]; then
  export NIX_PATH="$HOME/.nix-defexpr"
fi
