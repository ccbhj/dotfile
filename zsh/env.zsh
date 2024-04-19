export GO111MODULE="on"
export GONOPROXY="git.garena.com"
export GONOSUMDB="git.garena.com"
export GOPRIVATE="git.garena.com"
export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB="sum.golang.org"
export GOTMPDIR=""
export GOSRC=$GOPATH/src
export GOPATH=$(asdf where golang)/packages
export GOROOT=$(asdf where golang)/go
export GOBIN=$(asdf where golang)/go/bin
export PATH="${PATH}:${GOBIN}"

export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin

export TMOUT=10000

# macos
# export PATH="/usr/local/Cellar/vim/bin:$PATH"
# export PATH="/usr/local/Cellar/llvm/13.0.0_2/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"
# export PATH="$PATH:/usr/local/mysql/bin:/usr/local/opt/rabbitmq/sbin"
# export PATH="$PATH:/usr/local/opt/llvm/bin/"
# export PATH="$PATH:/Users/bingjia.chen/.cargo/bin"
# export PATH="$PATH:/usr/local/bin/"
# export PATH="$PATH:/usr/local/opt/mysql@5.7/bin/"
# export JAVA_HOME=/usr/local/Cellar/openjdk@11/11.0.10
# export VCPKG_ROOT="$HOME/vcpkg"
# export HOMEBREW_NO_AUTO_UPDATE=1

export XDG_CONFIG_HOME=$HOME/.config
export WLS="$GOSRC/wallet_server/"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
