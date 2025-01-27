{
  lib,
  pkgs,
  namespace,
  options,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
  rev = with inputs; self.rev or self.dirtyRev or null;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    system.configurationRevision = rev;
    environment.systemPackages = with pkgs; [
      snix.scripts
      catppuccin-cursors.frappeDark
    ];

    programs.zsh = enabled;

    catppuccin = {
      enable = true;
      flavor = "frappe";
    };

    ${namespace} = {
      nix = enabled;

      system = {
        interface = enabled;
      };

      security = {
        age = enabled;
        gpg = enabled;
        sudo = enabled;
      };

      services = {
        openssh = enabled;
      };
    };
  };
}
