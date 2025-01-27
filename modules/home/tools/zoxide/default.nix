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
  options.${namespace}.tools.zoxide = with types; {
    enable = mkEnableOption "zoxide";
    cmd = mkOpt (nullOr str) "j" "Zoxide command (alias) (set to null to disable)";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options =
        let
          cmdArg = if (cfg.cmd == null) then "--no-cmd" else "--cmd ${cfg.cmd}";
        in
        [
          cmdArg
        ];
    };

    ${namespace}.cli.aliases =
      let
        zoxide = if (cfg.cmd == null) then "${pkgs.zoxide}/bin/zoxide" else cfg.cmd;
      in
      {
        pj = ''
          pushd "$(${zoxide} -e $@)"
        '';
      };
  };
}
