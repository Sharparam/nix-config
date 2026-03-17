{
  den.aspects.base = {
    homeManager = {
      programs.jujutsu.settings = {
        templates = {
          commit_trailers = ''
            format_signed_off_by_trailer(self)
            ++ if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))
          '';
          draft_commit_description = ''
            concat(
              coalesce(description, default_commit_description, "\n"),
              surround(
                "\nJJ: This commit contains the following changes:\n", "",
                indent("JJ:     ", diff.stat(72)),
              ),
              "\nJJ: ignore-rest\n",
              diff.git(),
            )
          '';
          git_push_bookmark = ''"sharparam/push-" ++ change_id.short()'';
        };
        template-aliases = {
          "format_short_signature(sig)" =
            ''"<" ++ if(sig.email(), sig.email(), label("text warning", "NO EMAIL")) ++ ">"'';
          "format_short_cryptographic_signature(sig)" = ''
            if(sig, sig.status(), "(no sig)")
          '';
        };
      };
    };
  };
}
