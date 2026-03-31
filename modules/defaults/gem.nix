{
  # Set some default configs for gem that should always be applied.
  # Even if the system doesn't use gem through the nix config,
  # this will ensure that any manual uses of gem will still get these defaults
  den.default = {
    homeManager = {
      xdg.configFile."gem/gemrc".text = ''
        gem: --no-document --no-ri --no-rdoc
      '';
    };
  };
}
