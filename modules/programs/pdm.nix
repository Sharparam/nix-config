{ lib, ... }:
{
  programs.pdm = {
    homeManager =
      { config, pkgs, ... }:
      let
        tomlFormat = pkgs.formats.toml { };
      in
      {
        home.packages = [ pkgs.stable.pdm ];

        home.sessionVariables = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
          PDM_CONFIG_FILE = "${config.xdg.configHome}/pdm/config.toml";
        };

        xdg.configFile."pdm/config.toml".source = tomlFormat.generate "config.toml" {
          venv.backend = "venv";
        };
      };
  };
}
