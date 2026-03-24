{ lib, ... }:
let
  authKeysModule = authorizedKeys: {
    homeManager =
      { config, ... }:
      {
        home.file.".ssh/authorized_keys.hm-init" = {
          text = lib.join "\n" (
            [
              "# DO NOT EDIT"
              "# This file is managed by Home Manager"
              "# Any manual changes to this file will be overwritten"
            ]
            ++ authorizedKeys
          );
          onChange =
            let
              homeDir = config.home.homeDirectory;
              source = "${homeDir}/.ssh/authorized_keys.hm-init";
              target = "${homeDir}/.ssh/authorized_keys";
            in
            ''
              rm --verbose --force "${target}"
              cp --verbose "${source}" "${target}"
              chmod --verbose 400 "${target}"
              rm --verbose --force "${source}"
            '';
        };
      };
  };

  userHome = { host, user }: authKeysModule user.ssh.authorizedKeys;
  home = { home }: authKeysModule home.ssh.authorizedKeys;
in
{
  den.aspects.ssh = {
    includes = [
      userHome
      home
    ];

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
          run mkdir $VERBOSE_ARG -m700 -p "$HOME/.ssh/config.d"
        '';

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
          includes = [
            "~/.ssh/config.d/*"
            "~/.ssh/config.local"
          ];
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
