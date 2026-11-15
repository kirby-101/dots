#!/usr/bin/env zsh

mirrorlist=(
	"/boot/loader.conf"
	"~/.zshrc"
	"~/.gitconfig"
	"~/.config/dunst"
	"~/.config/foot"
	"~/.config/hypr"
	"~/.config/waybar"
	"~/.config/wofi"
	"~/.local/bin/tor-browser"
	"~/.local/bin/ssh-host-menu.zsh"
	"~/.local/bin/kleopatra"
	"~/.local/bin/factorio"
	"~/.local/bin/discord"
	"~/.local/bin/anytype-wine"
	"~/.local/bin/anytype-lnxlab"
)

for file in $mirrorlist; do
	src=${~file}
	dest=./${src#$HOME/}
	mkdir -p ${dest:h}
	cp -rvf $src $dest
done


# package list
pkg query -e '%a = 0' %o > pkgls.txt

# git push
git add -A
git commit -m "$(date +%Y-%m-%d_%H-%M)"
git status
git push
