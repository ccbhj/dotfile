alias vim="nvim"
# alias pc="pbcopy"
# alias pp="pbpaste"
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
alias "ls"="exa --icons"
alias "hl"="highlight -O ansi"
alias ":q"="exit"
alias ":wq"="exit"
alias ":wqa"="exit"


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
alias "dv"="! args=$@; shift $#; nvim -c \"DiffviewOpen $args\""


# alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

# alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# alias mantenimiento="yay -Sc && sudo pacman -Scc"
# alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
# alias update="paru -Syu --nocombinedupgrade"

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias musica="ncmpcpp"

# alias ls='lsd -a --group-directories-first'
alias ll='lsd -la --group-directories-first'

