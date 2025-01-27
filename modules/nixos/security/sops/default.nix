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
    defaultSopsFile =
      mkOpt path (snowfall.fs.get-file "systems/${system}/${config.networking.hostName}/secrets.yml")
        "Default sops file.";
    sshKeyPaths = mkOpt (listOf path) [ "/etc/ssh/ssh_host_ed25519_key" ] "SSH key paths to use.";
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
