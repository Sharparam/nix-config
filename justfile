# https://just.systems

justfile_dir := justfile_directory()
flake_path := justfile_dir + "?submodules=1"
is_nixos := path_exists("/etc/NIXOS")
nh_sub := if is_nixos == "true" { "nixos" } else if os() == "macos" { "darwin" } else { "home" }

alias fmt := format

export NH_FLAKE := flake_path

default:
    @{{ just_executable() }} --justfile {{ justfile() }} --list

flake:
    nix run '.#write-flake'

lock: flake
    nix flake lock

update: flake
    nix flake update

check:
    nix flake check

format:
    nix fmt

build *args:
    nh {{ nh_sub }} build {{ args }}

switch *args:
    nh {{ nh_sub }} switch {{ args }}
