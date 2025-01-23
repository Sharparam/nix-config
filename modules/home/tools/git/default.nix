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
  cfg = config.${namespace}.tools.git;
  user = config.${namespace}.user;
in
{
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "Git";
    userName = mkOpt str user.fullName "The name to configure Git with.";
    userEmail = mkOpt str user.email "The email to configure Git with.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      inherit (cfg) userName userEmail;
      enable = true;
      lfs = enabled;
      extraConfig = {
        init.defaultBranch = "main";
        fetch.prune = true;
        pull.ff = "only";
        push = {
          default = "simple";
          autoSetupRemote = true;
        };
        tag = {
          forceSignAnnotated = true;
          sort = "version:refname";
        };
        rerere.enabled = true;
      };
    };
  };
}
