 [[ -r ~/.zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh/znap
source ~/.zsh/znap/znap.zsh  # Start Znap

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#d8ddc7"
# znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap prompt sindresorhus/pure
znap source marlonrichert/zsh-autocomplete


#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤ 
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
# autoload -Uz compinit
# 
# for dump in ~/.config/zsh/zcompdump(N.mh+24); do
#   compinit -d ~/.config/zsh/zcompdump
# done
# 
# compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
# autoload -Uz vcs_info
# precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
# zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

zstyle ':autocomplete:*' delay 0.2  # seconds (float)
zstyle ':autocomplete:*' ignored-input '..##'
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''
zstyle ':autocomplete:*' add-space \
  executables aliases functions builtins reserved-words commands

source ~/.zsh/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
# zle -N expand-or-complete-with-dots
# bindkey "^I" expand-or-complete-with-dots
