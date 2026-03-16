let
  cmd = "j";

  homeAspect = {
    homeManager = {
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
in
{
  den.aspects.base.provides = {
    user = homeAspect;
    home = homeAspect;
  };
}
