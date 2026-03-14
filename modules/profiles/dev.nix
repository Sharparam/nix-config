{ __findFile, ... }:
{
  den.aspects.dev = {
    includes = [
      <apps/ast-grep>
      <apps/atuin-desktop>
      <apps/codespelunker>
      <apps/emacs>
      # <apps/jetbrains-rider>
      <apps/jetbrains-toolbox>
      <apps/just>
      <apps/linqpad>
      <apps/mise>
      <apps/neovim>
      <apps/podman>
      <apps/postman>
      <apps/scc>
      <apps/sublime-merge>
      <apps/tokei>
      <apps/uv>
      <apps/vscode>
    ];
  };
}
