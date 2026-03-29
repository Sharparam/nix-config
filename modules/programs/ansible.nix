{
  programs.ansible = {
    homeManager =
      { pkgs, ... }:
      let
        iniFormat = pkgs.formats.ini { };
      in
      {
        home.packages = [ pkgs.ansible ];
        home.file.".ansible.cfg".source = iniFormat.generate ".ansible.cfg" {
          defaults = {
            nocows = true;
          };
        };
      };
  };
}
