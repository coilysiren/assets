parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# user @ computer / filepath (git-granch)
export PS1="\a\e[31;1m\u@\h\e[33;1m\w\e[0m  \$(parse_git_branch)\[\033[00m\] \n$ "

export EDITOR="subl"

grep_open() {
     $EDITOR $(grep -lir "$1" .)
}

git_grep_open() {
    $EDITOR $(git grep --name-only "$1")
}

alias ls='ls -GFh'

alias node='nodejs'

alias profile-edit='subl ~/.bash_profile'
alias profile-init='. ~/.bash_profile'
alias profile-source='profile-edit'

alias st='foreman start'

# Git

alias gt='git status'
alias gs='git status'
alias ga='git add . --all'
alias gl='git log --graph --pretty=short'
alias gush="git push -u origin HEAD"
alias git-modified="$EDITOR `git status --porcelain | sed -ne 's/^ M //p'`"

# Python

alias sv='source .venv/bin/activate && profile-source && source .venv/bin/postactivate'
alias pip-remove-all='pip freeze | xargs pip uninstall -y'

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Ruby

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export ENV="development"
export RACK_ENV="development"
export RAILS_ENV="development"
