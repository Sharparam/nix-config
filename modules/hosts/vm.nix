{ __findFile, inputs, ... }:
{
  den.hosts.x86_64-linux.nixos = {
    users.sharparam = { };
  };

  den.aspects.nixos = {
    includes = [
      (<den/tty-autologin> "sharparam")
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.hello
          pkgs.dconf
        ];
        boot.loader.grub.enable = false;
        fileSystems."/".device = "/dev/fake";

        users.users.root.initialPassword = "root";
        users.users.sharparam.initialPassword = "sharparam";
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.vim ];
      };
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.vm = pkgs.writeShellApplication {
        name = "vm";
        text =
          let
            host = inputs.self.nixosConfigurations.nixos.config;
          in
          ''
            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
    };
}
