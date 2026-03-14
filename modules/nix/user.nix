{
  den.aspects = {
    nix-allowed-user =
      { host, user, ... }:
      {
        ${host.class}.nix.settings.allowed-users = [ user.userName ];
      };

    nix-trusted-user =
      { host, user, ... }:
      {
        ${host.class}.nix.settings.trusted-users = [ user.userName ];
      };
  };
}
