gpg-agent --daemon --enable-ssh-support > /dev/null 2>&1
set -x GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
