{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = "frappe";
    };

    ${namespace} = {
      security = {
        gpg = enabled;
      };

      apps = {
        kitty = enabled;
      };

      tools = {
        home-manager = enabled;
        comma = enabled;
        aria2 = enabled;
        bat = enabled;
        curl = enabled;
        direnv = enabled;
        duf = enabled;
        fd = enabled;
        git = enabled;
        htop = enabled;
        hyfetch = enabled;
        jq = enabled;
        lsd = enabled;
        ripgrep = enabled;
        rsync = enabled;
        ssh = enabled;
        tmux = enabled;
        yt-dlp = enabled;
        zoxide = enabled;
        zsh = enabled;
      };
    };
  };
}
