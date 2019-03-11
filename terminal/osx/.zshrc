# bash tools
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# zsh
export ZSH=/Users/lynn/.oh-my-zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# zsh cont
source $ZSH/oh-my-zsh.sh
DEFAULT_USER=lynn
autoload -U promptinit; promptinit
prompt pure
PURE_GIT_PULL=0

# system config
export EDITOR='code'
export SSH_KEY_PATH="~/.ssh/rsa_id"

# python
export PIP_REQUIRE_VIRTUALENV=true
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH="`python3 -m site --user-base`/bin:$PATH"

# node version manager
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

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

# added by travis gem
# [ -f /Users/lynn/.travis/travis.sh ] && source /Users/lynn/.travis/travis.sh

# go
export GOROOT=/usr/local/opt/go/libexec
export GO111MODULE=on
