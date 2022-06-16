xmodmap $HOME/.Xmodmap
killall -q picom
picom --experimental-backends &
fcixt &
ln -f -t ~/.config/polybar ~/.config/polybar/polybar-themes/san/*
~/.config/polybar/launch.sh
