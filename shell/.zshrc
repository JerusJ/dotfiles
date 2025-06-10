# Uncomment below, and uncomment line at the end of this file to enable ZSH profiling
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive # See: https://nixos.wiki/wiki/Locales

plugins=(
  aws
  aws-mfa
  git
  kubectl
  kubectx
  zsh-autosuggestions
  zsh-completions
)

source $ZSH/oh-my-zsh.sh
source $HOME/.shell_functions

alias kb="kustomize build --enable-helm"
alias kbo="kustomize build --enable-helm -o GENERATED.yaml"
alias kba="kustomize build --enable-helm | kubectl apply -f -"
alias kbd="kustomize build --enable-helm | kubectl delete -f -"

alias tg="terragrunt"
alias tgi="terragrunt init"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias tgd="terragrunt destroy"

alias t="terragrunt"
alias tp="terragrunt plan"

eval `ssh-agent -s`
ssh-add

if [ -f /etc/profile.d/google-cloud-cli.sh ]; then
  source /etc/profile.d/google-cloud-cli.sh
fi

case `uname` in
  Linux)
    setxkbmap -option ctrl:nocaps
    # Keyboard key repeat rate <TIME_TO_REPEAT> <REPETITIONS_PER_SECOND>
    xset r rate 200 75
  ;;
esac

# =============
#    INIT
# =============
export KUBECONFIG=$HOME/.kube/config
# NOTE(jesse): broken since kubectx does not support (on Linux in default installation) multiple
# KUBECONFIGs separated by ':'...
# Dynamically set KUBECONFIG to include all .kubeconfig files in $HOME/.kube (useful for kubectx)
# export KUBECONFIG=$(find "$HOME/.kube" -type f -name "*.kubeconfig" -print0 | xargs -0 echo | tr ' ' ':')

export PATH="$HOME/fzf-zsh-plugin/bin:$PATH"
export PATH="$HOME/GoLand/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Android SDK: https://gist.github.com/dianjuar/a86814b592dad96cfa9d9540cb5acbe0
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/Android/Sdk/cmdline-tools/latest/bin:$PATH

export DIR_THIRD_PARTY="$HOME/third-party-packages"

export LIBVIRT_DEFAULT_URI="qemu:///system"

# Senstive functions which are not pushed to Github
# It contains GOPATH, some functions, aliases etc...
[ -r ~/.zsh_private ] && source ~/.zsh_private

export EDITOR="nvim"
export PAGER="nvim"
export TERMINAL="alacritty"

# =============
#    ALIAS
# =============

alias gr="git rebase"
alias ..='cd ..'

alias d='git diff'
alias vi='nvim'
alias vim='nvim'

alias vrdp='xfreerdp /v:127.0.0.1:33389 /u:vagrant /p:vagrant'

case `uname` in
  Darwin)
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed'
    alias ls='ls -GpF' # Mac OSX specific
    alias ll='ls -alGpF' # Mac OSX specific
  ;;
  Linux)
    alias ll='ls -al'
    alias ls='ls --color=auto'
    # See: https://askubuntu.com/questions/123798/how-to-hear-my-voice-in-speakers-with-a-mic
    alias listen_mic='arecord --buffer-time=1 - | aplay --buffer-time=1 -'
  ;;
esac

alias sq='git rebase -i $(git merge-base $(git rev-parse --abbrev-ref HEAD) $(basename $(git symbolic-ref refs/remotes/origin/HEAD)))'

# if it fails to resolve, set the HEAD with: git remote set-head origin --auto
alias co='git checkout $(basename $(git symbolic-ref refs/remotes/origin/HEAD))'
alias po='git pull origin $(git rev-parse --abbrev-ref HEAD)'

# cd into git root dir
alias cdr='cd $(git rev-parse --show-toplevel)'

# show
alias duh='du -sh -h * .[^.]* 2> /dev/null | sort -h'

# build and test
alias hc='hub compare'
alias hp='hub pull-request'
alias b='git branch'

