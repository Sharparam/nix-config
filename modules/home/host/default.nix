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
    name = mkOpt (types.nullOr types.str) host "The hostname.";
  };
}
