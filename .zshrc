# ~/.zshrc kirby@bsdlab

# ZSH Options
setopt autocd extendedglob nomatch notify
unsetopt beep # hurensohn gepiepe
bindkey -e

# ZSH History
HISTFILE=~/.cache/zsh-history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# disable less history
export LESSHISTSIZE=0

# my fucking keys
bindkey '\e[H'   beginning-of-line  # POS1
bindkey '\e[4~'  end-of-line        # ENDE
bindkey '\e[F'   end-of-line        # ENDE
bindkey '\e[3~'  delete-char        # ENTF

# completion
zstyle :compinstall filename '/home/kirby/.zshrc'
autoload -Uz compinit && compinit

# doas completion
compdef doas=sudo

# Wayland
export KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XDG_RUNTIME_DIR="/var/run/user/$(id -u)"
export SDL_VIDEODRIVER=wayland
export GDK_BACKEND=wayland

[ -d "$XDG_RUNTIME_DIR" ] || mkdir -m 700 -p "$XDG_RUNTIME_DIR"

# cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# $PS1
PROMPT='┌─[%n@%m]-[%~]
└──╼[$]> '

# $PATH
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  $path
)
export PATH

# Encoding
export LC_ALL=de_DE.UTF-8

# term
export TERM="xterm-256color"

#
# Default Applications
#

# MOZ_DISABLE_IMAGE_OPTIMIZE=1

IFCONFIG_FORMAT=inet:cidr

export EDITOR="nano"
export VISUAL="emacs"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# lunix sudo
alias sudo="doas"

# SSH
#alias ssh="TERM=tmux-256color ssh"
# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock" # ssh-agent

# push key to remote SSHD
alias ssh-push-id="ssh-copy-id -i ~/.ssh/id_ed25519"

# cd: zoxide
eval "$(zoxide init zsh)"

# ls: eza
alias ls='eza -rhl'
alias la='eza -rhla'

# rsync
alias rsync="rsync -v --stats --progress"

# confirm overwrite
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# find: fd
alias find='fd'

# grep
alias grep='rga --smart-case'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# disk space
alias du='du -hc'
alias df='df -h'

# list ports
if [ "$(uname)" = "FreeBSD" ]; then
    alias lsports4="doas sockstat -4"
    alias lsports6="doas sockstat -6"

elif [ "$(uname)" = "Linux" ]; then
    alias lsports="doas ss -lntu"
fi
    
# process status
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

#
# Package Management
#
if [ "$(uname)" = "FreeBSD" ]; then
    alias pkgs="pkg search -o -Q repository"
    alias pkgin="doas pkg install"
    alias pkgrm="doas pkg autoremove && doas pkg remove"
    alias pkgup="doas pkg update && doas pkg upgrade"

elif [ "$(uname)" = "Linux" ]; then
    alias pkgs="doas apt search"
    alias pkgin="doas apt install"
    alias pkgrm="doas apt remove"
fi

#
# Archive Extraction
#
extract () {
    if [ -f "$1" ] ; then
    case $1 in
        *.rar)       unrar x "$1"   ;;
        *.tar.bz2)   tar xjf "$1"   ;;
        *.tar.gz)    tar xzf "$1"   ;;
        *.bz2)       bunzip2 "$1"   ;;
        *.rar)       unrar x "$1"   ;;
        *.gz)        gunzip "$1"    ;;
        *.tar)       tar xf "$1"    ;;
        *.tbz2)      tar xjf "$1"   ;;
        *.tgz)       tar xzf "$1"   ;;
        *.zip)       unzip "$1"     ;;
        *.Z)         uncompress "$1";;
        *.7z)        7z x "$1"      ;;
        *.deb)       ar x "$1"      ;;
        *.tar.xz)    tar xf "$1"    ;;
        *.tar.zst)   unzstd "$1"    ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# wget
alias wget="wget --continue --tries=0"

#
# Global Aliases
#
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g C='|wc -l'
alias -g G='|grep --color=auto'
alias -g H='|head'
alias -g L='|less'
alias -g N='&>/dev/null'
alias -g SL='| sort | less'
alias -g S='| sort'
alias -g T='|tail'

# calculator
alias calc="python3 -q"

# gpc
alias gcp="gcp --sparse=always"

# more completion
if [ -e /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
