{
  lib,
  pkgs,
  inputs,
  namespace,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.suites.common;
  # rev =
  #   if (lib.hasAttrByPath [ "rev" ] inputs.self.sourceInfo) then
  #     inputs.self.sourceInfo.rev
  #   else
  #     "Dirty Build";
  rev = inputs.self.rev or inputs.self.dirtyRev or null;
in
{
  options.${namespace}.suites.common = {
    enable = mkEnableOption "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    system.configurationRevision = rev;
    environment.systemPackages = [
      pkgs.catppuccin-cursors.frappeDark
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
      nix.enable = true;

      hardware = {
        audio.enable = true;
        networking.enable = true;
      };

      system = {
        fonts.enable = true;
        locale.enable = true;
        time.enable = true;
      };

      security = {
        age.enable = true;
        gpg.enable = true;
      };

      services = {
        openssh.enable = true;
      };

      tools = {
        ssh.enable = true;
      };

      apps = {
        vim.enable = true;
      };
    };
  };
}
