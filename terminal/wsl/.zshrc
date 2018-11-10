unsetopt BG_NICE

. /usr/share/autojump/autojump.sh

export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

export NVM_DIR="/home/lynn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

fpath+=('/home/lynn/.nvm/versions/node/v11.1.0/lib/node_modules/pure-prompt/functions')

export ZSH="/home/lynn/.oh-my-zsh"
ZSH_THEME=""

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DEFAULT_USER=lynn

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -U promptinit; promptinit
prompt pure
PURE_GIT_PULL=0

export PATH="/home/lynn/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
