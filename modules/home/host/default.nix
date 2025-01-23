{
  lib,
  pkgs,
  host ? null,
  format ? "unknown",
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace};
{
  options.${namespace}.host = {
    name = mkOpt (types.nullOr types.str) host "The hostname.";
  };
}
