{
  lib,
  host ? null,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  options.${namespace}.host = {
    name = mkOption {
      type = types.nullOr types.str;
      default = host;
      description = "The hostname.";
    };
  };
}
