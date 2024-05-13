eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

. /usr/local/opt/asdf/libexec/asdf.sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
# . /opt/asdf-vm/asdf.sh
eval "$(atuin init zsh --disable-up-arrow)"

# ${HOME}/dotfile/zsh/colorscript -r
