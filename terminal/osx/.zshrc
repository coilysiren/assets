# bash tools
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# zsh
export ZSH=/Users/lynn/.oh-my-zsh
export plugins=(zsh-autosuggestions)
export ZSH_THEME=""
export HYPHEN_INSENSITIVE="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
# zsh cont
source $ZSH/oh-my-zsh.sh
export DEFAULT_USER=lynn
autoload -U promptinit; promptinit
prompt pure
export PURE_GIT_PULL=0

# system config
export EDITOR='code'
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# homebrew paths
export PATH="/usr/local/sbin:$PATH"

# shortcut functions
function gb {
  _gc "bump ci" &
}
function gc {
  _gc "$1" &
}
function _gc {
  rm -f .gitoutput
  git commit . -m "$1" --allow-empty &>> .gitoutput
  git push -u origin HEAD --verbose &>> .gitoutput
  [ $? -ne 0 ] && cat .gitoutput; rm -f .gitoutput
}
function docker-bash {
  docker exec -it "$(docker container ls --filter "name=$1" --quiet)" bash
}

# aliases
alias ls='ls -GFh'
alias gt='git status'
alias gush="git push -u origin HEAD"
alias git-modified="$EDITOR $(git status --porcelain | sed -ne 's/^ M //p')"
alias line-wrap-disable='tput rmam'
alias line-wrap-enable='tput smam'
