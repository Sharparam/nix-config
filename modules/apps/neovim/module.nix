{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;

  flake-file.inputs.nvf = {
    url = "github:NotAShelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  substituters = [
    "https://nvf.cachix.org"
  ];

  trusted-public-keys = [
    "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
  ];

  nix.settings = {
    inherit substituters trusted-public-keys;
  };

  nvf = {
    enable = mkDefault true;
    settings = {
      vim = {
        viAlias = mkDefault true;
        vimAlias = mkDefault true;

        autopairs.nvim-autopairs.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        comments.comment-nvim.enable = true;

        filetree.neo-tree.enable = true;

        notify.nvim-notify.enable = true;

        snippets.luasnip.enable = true;

        statusline.lualine = {
          enable = true;
        };

        tabline.nvimBufferline.enable = true;

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          smartcolumn = {
            enable = true;
          };
        };

        utility = {
          motion = {
            leap.enable = true;
          };
        };

        visuals = {
          indent-blankline.enable = true;
          nvim-cursorline.enable = true;
        };
      };
    };
  };

  sessionVariables = {
    EDITOR = mkDefault "nvim";
    VISUAL = mkDefault "nvim";
  };

  aliases = {
    vimdiff = "nvim -d";
  };

  os = { inherit nix; };

  homeManager = {
    inherit nix;

    imports = [ inputs.nvf.homeManagerModules.default ];

    home = {
      inherit sessionVariables;
      shellAliases = aliases;
    };

    systemd.user.sessionVariables = sessionVariables;

    programs = { inherit nvf; };
  };

  den.aspects.apps.provides.neovim = {
    inherit os homeManager;
  };
in
{
  inherit flake-file den;
}
