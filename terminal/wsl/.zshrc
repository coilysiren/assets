# WSL support
# https://github.com/Microsoft/WSL/issues/1887#issuecomment-294297758
unsetopt BG_NICE

# https://github.com/wting/autojump
. /usr/share/autojump/autojump.sh

# https://stackoverflow.com/questions/16853624/git-discovery-across-filesystem-not-set
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# https://github.com/creationix/nvm
export NVM_DIR="/home/lynn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# https://github.com/robbyrussell/oh-my-zsh
export ZSH="/home/lynn/.oh-my-zsh"
ZSH_THEME=""
plugins=()
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DEFAULT_USER=lynn

# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/sindresorhus/pure
fpath+=('/home/lynn/.nvm/versions/node/v11.1.0/lib/node_modules/pure-prompt/functions')
autoload -U promptinit; promptinit
prompt pure
PURE_GIT_PULL=0

# aliases
function gc {
  _gc "$1" &
}
function _gc {
  rm -f .gitoutput
  git commit . -m "$1" --allow-empty &>> .gitoutput
  git push -u origin HEAD --verbose &>> .gitoutput
  [ $? -ne 0 ] && cat .gitoutput; rm -f .gitoutput
}
alias ls='ls -GFh'
alias gt='git status'
alias gush="git push -u origin HEAD"
alias git-modified="$EDITOR `git status --porcelain | sed -ne 's/^ M //p'`"
alias line-wrap-disable='tput rmam'
alias line-wrap-enable='tput smam'

# go
export GO111MODULE=on
export GOPATH=/mnt/c/Users/Lynn/projects/
