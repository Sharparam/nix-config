{ lib, ... }:
{
  den.aspects.apps.provides.vscode = {
    darwin = {
      homebrew = {
        casks = [ "visual-studio-code" ];
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        programs.vscode = {
          enable = lib.mkDefault true;
          package = pkgs.vscode.fhs;
          # enableUpdateCheck = true;
          # enableExtensionUpdateCheck = true;
          # mutableExtensionsDir = true;
          # extensions = builtins.attrValues { inherit (pkgs.vscode-extensions)
          #   ;
          # };
          # userSettings = {
          #
          # };
        };
      };
  };
}
