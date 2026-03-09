{
  lib,
  pkgs,
  namespace,
  system,
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
  cfg = config.${namespace}.security.sops;
in
{
  options.${namespace}.security.sops =
    let
      inherit (types) listOf path;
    in
    {
      enable = mkEnableOption "sops";
      defaultSopsFile = mkOption {
        type = path;
        default = lib.snowfall.fs.get-file "systems/${system}/${config.networking.hostName}/secrets.yml";
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

    environment.systemPackages = [
      pkgs.sops
    ];
  };
}
