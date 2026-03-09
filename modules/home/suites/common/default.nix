{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = {
    enable = mkEnableOption "Whether or not to enable the common configuration.";
  };

  config = mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = "frappe";

      nvim.enable = false;

      # We manage this manually to ensure correct load order
      zsh-syntax-highlighting.enable = false;
    };

    ${namespace} = {
      security = {
        gpg.enable = true;
      };

      dotfiles.enable = true;
      fonts.enable = pkgs.stdenv.isLinux;

      apps = {
        kitty.enable = true;
        neovim.enable = true;
      };

      tools = {
        home-manager.enable = true;
        comma.enable = true;
        aria2.enable = true;
        asciinema.enable = true;
        atuin.enable = true;
        bat.enable = true;
        curl.enable = true;
        direnv.enable = true;
        duf.enable = true;
        fd.enable = true;
        ffmpeg.enable = true;
        fzf.enable = true;
        git.enable = true;
        htop.enable = true;
        hyfetch.enable = true;
        jq.enable = true;
        lsd.enable = true;
        powershell.enable = true;
        ripgrep.enable = true;
        rsync.enable = true;
        ssh.enable = true;
        starship.enable = true;
        tmux.enable = true;
        yt-dlp.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
    };
  };
}
