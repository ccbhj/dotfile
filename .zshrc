# If you come from bash you might have to change your $PATH.

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#d8ddc7"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# vi-mode
set -o vi 
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias pf="fzf --preview='(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias viz="for file in \`pf\`; do cmd=\"vim -o \$file\" && print -rs -- \$cmd && eval \$cmd; done"
# alias niz="for file in \`fzf\`; do nvim -o \$file; done"
alias "cdo"="cd $OLDPWD"
alias "dlv"="dlv --check-go-version=false"
alias "jira"="~/jira.sh"
alias "tz"="trans -t zh-CN " 
alias "vimdiff"="nvim -d" 
alias "gs"="git status"
alias "gc"="git checkout"
alias "gr"="git restore"
alias "grs"="git restore --staged"
alias "ls"="exa"

alias "smt"="smc -e test services enter "
alias "smu"="smc -e uat services enter "
alias "sms"="smc -e staging services enter "
alias "sml"="smc -e live services enter "

alias "gmv"="go mod vendor"

#
#bindkey ',' autosuggest-accept
#
#
# pure theme
fpath+=$HOME/.oh-my-zsh/themes/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

# go env
export GO111MODULE="on"
export GOROOT=/usr/local/go
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
export GONOPROXY="git.garena.com"
export GONOSUMDB="git.garena.com"
export GOPRIVATE="git.garena.com"
export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB="sum.golang.org"
export GOTMPDIR=""
export GOSRC=$GOPATH/src

export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin

export TMOUT=10000

export PATH="/usr/local/Cellar/vim/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/mysql/bin:/usr/local/opt/rabbitmq/sbin"
export JAVA_HOME=/usr/local/Cellar/openjdk@11/11.0.10

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export WLS="$GOSRC/wallet_server/"
export XDG_CONFIG_HOME=$HOME/.config
