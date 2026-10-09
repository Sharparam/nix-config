{
  __findFile,
  ...
}:
{
  den.aspects.sif = {
    includes = [
      <programs/tailscale>
    ];

    provides.to-users.includes = [
      <programs/tailscale>
    ];

    nixos = {
      services.tailscale = {
        useRoutingFeatures = "client";
      };
    };
  };
}
