{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.tools.lsd;
  lsdAliases = lsd: {
    ls = "${lsd}/bin/lsd --group-dirs first";
    l = "ls --online --all";
    ll = "ls --long";
    la = "ls --all";
    lt = "ls --tree";
  };
in
{
  options.${namespace}.tools.lsd = {
    enable = mkEnableOption "Whether or not to enable the lsd tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.lsd
    ];

    # The lsd aliases won't work in nushell, so we set them for the non-nushell
    # shells we use here.
    programs.bash.shellAliases = lsdAliases pkgs.lsd;
    programs.zsh.shellAliases = lsdAliases pkgs.lsd;
  };
}
