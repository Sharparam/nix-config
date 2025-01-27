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
  cfg = config.${namespace}.tools.zoxide;
in
{
  options.${namespace}.tools.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd j"
      ];
    };

    ${namespace}.cli.aliases = {
      pj = ''
        pushd "$(${pkgs.zoxide}/bin/zoxide -e $@)"
      '';
    };
  };
}
