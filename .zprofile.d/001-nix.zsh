# If nix exists, set NIX_PATH
if [ ! -z "$(command -v nix)" ]; then
  export NIX_PATH="$HOME/.nix-defexpr"
fi
