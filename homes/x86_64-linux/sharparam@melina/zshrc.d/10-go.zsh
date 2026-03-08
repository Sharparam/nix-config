typeset -aUx path

if [[ -d '/usr/local/go/bin' ]]; then
  path+=(/usr/local/go/bin)
fi

if [[ -d "$GOPATH/bin" ]]; then
  path+=("$GOPATH/bin")
fi
