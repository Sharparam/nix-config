{
  programs.azure = {
    darwin = {
      homebrew.casks = [
        "microsoft-azure-storage-explorer"
      ];
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = builtins.attrValues {
          inherit (pkgs)
            azure-cli
            azure-storage-azcopy
            ;

          inherit (pkgs.azure-cli-extensions)
            account
            ;

          # TODO (2026-05-28): Replace with version in nixpkgs when it stops being ancient
          # See: https://github.com/NixOS/nixpkgs/pull/469509
          bicep = pkgs.local.bicep;
        };
      };
  };
}
