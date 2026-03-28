{ __findFile, ... }:
{
  den.aspects.dev = {
    includes = [
      <programs/ast-grep>
      <programs/atuin-desktop>
      <programs/codespelunker>
      <programs/emacs>
      # <programs/jetbrains-rider>
      <programs/jetbrains-toolbox>
      <programs/just>
      <programs/linqpad>
      <programs/mise>
      <programs/neovim>
      <programs/podman>
      <programs/postman>
      <programs/scc>
      <programs/sublime-merge>
      <programs/tokei>
      <programs/uv>
      # <programs/vscode> # Handle this manually for now
    ];
  };
}
