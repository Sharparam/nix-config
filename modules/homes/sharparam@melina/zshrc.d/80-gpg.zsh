export GPG_TTY="$(tty)"
if [[ $+commands[gpgconf] -eq 1 ]]; then
  gpgconf --launch gpg-agent
fi
