{ lib, ... }:
let
  inherit (lib) mkDefault;

  nvf = {
    settings.vim = {
      lsp = {
        enable = mkDefault true;
        formatOnSave = mkDefault true;
      };
      syntaxHighlighting = true;
      treesitter = {
        enable = true;
        context.enable = true;
      };

      languages = {
        enableFormat = mkDefault true;
        enableTreesitter = mkDefault true;

        astro.enable = true;
        bash.enable = true;
        csharp.enable = true;
        css.enable = true;
        elixir.enable = true;
        fsharp.enable = true;
        gleam.enable = true;
        go.enable = true;
        haskell.enable = true;
        html.enable = true;
        java.enable = true;
        json.enable = true;
        just.enable = true;
        kotlin.enable = true;
        lua.enable = true;
        make.enable = true;
        markdown.enable = true;
        nix.enable = true;
        nu.enable = true;
        php.enable = true;
        # python.enable = true;
        ruby.enable = true;
        rust.enable = true;
        sql.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
        terraform.enable = true;
        toml.enable = true;
        ts.enable = true;
        typst.enable = true;
        yaml.enable = true;
        xml.enable = true;
        zig.enable = true;
      };
    };
  };
in
{
  den.aspects.apps.provides.neovim = {
    homeManager.programs = { inherit nvf; };
  };
}
