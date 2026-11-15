#!/usr/bin/env zsh
# bind = $mainMod SHIFT, RETURN, exec, ~/.local/bin/ssh-host-menu.zsh

set -euo pipefail

CONFIG="${HOME}/.ssh/config"

if [[ ! -f "$CONFIG" ]]; then
  notify-send "SSH-Menü" "Keine ~/.ssh/config gefunden"
  exit 1
fi

hosts=$(
  awk '
    BEGIN { IGNORECASE=1 }
    $1 == "Host" {
      for (i = 2; i <= NF; i++) {
        if ($i !~ /[*?]/) print $i
      }
    }
  ' "$CONFIG" | sort -u
)

if [[ -z "$hosts" ]]; then
  notify-send "SSH-Menü" "Keine Hosts in ~/.ssh/config gefunden"
  exit 1
fi

selected=$(
  print -r -- "$hosts" | wofi --dmenu --prompt "SSH Host"
)

[[ -z "$selected" ]] && exit 0

exec footclient --term=xterm-256color --title=${(q)selected} zsh -c "ssh -v ${(q)selected}"
