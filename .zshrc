# enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit if missing
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# packages
zinit pack"binary" for fzf
if [ ! -e "$(dirname "$(command -v fzf)")/fzf-preview" ]; then
  ln -s fzf "$(dirname "$(command -v fzf)")/fzf-preview"
fi

# plugins
zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice wait"2" as"command" from"gh-r" lucid \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src="init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# other plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::colored-man-pages
zinit ice as"completion"; zinit snippet https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
zinit snippet OMZP::command-not-found

# add homebrew completions
if [ -d /usr/local/Homebrew/completions/zsh ]; then zinit fpath -f /usr/local/Homebrew/completions/zsh; fi
if [ -d /opt/homebrew/completions/zsh ]; then zinit fpath -f /opt/homebrew/completions/zsh; fi

# load completions
autoload -Uz compinit && compinit

# add kubectl completions
if [ -x "$(command -v kubectl)" ]; then source <(kubectl completion zsh); fi

# homebrew
if [ -x /usr/local/bin/brew ]; then eval "$(/usr/local/bin/brew shellenv)"; fi
if [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi

zinit cdreplay -q

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "\e[3~" delete-char

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt inc_append_history 
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# aliases
alias ls='ls --color'
alias ll='ls -la --color'
if [ -x "$(command -v kubectl)" ]; then alias k=kubectl; fi
if [ -x "$(command -v fastfetch)" ]; then alias ff=fastfetch; fi

# shell integrations
alias cd=z
eval "$(fzf --zsh)"
if [ -x "$(command -v kubectl)" ]; then source <(kubectl completion zsh); fi

# sdkman
if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

