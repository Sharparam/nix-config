{ inputs, lib, ... }:
let
  autoAttach = false;
in
{
  flake-file.inputs.zellij-plugins = {
    url = "github:Sharparam/zellij-plugins-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.base = {
    homeManager =
      { pkgs, inputs', ... }:
      let
        pkg = pkgs.zellij;
        zellij = lib.getExe pkg;
        zellijPlugins = inputs'.zellij-plugins.packages;
        sed = lib.getExe pkgs.gnused;
      in
      {
        programs.zellij = {
          enable = true;
          package = pkg;
          enableBashIntegration = autoAttach;
          enableZshIntegration = autoAttach;
          enableFishIntegration = autoAttach;
          attachExistingSession = autoAttach;
          exitShellOnExit = false;
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

              autolock = {
                _props = {
                  location = "file:${zellijPlugins.zellij-autolock}/bin/zellij-autolock.wasm";
                };
                is_enabled = true;
                triggers = lib.join "|" [
                  "atuin"
                  "emacs"
                  "fzf"
                  "git"
                  "jj"
                  "nvim"
                  "vim"
                  "zoxide"
                ];
              };
            };
            load_plugins = {
              autolock = { };
            };
          };
        };

        programs.bash.initExtra = ''
          eval "$(${zellij} setup --generate-completion bash)"

          function zrc() {
            zellij run --close-on-exit --name "$*" -- zsh -ic "$*"
          }

          function zrfc() {
            zellij run --close-on-exit --name "$*" --floating -- zsh -ic "$*"
          }

          function zric() {
            zellij run --close-on-exit --name "$*" --in-place -- zsh -ic "$*"
          }
        '';

        # programs.zsh.initContent = lib.mkOrder 1000 ''
        #   eval "$(${zellij} setup --generate-completion zsh | ${sed} '/_zellij "$@"/d')"
        # '';

        programs.zsh = {
          siteFunctions = {
            zr = ''
              zellij run --name "$*" -- zsh -ic "$*"
            '';
            zrc = ''
              zellij run --close-on-exit --name "$*" -- zsh -ic "$*"
            '';
            zrf = ''
              zellij run --name "$*" --floating -- zsh -ic "$*"
            '';
            zrfc = ''
              zellij run --close-on-exit --name "$*" --floating -- zsh -ic "$*"
            '';
            zri = ''
              zellij run --name "$*" --in-place -- zsh -ic "$*"
            '';
            zric = ''
              zellij run --close-on-exit --name "$*" --in-place -- zsh -ic "$*"
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
