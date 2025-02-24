# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

#--[plugins]--
#
    zinit light Aloxaf/fzf-tab
    zinit light MichaelAquilina/zsh-auto-notify
    zinit light zdharma-continuum/fast-syntax-highlighting
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-history-substring-search
    
    zinit snippet OMZ::plugins/git/git.plugin.zsh
    zinit load zsh-users/zsh-history-substring-search

    eval "$(fzf --zsh)"
    zinit snippet OMZP::sudo

# zinit snippet OMZP::git
alias clipcopy="wl-copy"

#snipets
zinit snippet OMZP::command-not-found

zinit ice wait atload _history_substring_search_config
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# :)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases
alias ls='ls --color'
alias nv='nvim'
alias c='clear'
alias sudo='doas'
alias m='make'
alias j='just'
alias ccc='~/bin/c3/c3c --stdlib ~/lib/c3/std/'
alias c3c='~/bin/c3/c3c --stdlib ~/lib/c3/std/'

alias gyt='git'
alias gin='git init'
alias gcam='git commit -am'
alias gra='git remote add'
alias gps='git push'
alias gpl='git pull'

#fix xorg just in case
# export DISPLAY=:0

#better cd
eval "$(zoxide init --cmd cd zsh)"
#starship prompt
eval "$(starship init zsh)"

if [[ $XDG_SESSION_DESKTOP == "river-custom" ]]; then
    export XDG_CURRENT_SESSION=wlr
    export XDG_CURRENT_DESKTOP=sway
    export QT_QPA_PLATFORM="wayland;xcb"
fi;

if [[ $XDG_SESSION_DESKTOP == "river" ]]; then
    export XDG_CURRENT_SESSION=wlr
    export XDG_CURRENT_DESKTOP=sway
    export QT_QPA_PLATFORM="wayland;xcb"
fi;

export PATH="$HOME/.cargo/bin/:$PATH"
