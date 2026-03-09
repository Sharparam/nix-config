{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = {
    enable = mkEnableOption "Desktop suite";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        discord.enable = true;
        ghostty.enable = true;
        # TODO: Firefox is broken on darwin
        # https://github.com/NixOS/nixpkgs/issues/366581
        # See firefox module in the darwin tree instead
        firefox.enable = !pkgs.stdenv.isDarwin;
      };
    };
  };
}
