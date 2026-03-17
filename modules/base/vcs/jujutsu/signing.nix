{
  den.aspects.base.includes = [
    (
      { host, user }:
      {
        homeManager =
          { lib, ... }:
          {
            programs.jujutsu.settings.signing.key = lib.mkIf (
              user.jujutsu.signingKey != null
            ) user.jujutsu.signingKey;
          };
      }
    )
    (
      { home }:
      {
        homeManager =
          { lib, ... }:
          {
            programs.jujutsu.settings.signing.key = lib.mkIf (
              home.jujutsu.signingKey != null
            ) home.jujutsu.signingKey;
          };
      }
    )
  ];
}
