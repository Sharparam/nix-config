{
  lib,
  host ? null,
  namespace,
  ...
}:
{
  options.${namespace}.host =
    let
      inherit (lib) mkOption types;
    in
    {
      name = mkOption {
        type = types.nullOr types.str;
        default = host;
        description = "The hostname.";
      };
    };
}
