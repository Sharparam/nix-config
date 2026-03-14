{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  flake-file.inputs.iosevka = {
    url = lib.mkDefault "github:Sharparam/Iosevka/v1.0.1";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  den.aspects.base = {
    os =
      { pkgs, ... }:
      {
        environment.variables = {
          LOG_ICONS = "true";
        };

        fonts = {
          packages = builtins.attrValues {
            inherit (pkgs)
              corefonts

              jetbrains-mono

              meslo-lgs-nf

              noto-fonts
              noto-fonts-cjk-sans
              noto-fonts-cjk-serif
              noto-fonts-color-emoji

              roboto
              ;

            inherit (pkgs.nerd-fonts)
              caskaydia-cove
              hack
              iosevka
              symbols-only
              ;

            inherit (pkgs.local)
              nonicons-bin
              ;

            iosevka-sharpie = inputs.iosevka.packages.${pkgs.stdenv.hostPlatform.system}.bin;
          };
        };
      };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            font-manager
            fontpreview
            smile
            ;
        };

        fonts = {
          enableDefaultPackages = true;

          fontconfig = {
            antialias = true;
            hinting.enable = true;

            defaultFonts =
              let
                nerd = [ "Symbols Nerd Font" ];
                emoji = [
                  "Noto Color Emoji"
                  "Noto Emoji"
                ];
              in
              {
                serif = [ "Noto Serif" ] ++ emoji ++ nerd;
                sansSerif = [ "Noto Sans" ] ++ emoji ++ nerd;
                monospace = [
                  "Iosevka Sharpie"
                  "Iosevka Nerd Font"
                ]
                ++ nerd;
                inherit emoji;
              };
          };

          fontDir = {
            enable = true;
          };
        };
      };

    darwin = {
      system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;

      homebrew.casks = [
        "font-sf-pro"
        "font-sf-mono"
        "sf-symbols"
      ];
    };

    homeManager =
      { lib, pkgs, ... }:
      lib.mkIf pkgs.stdenv.isLinux {
        fonts.fontconfig = {
          enable = mkDefault true;
        };

        xdg.configFile."fontconfig/conf.d/99-local-fonts.conf".source = ./99-local-fonts.conf;

        home.activation.ensureDummyFontConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p "$HOME/.config/fontconfig/conf.d"
          run cp $VERBOSE_ARG ${builtins.toPath ./00-dummy.conf} "$HOME/.config/fontconfig/conf.d/00-dummy.conf"
        '';
      };
  };
}
