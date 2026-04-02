{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  flake-file.inputs.sops-nix = {
    url = mkDefault "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = mkDefault "nixpkgs";
  };

  den.default = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.sops ];

        sops = {
          age = {
            sshKeyPaths = mkDefault [
              "/etc/ssh/ssh_host_ed25519_key"
            ];
          };

          defaultSopsFile = ./secrets.yaml;
          validateSopsFiles = true;

          secrets = {
            hello = { };
          };
        };
      };

    nixos = {
      imports = [ inputs.sops-nix.nixosModules.sops ];
    };

    darwin = {
      imports = [ inputs.sops-nix.darwinModules.sops ];
    };

    homeManager =
      { config, pkgs, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        home.packages = [ pkgs.sops ];

        sops = {
          age = {
            keyFile = mkDefault "${config.xdg.configHome}/sops/age/keys.txt";
            generateKey = false;
          };

          defaultSopsFile = ./secrets.yaml;
          validateSopsFiles = true;

          secrets = {
            hello = { };
            ssh-host-siegward = {
              path = "${config.home.homeDirectory}/.ssh/config.d/10-siegward";
            };
            ssh-hosts-sol = {
              path = "${config.home.homeDirectory}/.ssh/config.d/99-sol";
            };
          };
        };
      };
  };
}
