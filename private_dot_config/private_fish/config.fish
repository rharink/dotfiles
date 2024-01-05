if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/robert/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/robert/miniconda3/bin/conda
    eval /Users/robert/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/robert/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/robert/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/robert/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

