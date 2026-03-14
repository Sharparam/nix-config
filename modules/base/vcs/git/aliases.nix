{
  den.aspects.base = {
    homeManager = {
      home.shellAliases =
        let
          git = "git";
        in
        {
          # Commented git aliases are provided by Prezto already
          ga = "${git} add";
          # gb = "${git} branch";
          # gca = "${git} commit --verbose --all";
          # gcaS = "${git} commit --verbose --all --gpg-sign";
          # gcam = "${git} commit --all --message";
          # gcamS = "${git} commit --all --message --gpg-sign";
          # gcm = "${git} commit --message";
          # gcmS = "${git} commit --message --gpg-sign";
          gdt = "${git} difftool";
          # gfr = "${git} pull --rebase";
          # gp = "${git} push";
          # gpf = "${git} push --force-with-lease";
          # gpF = "${git} push --force";
          gst = "${git} status";
        };
    };
  };
}
