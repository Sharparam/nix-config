{
  projectRootFile = "flake.nix";

  programs = {
    # Nix
    alejandra.enable = true;
    deadnix.enable = true;
    statix.enable = true;
  };

  settings = {
    global.excludes = [
      "*.editorconfig"
      "*.envrc"
      "*.git-blame-ignore-revs"
      "*.gitattributes"
      "*.gitconfig"
      "*.gitignore"
      "*.gitmodules"
      "*CODEOWNERS"
      "*LICENSE"
      "*flake.lock"
      "*.svg"
    ];
  };
}
