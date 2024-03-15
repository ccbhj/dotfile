alias vim="nvim"
alias pc="pbcopy"
alias pp="pbpaste"
alias pf="
fzf --bind ctrl-y:preview-up,ctrl-e:preview-down \
--bind ctrl-b:preview-page-up,ctrl-f:preview-page-down \
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
--bind ctrl-k:up,ctrl-j:down \
--preview='(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'  
"
alias viz="for file in \`pf\`; do cmd=\"vim \$file\" && print -rs -- \$cmd && eval \$cmd; done"
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
alias "gps"="git push"
alias "gpl"="git pull"
alias "ls"="exa"
alias "hl"="highlight -O ansi"

alias "smte"="smc -e test services enter "
alias "smue"="smc -e uat services enter "
alias "smse"="smc -e staging services enter "
alias "smle"="smc -e live services enter "

alias "smtd"="smc -e test services download "
alias "smud"="smc -e uat services download "
alias "smsd"="smc -e staging services download "
alias "smld"="smc -e live services download "

alias "smtu"="smc -e test services upload "
alias "smuu"="smc -e uat services upload "
alias "smsu"="smc -e staging services upload "
alias "smlu"="smc -e live services upload "


alias "gmv"="go mod vendor"
alias "gmt"="go mod tidy"
alias "rm"="rm -i"
alias "cd"="z"
alias "sb"="/Users/bingjia.chen/go/src/tools/build.py build"
alias "gitui"="gitui -t frappe.ron"

