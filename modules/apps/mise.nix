{
  den.aspects.apps.provides.mise = {
    homeManager = {
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
          settings = {
            experimental = true;
          };
        };
      };
    };
  };
}
