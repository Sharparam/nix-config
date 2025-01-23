{ lib, ... }:
with lib;
rec {
  ## Create a NixOS module option.
  ##
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  ## Create a boolean NixOS module option.
  ##
  ## ```nix
  ## lib.mkBoolOpt true "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt = mkOpt types.bool;

  ## Create a boolean NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkBoolOpt true
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt' = mkOpt' types.bool;

  enabled = {
    ## Quickly enable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ true
    enable = true;
  };

  disabled = {
    ## Quickly disable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ false
    enable = false;
  };

  ## Function to make shell Aliases / Functions
  ## Main reason to use this over the `home.shellAliases` is that this can handle
  ## both simple aliases and things that should be functions.. aka things that require
  ## inputs
  convertAliases =
    aliasAttrs:
    builtins.concatStringsSep "\n" (
      mapAttrsToList (
        name: value:
        let
          containsDollar = builtins.elem "$" (lib.splitString "" value);
          containsNewline = builtins.elem "\n" (lib.splitString "" value);
        in
        if containsDollar || containsNewline then
          ''
            function '${name}'() {
              ${value}
            }
          ''
        else
          let
            # Escape single quotes in the alias value
            escapedValue = builtins.replaceStrings [ "'" ] [ "'\\''" ] value;
          in
          "alias -- '${name}'='${escapedValue}'"
      ) aliasAttrs
    );

}
