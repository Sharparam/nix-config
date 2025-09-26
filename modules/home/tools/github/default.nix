{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.github;
in {
  options.${namespace}.tools.github = with types; {
    enable = mkEnableOption "GitHub";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      snix.github-copilot-cli
    ];
  };
}
