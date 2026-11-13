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

          # TODO: Some bicep unit tests fail depending on host locale
          # Similar to (but not the same test as): https://github.com/Azure/bicep/issues/19751
          bicep = pkgs.bicep.overrideAttrs { doCheck = false; };

          inherit (pkgs.azure-cli-extensions)
            account
            ;
        };
      };
  };
}
