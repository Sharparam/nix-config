{
  den.aspects.base = {
    homeManager = {
      programs.zellij = {
        enable = true;
        settings = {
          attach_to_session = true;
          session_name = "default";
          plugins = {
            compact-bar = {
              _props = {
                location = "zellij:compact-bar";
              };
              tooltip = "F1";
            };
          };
        };
      };

      home.shellAliases =
        let
          z = "zellij";
        in
        {
          z = z;
          za = "${z} attach";
          zac = "${z} action";
          zd = "${z} delete-session";
          zda = "${z} delete-all-sessions";
          ze = "${z} edit";
          zef = "${z} edit --floating";
          zei = "${z} edit --in-place";
          zk = "${z} kill-session";
          zka = "${z} kill-all-sessions";
          zl = "${z} list-sessions";
          zls = "${z} list-sessions";
          zla = "${z} list-aliases";
          zr = "${z} run";
          zrf = "${z} run --floating";
          zri = "${z} run --in-place";
        };
    };
  };
}
