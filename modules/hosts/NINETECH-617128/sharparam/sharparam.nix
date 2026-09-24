{ den, ... }:
let
  hostname = "NINETECH-617128";
  username = "sharparam";
  identifier = "${username}@${hostname}";
in
{
  den.aspects."${username}".provides."${hostname}" = {
    includes = [
      den.aspects."${identifier}".provides.secrets
    ];
  };
}
