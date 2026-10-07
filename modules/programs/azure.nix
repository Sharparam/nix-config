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
            bicep
            ;

          inherit (pkgs.azure-cli-extensions)
            account
            ;
        };
      };
  };
}
