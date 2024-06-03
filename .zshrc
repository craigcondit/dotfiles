# ensure GPG can find the right tty
export GPG_TTY=$(tty)

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

# plugins
zinit ice depth=1 ; zinit light romkatv/powerlevel10k
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::colored-man-pages
zinit ice as"completion"; zinit snippet https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
zinit snippet OMZP::command-not-found

# homebrew completions
if [ -d /usr/local/Homebrew/completions/zsh ]; then zinit fpath -f /usr/local/Homebrew/completions/zsh; fi
if [ -d /opt/homebrew/completions/zsh ]; then zinit fpath -f /opt/homebrew/completions/zsh; fi

# homebrew shell environment
if [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# append /usr/local/bin
if [[ ! $PATH =~ /usr/local/bin ]]; then
	PATH="${PATH}:/usr/local/bin"
fi

# prepend personal bin dir
if [ ! -d "${HOME}/bin" ]; then mkdir -p "${HOME}/bin" ; fi
export PATH="${HOME}/bin:${PATH}"

# load completions
autoload -Uz compinit && compinit

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
if [ -x "$(command -v fzf)" ]; then
  zstyle ':completion:*' menu no
  if [ -z "$(command -v lsd)" ]; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color $realpath'
    zstyle ':fzf-tab:complete:z:*' fzf-preview 'lsd --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color $realpath'
  else
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
  fi
fi

# aliases
if [ -x "$(command -v lsd)" ]; then
  alias ls='lsd --color=auto --git'
  alias ll='lsd -l --color=auto --git'
  alias la='lsd --color=auto --git'
  alias lla='lsd -la --color=auto --git'
  alias lart='lsd -lart --color=auto --git'
  alias lstree='lsd --tree --color=auto --git'
  alias lltree='lsd -l --tree --color=auto --git'
else
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
  alias la='ls --color=auto'
  alias lla='ls -la --color=auto'
  alias lart='ls -lart --color=auto'
fi

if [ -x "$(command -v batcat)" ] && [ ! -x "$(command -v bat)" ]; then
  alias bat='batcat'
fi

if [ -x "$(command -v kubectl)" ]; then alias k=kubectl; fi
if [ -x "$(command -v fastfetch)" ]; then alias ff=fastfetch; fi
if [ -x "$(command -v fdfind)" ]; then
  alias f=fdfind
elif [ -x "$(command -v fd)" ]; then
  alias f=fd
fi

alias v="${EDITOR}"

# pager
if [ -x "$(command -v most)" ]; then
  export PAGER=most
elif [ -x "$(command -v less)" ]; then
  export PAGER=less
else
  export PAGER=more
fi
export MANPAGER="${PAGER}"
alias pager="${PAGER}"
alias p="${PAGER}"

# shell integrations
if [ -x "$(command -v fzf)" ]; then eval "$(fzf --zsh)"; fi
if [ -x "$(command -v zoxide)" ]; then eval "$(zoxide init zsh)"; alias cd=z; fi
if [ -x "$(command -v kubectl)" ]; then source <(kubectl completion zsh); fi

# sdkman
if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# this comes last, to ensure all completions have registered
zinit light Aloxaf/fzf-tab
