_: {
  den.aspects.base = {
    homeManager =
      { lib, pkgs, ... }:
      {
        programs.jujutsu = {
          enable = true;
          settings = {
            user = {
              name = "Adam Hellberg";
              email = "sharparam@sharparam.com";
            };
            signing = {
              behavior = "own";
              backend = "ssh";
              backends.ssh = {
                allowed-signers = "~/.ssh/allowed_signers";
                program =
                  if pkgs.stdenv.isLinux then
                    (lib.getExe' pkgs._1password-gui "op-ssh-sign")
                  else
                    "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
              };
            };
            git = {
              auto-local-bookmark = false;
              colocate = true;
              private-commits = "blacklist()";
              sign-on-push = true;
              write-change-id-header = true;
            };
            ui = {
              default-command = "log";
              show-cryptographic-signatures = true;
            };
          };
        };
      };
  };
}
