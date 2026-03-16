{
  den.aspects.base.includes = [
    (
      { host, user }:
      {
        homeManager =
          { lib, ... }:
          {
            programs.git = {
              signing.key = lib.mkIf (user.git.signingKey != null) user.git.signingKey;
            };
          };
      }
    )
    (
      { home }:
      {
        homeManager =
          { lib, ... }:
          {
            programs.git = {
              signing.key = lib.mkIf (home.git.signingKey != null) home.git.signingKey;
            };
          };
      }
    )
  ];
}
