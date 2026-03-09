{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.github;
in
{
  options.${namespace}.tools.github = {
    enable = mkEnableOption "GitHub";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.github-copilot-cli
    ];
  };
}
