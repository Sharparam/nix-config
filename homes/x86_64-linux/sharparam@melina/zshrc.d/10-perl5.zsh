typeset -aUx path

if [[ -d "$HOME/.perl5/bin" ]]; then
  path=("$HOME/.perl5/bin" $path)
fi
