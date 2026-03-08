# shellcheck shell=bash

# Restic stuff
[ -f "$HOME/.config/restic/repository" ] && export RESTIC_REPOSITORY_FILE="$HOME/.config/restic/repository"
if [[ -f "$HOME/.config/restic/password_command" ]]; then
  export RESTIC_PASSWORD_COMMAND=$(<"$HOME/.config/restic/password_command")
elif [[ -f "$HOME/.config/restic/password" ]]; then
  export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"
fi
