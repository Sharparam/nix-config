let
  substituters = [ "https://claude-code.cachix.org" ];
  trusted-public-keys = [ "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" ];
  nix.settings = {
    inherit substituters trusted-public-keys;
  };
in
{
  den.aspects.ai.provides.claude = {
    os = {
      inherit nix;
    };

    darwin = {
      homebrew.casks = [ "claude" ];
    };

    homeManager =
      { pkgs, ... }:
      {
        inherit nix;

        programs.claude-code = {
          enable = true;
          package = pkgs.claude-code-bin;
        };
      };
  };
}
