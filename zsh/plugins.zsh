 [[ -r ~/.zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh/znap
source ~/.zsh/znap/znap.zsh  # Start Znap

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#d8ddc7"
znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap prompt sindresorhus/pure
source ~/.local/share/zinit/plugins/catppuccin---zsh-syntax-highlighting/themes/catppuccin_frappe-zsh-syntax-highlighting.zsh

