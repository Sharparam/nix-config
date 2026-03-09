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
  cfg = config.${namespace}.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = {
      fileName = defaultIconFileName;
    };
  };
  propagatedIcon =
    pkgs.runCommandNoCC "propagated-icon"
      {
        passthru = {
          inherit (cfg.icon) fileName;
        };
      }
      ''
        local target="$out/share/${namespace}-icons/user/${cfg.name}"
        mkdir -p "$target"

        cp ${cfg.icon} "$target/${cfg.icon.fileName}"
      '';
in
{
  options.${namespace}.user = with types; {
    name = mkOption {
      type = str;
      default = "sharparam";
      description = "The name to use for the user account.";
    };
    fullName = mkOption {
      type = str;
      default = "Adam Hellberg";
      description = "The full name of the user.";
    };
    email = mkOption {
      type = str;
      default = "sharparam@sharparam.com";
      description = "The email of the user.";
    };
    initialPassword = mkOption {
      type = str;
      default = "password";
      description = "The initial password to use when the user is first created.";
    };
    icon = mkOption {
      type = nullOr package;
      default = defaultIcon;
      description = "The profile picture to use for the user.";
    };
    prompt-init = mkOption {
      type = bool;
      default = true;
      description = "Whether to show an initial message when opening a new shell.";
    };
    extraGroups = mkOption {
      type = listOf str;
      default = [ ];
      description = "Groups for the user to be assigned.";
    };
    extraOptions = mkOption {
      type = attrs;
      default = { };
      description = mdDoc "Extra options passed to `users.users.<name>`.";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [ propagatedIcon ];
    environment.localBinInPath = true;

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };

    ${namespace}.home = {
      file = {
        "repos/.keep".text = "";
        ".face".source = cfg.icon;
        "Pictures/${cfg.icon.fileName or (builtins.baseNameOf cfg.icon)}".source = cfg.icon;
      };
    };

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.zsh;

      uid = 1000;

      inherit (cfg) extraGroups;
    }
    // cfg.extraOptions;
  };
}
