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
        inherit (lib.hm.dag) entryAfter entryBefore entryBetween;
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
          settings = {
            "*" = {
              AddKeysToAgent = false;
              Compression = false;
              ControlMaster = "auto";
              ControlPath = "~/.ssh/control/%r@%h:%p";
              ControlPersist = "5m";
              ForwardAgent = false;
              HashKnownHosts = false;
              ServerAliveCountMax = 3;
              ServerAliveInterval = 0;
              UserKnownHostsFile = "~/.ssh/known_hosts";
            };
            servers = entryAfter [ "*" ] {
              header = "Host solaire shanalotte radahn";
              Hostname = "%h.sharparam.net";
              User = "sharparam";
              ForwardAgent = true;
              PasswordAuthentication = false;
              VerifyHostKeyDNS = true;
            };
            solaire = entryAfter [ "servers" ] {
              Port = 987;
            };
            shanalotte = entryAfter [ "servers" ] {
              Port = 987;
            };
            radahn = entryAfter [ "servers" ] {
              Port = 987;
            };
            seedbox = {
              Hostname = "ds16999.seedhost.eu";
              Port = 22;
            };
            aur = {
              Hostname = "aur.archlinux.org";
              User = "aur";
            };
            github = {
              header = "Host github gh";
              Hostname = "github.com";
              User = "git";
              PasswordAuthentication = false;
            };
          };
        };
      };
  };
}
