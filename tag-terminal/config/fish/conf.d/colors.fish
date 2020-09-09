switch $TERM
case '*xte*'
  set -gx TERM xterm-256color
case '*scree*'
  set -gx TERM screen-256color
case '*rxvt*'
  set -gx TERM rxvt-unicode-256color
end

# Base16 Shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end
