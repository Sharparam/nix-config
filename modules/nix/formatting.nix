{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  flake-file.inputs.treefmt-nix = {
    url = lib.mkDefault "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  perSystem =
    { self', ... }:
    {
      packages.fmt = self'.formatter;
      treefmt = {
        projectRoot = inputs.flake-file;
        programs = {
          nixfmt.enable = true;
          deadnix = {
            enable = true;
            no-underscore = true;
          };
          statix.enable = true;
          # nixf-diagnose.enable = true;

          biome.enable = true;
          # jsonfmt.enable = true;
          just.enable = true;
          # prettier.enable = true;
          shellcheck.enable = true;
          shfmt.enable = true;
          yamlfmt.enable = true; # Not supported by Biome yet
        };
        settings = {
          on-unmatched = "fatal";
          excludes = [
            ".editorconfig"
            #   "*/.editorconfig"
            #   "*/.envrc"

            # Git
            "*/.git-blame-ignore-revs"
            "*/.gitattributes"
            "*/.gitconfig"
            "*/.gitignore"
            "*/.gitmodules"

            # Repo
            "*/CODEOWNERS"
            "*/LICENSE"
            #   "*/FUNDING.yml"

            "*.txt"
            "*.md"
            "*.mdx"

            # Generic config files
            "*.conf"
            "*.toml"

            # Shell
            ".shellcheckrc"
            "*.zsh"

            # Nix
            "flake.nix"
            "*/flake.lock"
            "modules/*"
            "dev/*"
            "docs/*"
            "templates/*"

            # Age
            "*.age"

            # GPG/PGP
            "*.asc"
            "*.pub"

            # Web stuff
            "*.astro"

            # Images
            "*.png"
            "*.jpg"
            "*.jpeg"
            "*.svg"
            "*.webp"
          ];
        };
      };
    };
}
