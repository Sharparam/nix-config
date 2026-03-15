# Exposes flake apps under the name of each host / home for building with nh.
{ den, lib, ... }:
let
  keepCount = 3;
  keepAge = "7d";
  cleanArgs = "--keep ${toString keepCount} --keep-since ${keepAge}";
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };

  den.default = {
    nixos = {
      programs.nh = {
        enable = true;
        clean = {
          enable = lib.mkDefault true;
          extraArgs = cleanArgs;
        };
        flake = lib.mkDefault "/home/sharparam/repos/github.com/Sharparam/nix-config?submodules=1";
      };

      nix.gc.automatic = false;
    };

    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.nh
        ];

        environment.variables = {
          NH_FLAKE = lib.mkDefault "/Users/sharparam/repos/github.com/Sharparam/nix-config?submodules=1";
        };
      };

    homeManager =
      { config, pkgs, ... }:
      let
        flakePath = "${config.home.homeDirectory}/repos/github.com/Sharparam/nix-config?submodules=1";
        sessionVariables = {
          NH_FLAKE = flakePath;
        };
      in
      {
        programs.nh = {
          enable = true;
          clean = lib.mkIf pkgs.stdenv.isDarwin {
            enable = true;
            extraArgs = cleanArgs;
          };
          flake = lib.mkDefault flakePath;
        };

        home.sessionVariables = sessionVariables;
        systemd.user.sessionVariables = sessionVariables;
        programs.zsh.sessionVariables = sessionVariables;
      };
  };
}
