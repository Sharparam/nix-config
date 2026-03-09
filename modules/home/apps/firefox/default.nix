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
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = with types; {
    enable = mkEnableOption "Whether or not to enable Firefox.";
    extensions = mkOption {
      type = listOf package;
      default = [ ];
      description = "Extra extensions to install";
    };
    extraConfig = mkOption {
      type = str;
      default = "";
      description = "Extra configuration for the user.js file";
    };
    gpuAcceleration = mkOption {
      type = bool;
      default = true;
      description = "Enable GPU acceleration";
    };
    hardwareDecoding = mkOption {
      type = bool;
      default = true;
      description = "Enable hardware video decoding.";
    };
    settings = mkOption {
      type = attrs;
      default = { };
      description = "Settings to apply.";
    };
    userChrome = mkOption {
      type = str;
      default = "";
      description = "Extra configuration for the user chrome CSS file";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        HttpsOnlyMode = "enabled";
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        PromptForDownloadLocation = true;
      };
      profiles = {
        default = {
          inherit (cfg) extraConfig;

          id = 0;
          name = "default";
          isDefault = true;
          extensions =
            with pkgs.nur.repos.rycee.firefox-addons;
            [
              augmented-steam
              bitwarden
              darkreader
              dearrow
              imagus
              indie-wiki-buddy
              multi-account-containers
              onepassword-password-manager
              privacy-badger
              reddit-enhancement-suite
              refined-github
              sidebery
              sponsorblock
              steam-database
              stylus
              toolkit-for-ynab
              tridactyl
              ublock-origin
              user-agent-string-switcher
              violentmonkey
              wayback-machine
              web-scrobbler
            ]
            ++ cfg.extensions;
          search = {
            force = true;
            default = "DuckDuckGo";
            privateDefault = "DuckDuckGo";
            order = [
              "DuckDuckGo"
              "Google"
            ];
          };
          settings = mkMerge [
            cfg.settings
            {
              "security.insecure_connection_text.enabled" = true;
              "security.insecure_connection_text.pbmode.enabled" = true;
            }
            (optionalAttrs cfg.gpuAcceleration {
              "dom.webgpu.enabled" = true;
              "gfx.webrender.all" = true;
              "layers.gpu-process.enabled" = true;
              "layers.mlgpu.enabled" = true;
            })
            (optionalAttrs cfg.hardwareDecoding {
              "media.ffmpeg.vaapi.enabled" = true;
              "media.gpu-process-decoder" = true;
              "media.hardware-video-decoding.enabled" = true;
            })
          ];
          userChrome = builtins.readFile ./chrome/userChrome.css + "${cfg.userChrome}";
        };
      };
    };
  };
}
