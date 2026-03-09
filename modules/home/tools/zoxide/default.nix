{
  lib,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.${namespace}.tools.zoxide;
in
{
  options.${namespace}.tools.zoxide = {
    enable = mkEnableOption "zoxide";
    cmd = mkOption {
      type = types.nullOr types.str;
      default = "j";
      description = "Zoxide command (alias) (set to null to disable)";
    };
  };

  config = mkIf cfg.enable {
    programs =
      let
        zoxideCmd = if (cfg.cmd == null) then "zoxide" else cfg.cmd;
      in
      {
        zoxide = {
          enable = true;
          options =
            let
              cmdArg = if (cfg.cmd == null) then "--no-cmd" else "--cmd ${cfg.cmd}";
            in
            [
              cmdArg
            ];
        };

        bash.initExtra = ''
          pj() {
            pushd "$(${zoxideCmd} -e $@)"
          }
        '';

        zsh.siteFunctions = {
          pj = ''
            pushd "$(${zoxideCmd} -e $@)"
          '';
        };
      };
  };
}
