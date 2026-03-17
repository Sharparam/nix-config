{
  den.aspects.base.nixos =
    { config, ... }:
    let
      label = config.system.nixos.label or "NixOS";
      rev = config.system.configurationRevision or "<unknown>";
    in
    {
      services.getty = {
        greetingLine = "<<< Welcome to ${label} @ ${rev} - \\l >>>";
      };
    };
}