# open seperate tmux buffer and search for a file, open with vim
function fe() (
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
)

# No idea why vmware can't figure this out by themselves on reboot but whatever
function mount_vmware() {
  sudo vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000
}

function tmux_run_in_dirs() {
  local pattern=$1
  shift
  local cmd="$*"

  find "$HOME/code" -mindepth 1 -maxdepth 1 -type d -name "$pattern" -print0 |
  while IFS= read -r -d '' dir; do
    local name
    name="$(basename "$dir")"
    # check if window exists
    if ! tmux list-windows -F "#{window_name}" | grep -Fxq "$name"; then
      tmux new-window -d -n "$name" "cd '$dir' && $cmd; ${SHELL}"
    fi
  done
}

# open github repo from git repo
function hb() {
  # from https://jasonmccreary.me/articles/open-github-command-line/
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/'`;
  open $github_url
}

# Go
export GO111MODULE=auto
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# =============
#    EXPORT
# =============

export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

setopt PUSHDSILENT
# =============
#    HISTORY
# =============

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
# ignore duplication command history list
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
# share command history data
setopt share_history

# ===================
#    AUTOCOMPLETION
# ===================
# enable completion
autoload -Uz compinit
compinit

autoload bashcompinit
bashcompinit

zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# ===================
#    KEY BINDINGS
# ===================
# Use emacs-like key bindings by default:
bindkey -e

# [Ctrl-r] - Search backward incrementally for a specified string. The string
# may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

# ===================
#    MISC SETTINGS
# ===================

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# only exit if we're not on the last pane

exit() {
  if [[ -z $TMUX ]]; then
    builtin exit
    return
  fi

  panes=$(tmux list-panes | wc -l)
  wins=$(tmux list-windows | wc -l)
  count=$(($panes + $wins - 1))
  if [ $count -eq 1 ]; then
    tmux detach
  else
    builtin exit
  fi
}

function switchgo() {
  version=$1
  if [ -z $version ]; then
    echo "Usage: switchgo [version]"
    return
  fi

  if ! command -v "go$version" > /dev/null 2>&1; then
    echo "version does not exist, downloading with commands: "
    echo "  go get golang.org/dl/go${version}"
    echo "  go${version} download"
    echo ""

    go get "golang.org/dl/go${version}"
    go${version} download
  fi

  go_bin_path=$(command -v "go$version")
  ln -sf "$go_bin_path" "$GOBIN/go"
  echo "Switched to ${go_bin_path}"
}

# ===================
#    THIRD PARTY
# ===================
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# Formatters
export YAMLFIX_WHITELINES="1"
export YAMLFIX_COMMENTS_REQUIRE_STARTING_SPACE="true"

# Python
export PATH=$PATH:"$HOME/.local/bin"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Go
export GO111MODULE=on
export GOPATH="$HOME/.gopath"
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"/usr/local/go/bin"

# Rust
export PATH=$PATH:"$HOME/.cargo/bin"

# Node
export NVM_DIR="$HOME/.nvm"
export NODE_VERSIONS="${NVM_DIR}/versions/node"
export NODE_VERSIONS_PREFIX="v"
export NPM_MODULES_DIR="$HOME/.npm_global"
export PATH=$PATH:"${NPM_MODULES_DIR}/bin"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# C#
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# Emacs
export PATH=$PATH:"$HOME/.emacs.d/bin"
export PATH=$PATH:"$HOME/.config/emacs/bin"
# Brew
export PATH="/usr/local/sbin:$PATH"

# Kubernetes
alias k=kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

# Direnv
eval "$(direnv hook zsh)"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh

export PROMPT_COMMAND='if [ -d .git -a ! -x .git/hooks/pre-commit -a -e .pre-commit-config.yaml ] && which pre-commit >& /dev/null; then pre-commit install; fi; '"$PROMPT_COMMAND"
precmd() { eval "$PROMPT_COMMAND" }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $GOPATH/bin/tk tk

# Uncomment below, and uncomment line at the start of this file to enable ZSH profiling
# zprof
