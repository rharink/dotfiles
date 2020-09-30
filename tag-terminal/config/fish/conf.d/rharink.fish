set -U fish_user_paths ~/.local/bin $fish_user_paths
set -U fish_user_paths ~/.cargo/bin $fish_user_paths
set -U fish_user_paths ~/.npm-global/bin $fish_user_paths

alias edit "emacsclient -cn -a vim -F '\'(fullscreen . maximized)'" 
alias e "edit"

alias tm "tmux -2 new -A -s base"
alias vd "vimdiff"
alias vim "nvim"

# Screen/monitor setup aliases
#alias screen-dual "xrandr --setprovideroutputsource 1 0; xrandr --output DVI-I-1-1 --auto --above eDP1"

alias cat "bat"
#alias ls "exa"

# Git aliasses
alias gs "git status -sb"
alias gd "git diff"
alias gc "git commit"
alias gca "git commit -a"
alias gl "git pull --prune"
alias grb "git rebase -i @{u}"

# Darcs aliasses
alias dw "darcs whatsnew"
alias ds "darcs whatsnew -s"
alias ddiff "darcs diff"
alias dl "darcs log"
alias da "darcs add"
alias dr "darcs record"
set -U DARCS_EDITOR vim

# Exports
#set -x LANG "en_US.UTF-8"
#set -x LC_ALL "en_US.UTF-8"
#set -x MANPAGER "less -X"
#set -x GIT_COMPLETION_CHECKOUT_NO_GUESS "1"
#set -x MAILCHECK "0"

# LS_COLORS
source ~/.lscolors.sh

# Source local stuff.
source ~/.localrc

# Starship propmt
starship init fish | source
