{
  den.aspects.base = {
    homeManager = {
      programs.jujutsu.settings = {
        revsets = {
          bookmark-advance-to = "closest_pushable(@)";
        };
        revset-aliases = {
          "closest_pushable(to)" =
            ''heads(::to & mutable() & ~description(exact:"") & (~empty() | merges()))'';
          "gh_pages()" = ''ancestors(remote_bookmarks(exact:"gh-pages"))'';
          "wip()" = ''description(glob:"wip:*")'';
          "private()" = ''description(glob:"private:*")'';
          "blacklist()" = "wip() | private()";
        };
      };
    };
  };
}
