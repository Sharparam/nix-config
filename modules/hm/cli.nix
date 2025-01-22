{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  home.stateVersion = lib.mkDefault "24.11";
  home.packages = with pkgs; [
    my.scripts
    aria2
    bat
    curl
    direnv
    fd
    git
    htop
    hyfetch
    neofetch
    jq
    ripgrep
    yt-dlp
  ];

  programs = {
    bat = {
      enable = true;
    };

    git = {
      enable = true;
      lfs.enable = true;

      extraConfig = {
        user.name = "Adam Hellberg";
        user.email = "sharparam@sharparam.com";
        pull.ff = "only";
      };
    };

    htop = {
      enable = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
    gb = "git branch";
    gca = "git commit --verbose --all";
    gcaS = "git commit --verbose --all --gpg-sign";
    gcam = "git commit --all --message";
    gcamS = "git commit --all --message --gpg-sign";
    gcm = "git commit --message";
    gcmS = "git commit --message --gpg-sign";
    gfr = "git pull --rebase";
    gp = "git push";
    gpf = "git push --force-with-lease";
    gpF = "git push --force";
  };
}
