{
  den.aspects.base = {
    homeManager = { config, pkgs, ... }: {
      home.packages = [
        pkgs.oyui
      ];

      xdg.configFile."oyui/config.rn".source = pkgs.replaceVars ./config.rn {
        catppuccin-flavor = config.catppuccin.flavor;
      };

      programs.jujutsu.settings = {
        ui = {
          diff-editor = "oyui";
          diff-instructions = false;
        };

        merge-tools.oyui = {
          program = "oyui";
          edit-args = [
            "diff"
            "$left"
            "$right"
          ];
        };
      };
    };
  };
}
