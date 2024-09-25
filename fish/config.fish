function setup_plugins
  zoxide init fish --cmd cd | source

  fzf --fish | source

  . ~/.local/share/fish/vendor_conf.d/asdf_direnv.fish
  atuin init fish --disable-up-arrow | source
end

function setup_envs
  . /usr/local/opt/asdf/libexec/asdf.fish

  set -Ux EDITOR 'vim'
  set -Ux GO111MODULE "on"
  set -Ux GOBIN $HOME/go/bin
  set -Ux GOPATH $HOME/go
  set -Ux GOROOT /usr/local/go
  set -Ux GONOPROXY "git.garena.com"
  set -Ux GONOSUMDB "git.garena.com"
  set -Ux GOPRIVATE "git.garena.com"
  set -Ux GOPROXY "https://proxy.golang.org,direct"
  set -Ux GOSUMDB "sum.golang.org"
  set -Ux GOTMPDIR ""
  set -Ux GOSRC $GOPATH/src

  set -Ux PATH $PATH:$GOBIN
  set -Ux PATH $PATH:$GOROOT/bin

  set -Ux TMOUT 10000
  set -Ux JAVA_HOME /usr/local/Cellar/openjdk@11/11.0.10
  set -Ux SHELL /opt/local/bin/fish

  fish_add_path "/opt/local/bin"
  fish_add_path "/usr/local/Cellar/vim/bin"
  fish_add_path "/usr/local/Cellar/llvm/13.0.0_2/bin"
  fish_add_path "/usr/local/bin"
  fish_add_path "/usr/local/mysql/bin:/usr/local/opt/rabbitmq/sbin"
  fish_add_path "/usr/local/opt/llvm/bin/"
  fish_add_path "/Users/bingjia.chen/.cargo/bin"
  fish_add_path "/usr/local/bin/"
  fish_add_path "/usr/local/opt/mysql@5.7/bin/"
end

function setup_alias
  alias vim "nvim"
  alias pc "pbcopy"
  alias pp "pbpaste"
  # alias niz="for file in \`fzf\`; do nvim -o \$file; done"
  alias cdo="cd $OLDPWD"
  alias dlv="dlv --check-go-version=false"
  alias jira="~/jira.sh"
  alias tz="trans -t zh-CN " 
  alias vimdiff="nvim -d" 
  alias gs="git status"
  alias gc="git checkout"
  alias gr="git restore"
  alias grs="git restore --staged"
  alias gps="git push"
  alias gpl="git pull"
  alias ls="exa"
  alias ":q"="exit"
  alias ":wq"="exit"
  alias ":wqa"="exit"



  alias smte="smc -e test services enter "
  alias smue="smc -e uat services enter "
  alias smse="smc -e staging services enter "
  alias smle="smc -e live services enter "
  alias smtd="smc -e test services download "
  alias smud="smc -e uat services download "
  alias smsd="smc -e staging services download "
  alias smld="smc -e live services download "
  alias smtu="smc -e test services upload "
  alias smuu="smc -e uat services upload "
  alias smsu="smc -e staging services upload "
  alias smlu="smc -e live services upload "
  alias vm-on="sudo systemctl start libvirtd.service"

  alias vm-off="sudo systemctl stop libvirtd.service"
  alias musica="ncmpcpp"
  # alias ls='lsd -a --group-directories-first'
  alias ll='lsd -la --group-directories-first'


  alias sb="/Users/bingjia.chen/go/src/tools/build.py build"


  alias gmv="go mod vendor"
  alias gmt="go mod tidy"
  alias rm="rm -i"
  # alias "cd"="z"
  alias "sb"="/Users/bingjia.chen/go/src/tools/build.py build"
  alias "gitui"="gitui -t frappe.ron"

end

function add_history_entry
  begin
    flock 1
    and echo -- '- cmd:' (
    string replace -- \n \\n (string join ' ' $argv) | string replace \\ \\\\
      )
    and date +'  when: %s'
  end >> $__fish_user_data_dir/fish_history
  and history merge
end

function pf
  fzf --bind ctrl-y:preview-up,ctrl-e:preview-down  \
    --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down  \
    --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down  \
    --bind ctrl-k:up,ctrl-j:down  \
    --preview='(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'  
end 

function viz 
  set file $(pf)
  set cmd "vim -o $file"
  add_history_entry "$cmd"
  eval "$cmd"
end

if status is-interactive
  fish_config theme choose tokyonight_storm
  # Commands to run in interactive sessions can go here
  fish_vi_key_bindings
  # fish_config theme save "Catppuccin Frappe"
  setup_envs
  setup_alias
  setup_plugins
  # fzf 
  source /opt/local/share/fzf/shell/key-bindings.fish
end
