# https://just.systems

alias fmt := format

default:
    @{{ just_executable() }} --justfile {{ justfile() }} --list

flake:
    nix run '.#write-flake'

lock: flake
    nix run '.#write-lock'

check:
    nix flake check

format:
    nix fmt
