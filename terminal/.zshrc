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
export HOMEBREW_AUTO_UPDATE_SECS="86400"
export EDITOR='code'
export SSH_KEY_PATH="~/.ssh/rsa_id"

# python
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# node version manager
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# aliases
alias ls='ls -GFh'
alias gt='git status'
alias gush="git push -u origin HEAD"
alias git-modified="$EDITOR `git status --porcelain | sed -ne 's/^ M //p'`"
alias line-wrap-disable='tput rmam'
alias line-wrap-enable='tput smam'

# added by travis gem
[ -f /Users/lynn/.travis/travis.sh ] && source /Users/lynn/.travis/travis.sh
