set -U fish_user_paths ~/.local/bin  ~/.cargo/bin ~/.npm-global/bin ~/.config/composer/vendor/bin ~/.emacs.d/bin

set -gx TERM screen-256color-bce;
set -x EDITOR "nvim"

alias edit "emacsclient -cn -a vim -F '\'(fullscreen . maximized)'" 
alias e "edit"
alias brew_arm "arch --arm64 /opt/homebrew/bin/brew"
alias brew_x86 "arch --x86_64 /usr/local/bin/brew"
alias vim "nvim"
alias vi "nvim"

alias tm "tmux -2 new -A -s base"
alias vd "vimdiff"

# Rust alternatives
#alias cat "bat"
#alias ls "exa"
#alias x "exa"
#alias find "fdfind"
#alias grep "rg"
#alias du "dust"
#alias cloc "tokei"
#alias ps "procs"
#alias sed "sd"
#alias top "btm"
#alias htop "btm"

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
set -x MANPAGER "less -X"
set -x GIT_COMPLETION_CHECKOUT_NO_GUESS "1"
set -x MAILCHECK "0"

# Starship propmt
starship init fish | source

# LS_COLORS
#source ~/.lscolors.sh

# opam configuration
source /Users/robert/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# Source local stuff.
source ~/.localrc

