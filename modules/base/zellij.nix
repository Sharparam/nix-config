{ lib, ... }:
{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      let
        pkg = pkgs.zellij;
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
          eval "$(${lib.getExe pkg} setup --generate-completion bash)"
        '';

        programs.zsh.initContent = lib.mkOrder 500 ''
          eval "$(${lib.getExe pkg} setup --generate-completion zsh)"
        '';

        programs.fish.interactiveShellInit = ''
          eval ($(${lib.getExe pkg} setup --generate-completion fish) | string collect)
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
