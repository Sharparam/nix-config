{
  description = "Sharparam's Nix files";

  inputs = {
    utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      utils,
      nixpkgs,
      nixpkgs-unstable,
      lix-module,
      darwin,
      home-manager,
      ...
    }:
    let
      lib = nixpkgs.lib.extend (
        self: super: {
          my = import ./lib {
            inherit inputs;
            lib = self;
          };
        }
      );
      overlays = [
        self.overlays.default
      ];
      genPkgsWithOverlays =
        system:
        import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

      rev = if (lib.hasAttrByPath [ "rev" ] self.sourceInfo) then self.sourceInfo.rev else "Dirty Build";

      nixosSystem =
        system: extraModules: hostName:
        let
          pkgs = genPkgsWithOverlays system;
        in
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = { inherit lib inputs; };
          modules = [
            lix-module.nixosModules.default
            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              lib.mkMerge [
                {
                  nixpkgs.pkgs = pkgs;
                  nixpkgs.overlays = overlays;
                  networking.hostName = hostName;
                  system.configurationRevision = rev;
                  services.getty.greetingLine = "<<< Welcome to ${config.system.nixos.label} @ ${rev} - \\l >>>";
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs; };
                  };
                }
              ]
            )
            ./common/nixos.nix
          ] ++ extraModules;
        };
      processConfigurations = lib.mapAttrs (n: v: v n);
    in
    {
      lib = lib.my;
      overlays.default = final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.system;
          config.allowUnfree = true;
        };
        my = self.packages."${prev.system}";
      };
      nixosConfigurations = processConfigurations {
        nixos = nixosSystem "x86_64-linux" [ ./hosts/nixos/default.nix ];
      };
    }
    // utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt ];
        };
        packages = lib.my.mapModules ./packages (p: pkgs.callPackage p { inputs = inputs; });
      }
    );
}
