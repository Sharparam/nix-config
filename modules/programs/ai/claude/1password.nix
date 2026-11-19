{
  programs.ai.provides.claude = {
    homeManager =
      # { pkgs, ... }:
      # let
      #   inherit (pkgs) fetchFromGitHub;
      # in
      {
        programs.claude-code = {
          # marketplaces = {
          #   "1password" = fetchFromGitHub {
          #     owner = "1Password";
          #     repo = "1password-claude-plugin";
          #     rev = "da760c756c540fa0e6263aede79908d3999fbb5a"; # latest main on 2026-11-19
          #     sha256 = "sha256-/Ndl0ZeOzSbyNbnPGGZUa2oIAhuJMKxqJ4+stcsCpUk=";
          #   };
          # };
          settings = {
            extraKnownMarketplaces = {
              "1password".source = {
                source = "github";
                repo = "1Password/1password-claude-plugin";
              };
            };
            enabledPlugins = {
              "1password@1password" = true;
            };
          };
        };
      };
  };
}
