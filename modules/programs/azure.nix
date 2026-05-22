{
  programs.azure = {
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
        };
      };
  };
}
