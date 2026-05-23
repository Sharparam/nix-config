{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.default = {
    homeManager =
      { config, ... }:
      let
        homeDir = config.home.homeDirectory;
      in
      {
        xdg.userDirs = {
          enable = mkDefault true;
          createDirectories = mkDefault true;
          setSessionVariables = mkDefault true;
          desktop = mkDefault "${homeDir}/desktop";
          documents = mkDefault "${homeDir}/documents";
          download = mkDefault "${homeDir}/downloads";
          music = mkDefault "${homeDir}/music";
          pictures = mkDefault "${homeDir}/pictures";
          publicShare = mkDefault "${homeDir}/public";
          projects = mkDefault "${homeDir}/projects";
          templates = mkDefault "${homeDir}/templates";
          videos = mkDefault "${homeDir}/videos";
        };
      };
  };
}
