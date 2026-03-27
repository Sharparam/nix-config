{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      let
        pkg = pkgs.zellij;
        zellij = lib.getExe pkg;
        sed = lib.getExe pkgs.gnused;
      in
      {
        programs.zellij = {
          enable = true;
          package = pkg;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
          settings = {
            attach_to_session = true;
            session_name = "default";
            show_startup_tips = false;
            plugins = {
              compact-bar = {
                _props = {
                  location = "zellij:compact-bar";
                };
                tooltip = "F1";
              };
            };
          };
        };

        programs.bash.initExtra = ''
          eval "$(${zellij} setup --generate-completion bash)"
        '';

        # programs.zsh.initContent = lib.mkOrder 1000 ''
        #   eval "$(${zellij} setup --generate-completion zsh | ${sed} '/_zellij "$@"/d')"
        # '';

        programs.zsh = {
          siteFunctions = {
            zr = ''
              zellij run --name "$*" -- zsh -ic "$*"
            '';
            zrf = ''
              zellij run --name "$*" --floating -- zsh -ic "$*"
            '';
            zri = ''
              zellij run --name "$*" --in-place -- zsh -ic "$*"
            '';
            ze = ''
              zellij edit "$*"
            '';
            zef = ''
              zellij edit --floating "$*"
            '';
            zei = ''
              zellij edit --in-place "$*"
            '';
            zpipe = ''
              if [ -z "$1" ]; then
                zellij pipe;
              else
                zellij pipe -p $1;
              fi
            '';
          };
        };

        programs.fish.interactiveShellInit = ''
          eval ($(${zellij} setup --generate-completion fish) | string collect)
        '';

        home.shellAliases =
          let
            z = "zellij";
          in
          {
            # Commented aliases are provided by the completion generation
            z = z;
            za = "${z} attach";
            zac = "${z} action";
            zd = "${z} delete-session";
            zda = "${z} delete-all-sessions";
            # ze = "${z} edit";
            # zef = "${z} edit --floating";
            # zei = "${z} edit --in-place";
            zk = "${z} kill-session";
            zka = "${z} kill-all-sessions";
            zl = "${z} list-sessions";
            zls = "${z} list-sessions";
            zla = "${z} list-aliases";
            # zr = "${z} run";
            # zrf = "${z} run --floating";
            # zri = "${z} run --in-place";
          };
      };
  };
}
