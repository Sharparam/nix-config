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
  optionis.${namespace}.host = {
    name = mkOpt (types.nullOr types.str) host "The hostname.";
  };
}
