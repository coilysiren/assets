# bash tools
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# system installs
export HOMEBREW_AUTO_UPDATE_SECS="86400"

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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# aliases
alias ls='ls -GFh'
alias gt='git status'
alias gush="git push -u origin HEAD"
alias git-modified="$EDITOR `git status --porcelain | sed -ne 's/^ M //p'`"
