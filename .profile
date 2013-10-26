# setup the bash history
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=ignoredups

# load bundler exec
[ -f "$HOME/.bundler-exec.sh" ] && source "$HOME/.bundler-exec.sh"

# extend the PATH
PATH=$PATH:$HOME/.bin
PATH=/usr/local/bin:$PATH
PATH=/opt/homebrew-cask/Caskroom/sublime-text3/3047/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH

# lovely java
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

# load nvm
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

# aliases
alias devlog='tail -f log/development.log'
alias testlog='tail -f log/test.log'
alias ttr="touch tmp/restart.txt"
alias gitlog='for k in `git branch | perl -pe s/^..//`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r'
alias setup_branch="rake db:reset && rake db:migrate && rake test:prepare"

# colors
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=46
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=45
    else
      local ansi=44
    fi

    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
      test "$branch" == " " || branch=" $branch "
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
    fi

    echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
  fi
}
function _prompt_command() {
    PS1="`_git_prompt`"'\[\e[1;34m\]\w ∴\[\e[0m\] '
}
PROMPT_COMMAND=_prompt_command

# git: auto merge pull request
export GIT_MERGE_AUTOEDIT=no

# load the git branch name autocompletion
source `brew --prefix git`/etc/bash_completion.d/git-completion.bash

# add ssh key to ssh-agent
ssh-add

export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
