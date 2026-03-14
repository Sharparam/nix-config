{ lib, ... }:
{
  den.aspects.ssh = {
    nixos = {
      programs = {
        ssh = {
          # Only supported on NixOS
          startAgent = lib.mkDefault false;
        };
      };
    };

    homeManager =
      { lib, pkgs, ... }:
      let
        inherit (lib.hm.dag) entryAfter entryBetween;
      in
      {
        home.activation.createSshHomeDir = entryBetween [ "linkGeneration" ] [ "writeBoundary" ] ''
          run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh"
          run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh/control"
        '';

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
          includes = [ "~/.ssh/config.local" ];
          matchBlocks = {
            "*" = {
              addKeysToAgent = "no";
              compression = false;
              controlMaster = "auto";
              controlPath = "~/.ssh/control/%r@%h:%p";
              controlPersist = "5m";
              forwardAgent = false;
              hashKnownHosts = false;
              serverAliveInterval = 0;
              serverAliveCountMax = 3;
              userKnownHostsFile = "~/.ssh/known_hosts";
            };
            servers = entryAfter [ "*" ] {
              host = "solaire shanalotte matrix radahn";
              hostname = "%h.sharparam.com";
              user = "sharparam";
              forwardAgent = true;
              extraOptions = {
                PasswordAuthentication = "no";
                VerifyHostKeyDNS = "yes";
              };
            };
            solaire = entryAfter [ "servers" ] {
              port = 987;
            };
            shanalotte = entryAfter [ "servers" ] {
              port = 987;
            };
            matrix = entryAfter [ "servers" ] {
              port = 987;
            };
            radahn = entryAfter [ "servers" ] {
              port = 22;
            };
            seedbox = {
              host = "seedbox";
              hostname = "ds16999.seedhost.eu";
              port = 22;
            };
            aur = {
              hostname = "aur.archlinux.org";
              user = "aur";
            };
            github = {
              host = "github gh";
              hostname = "github.com";
              user = "git";
              extraOptions = {
                PasswordAuthentication = "no";
              };
            };
            sol_lan = {
              host = "*.sol.lan";
              forwardAgent = true;
            };
            sol = entryAfter [ "sol_lan" "solaire" ] {
              host = "sol*";
              hostname = "%h.sol.lan";
              forwardAgent = true;
            };
          };
        };
      };
  };
}
