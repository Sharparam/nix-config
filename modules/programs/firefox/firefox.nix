{
  programs.firefox = {
    darwin = {
      homebrew = {
        casks = [ "firefox" ];
      };
    };

    homeManager =
      { lib, pkgs, ... }:
      {
        programs.firefox = {
          enable = lib.mkDefault (!pkgs.stdenv.isDarwin);
          policies = {
            HttpsOnlyMode = "enabled";
            OfferToSaveLogins = false;
            OfferToSaveLoginsDefault = false;
            PasswordManagerEnabled = false;
            PromptForDownloadLocation = true;
          };
          profiles = {
            default = {
              id = 0;
              name = "default";
              isDefault = true;
              extensions = builtins.attrValues {
                inherit (pkgs.nur.repos.rycee.firefox-addons)
                  augmented-steam
                  # bitwarden
                  consent-o-matic
                  darkreader
                  dearrow
                  firemonkey
                  imagus
                  indie-wiki-buddy
                  kagi-search
                  keepass-helper
                  mailvelope
                  multi-account-containers
                  onepassword-password-manager
                  plasma-integration
                  privacy-badger
                  reddit-enhancement-suite
                  refined-github
                  sidebery
                  simplelogin
                  sponsorblock
                  steam-database
                  toolkit-for-ynab
                  tridactyl
                  ublock-origin
                  user-agent-string-switcher
                  wayback-machine
                  web-scrobbler
                  ;
              };
              search = {
                force = true;
                default = "Kagi";
                privateDefault = "Kagi";
                order = [
                  "Kagi"
                  "DuckDuckGo"
                  "Google"
                ];
              };
              settings = {
                "security.insecure_connection_text.enabled" = true;
                "security.insecure_connection_text.pbmode.enabled" = true;
                "dom.webgpu.enabled" = true;
                "gfx.webrender.all" = true;
                "layers.gpu-process.enabled" = true;
                "layers.mlgpu.enabled" = true;
                "media.ffmpeg.vaapi.enabled" = true;
                "media.gpu-process-decoder" = true;
                "media.hardware-video-decoding.enabled" = true;
              };
              userChrome = builtins.readFile ./chrome/userChrome.css;
            };
          };
        };
      };
  };
}
