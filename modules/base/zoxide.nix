{
  den.aspects.base = {
    homeManager =
      let
        cmd = "j";
      in
      {
        programs.zoxide = {
          enable = true;
          options = [ "--cmd ${cmd}" ];
        };

        programs.bash.initExtra = ''
          pj() {
            pushd "$(${cmd} -e $@)"
          }
        '';

        programs.zsh.siteFunctions = {
          pj = ''
            pushd "$(${cmd} -e $@)"
          '';
        };
      };
  };
}
