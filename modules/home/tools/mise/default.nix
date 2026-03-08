{
  lib,
  config,
  ...
}:
let
  cfg = config.snix.tools.mise;
in
{
  options.snix.tools.mise = {
    enable = lib.mkEnableOption "mise";
  };

  config = lib.mkIf cfg.enable {
    programs.mise = {
      enable = true;
      globalConfig = {
        tools = {
          usage = "latest";
        };
        settings = {
          # idiomatic_version_file_enable_tools = [
          #   "bun"
          #   "deno"
          #   "dotnet"
          #   "go"
          #   "java"
          #   "node"
          #   "npm"
          #   "pnpm"
          #   "python"
          #   "ruby"
          #   "yarn"
          # ];
        };
      };
      settings = {
        experimental = true;
      };
    };
  };
}
