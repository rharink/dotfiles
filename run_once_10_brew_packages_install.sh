{{- if (eq .chezmoi.os "darwin") -}}
#!/bin/bash

set -eufo pipefail

formulae=(
    age
    awscli
    bazelisk
    buf
    bumpversion
    curl
    dust
    fd
    git
    git-delta
    git-gui
    git-lfs
    hledger
    ibazel
    jq
    less
    nushell
    nvm
    neovim
    pandoc
    pueue
    pulumi
    ranger
    shellcheck
    starship
    supabase
    tailscale
    tmux
    tokei
    tree-sitter
    wget
    zoxide
)
casks=(
    1password
    1password-cli
    arc
    iterm2
    kap
    karabiner-elements
    little-snitch
    micro-snitch
    orbstack
    reminders-menubar
    readdle-spark
    timing
)

brew update

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"

brew cleanup
{{ end }}
