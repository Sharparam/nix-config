{
  lib,
  pkgs,
  inputs,
  options,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
  rev =
    if (lib.hasAttrByPath [ "rev" ] inputs.self.sourceInfo) then
      inputs.self.sourceInfo.rev
    else
      "Dirty Build";
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    system.configurationRevision = rev;
    environment.systemPackages = with pkgs; [
      snix.scripts
    ];
    services = {
      getty.greetingLine = "<<< Welcome to ${config.system.nixos.label} @ ${rev} - \\l >>>";
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    catppuccin = {
      enable = true;
      flavor = "frappe";
    };

    ${namespace} = {
      nix = enabled;

      hardware = {
        audio = enabled;
        networking = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
        time = enabled;
      };

      security = {
        age = enabled;
        gpg = enabled;
      };

      tools = {
        ssh = enabled;
      };

      apps = {
        vim = enabled;
      };
    };
  };
}
