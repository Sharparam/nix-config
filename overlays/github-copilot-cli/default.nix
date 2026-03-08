{ channels, ... }:
_final: _prev: {
  inherit (channels.unstable) github-copilot-cli;
}
