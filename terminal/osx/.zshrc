# brew & bash & zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# language
export LANG=en_US.UTF-8

# system config
export CLI_MFA="ykman"
export DEFAULT_USER=kai
export GIT_EDITOR="nano"
export EDITOR='code'
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"

# paths
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# shortcut functions
function git-checkpoint {
  checkpoint=checkpoint-$(whoami)-$(date +%s)
  _git-commit "${@:-$checkpoint}" &
}
function _git-commit {
  rm -f .gitoutput
  git commit . -m "$@" --allow-empty &>>.gitoutput
  git push -u origin HEAD --verbose &>>.gitoutput
  [ $? -ne 0 ] && cat .gitoutput
  rm -f .gitoutput
}
function git-pr-title {
  env PAGER="" gh pr view --json "title" --jq ".title"
}
function git-default-branch {
  git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'
}
function git-merge-default-branch {
  git switch "$(git-default-branch)"
  git pull
  git switch -
  git fetch origin "$(git-default-branch)"
  git merge origin/"$(git-default-branch)"
}
function git-unstage-files {
  git-merge-default-branch
  git reset $(git merge-base $(git-default-branch) $(git branch --show-current))
}
function git-squash {
  git-merge-default-branch
  git reset $(git merge-base $(git-default-branch) $(git branch --show-current))
  git add -A
  git commit . -m "$(git-pr-title)"
  git push -u origin HEAD -f
}
function docker-bash {
  docker exec -it "$(docker container ls --filter "name=$1" --quiet)" bash
}
function rg-code {
  rg "$1" --files-with-matches | xargs code
}

# python
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# go
export PATH="/usr/local/opt/go@1.13/bin:$PATH"

# node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# java
export JAVA_HOME=/usr/local/Cellar/openjdk/18.0.2/

# aliases
alias ls='ls -GFh'
alias rg="rg --hidden --glob '!.git' --glob '!*.svg' --glob '!.vscode'"
alias rg-conflicts="rg '>>>'"
alias rg-conflicts-code="rg '>>>' --files-with-matches | xargs code"
alias gt='git status'
alias gc='git-checkpoint'
alias gush="git push -u origin HEAD"
