# From @thexyno's repo:
# https://github.com/thexyno/nixos-config/blob/1685aa3a522439c75849c5e62f44a57f72312650/lib/options.nix

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  mkOpt = type: default: mkOption { inherit type default; };

  mkOpt' =
    type: default: description:
    mkOption { inherit type default description; };

  mkBoolOpt =
    default:
    mkOption {
      inherit default;
      type = types.bool;
      example = true;
    };
}
