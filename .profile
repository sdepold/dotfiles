# setup the bash history
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=ignoredups

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# load nvm
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

# load bundler exec
[ -f "$HOME/.bundler-exec.sh" ] && source "$HOME/.bundler-exec.sh"

# extend the PATH
PATH=$PATH:$HOME/.bin

# aliases
alias devlog='tail -f log/development.log'
alias testlog='tail -f log/test.log'
alias ttr="touch tmp/restart.txt"

# colors
# Update the command prompt to be <user>:<current_directory>(git_branch) >
# Note that the git branch is given a special color
PS1="\n\u:\w \$(vcprompt) ∴ "

[[ -s "$HOME/Dropbox/System/Bash/profile" ]] && source "$HOME/Dropbox/System/Bash/profile"
