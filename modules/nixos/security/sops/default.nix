{
  lib,
  pkgs,
  namespace,
  system,
  config,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.security.sops;
in
{
  options.${namespace}.security.sops = with types; {
    enable = mkEnableOption "Enable sops";
    defaultSopsFile = mkOption {
      type = path;
      default = snowfall.fs.get-file "systems/${system}/${config.networking.hostName}/secrets.yml";
      description = "Default sops file.";
    };
    sshKeyPaths = mkOption {
      type = listOf path;
      default = [ "/etc/ssh/ssh_host_ed25519_key" ];
      description = "SSH key paths to use.";
    };
  };

  config = mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;

      age = {
        inherit (cfg) sshKeyPaths;
      };

      secrets = {
        example_key = { };
      };
    };

    environment.systemPackages = with pkgs; [
      sops
    ];
  };
}
