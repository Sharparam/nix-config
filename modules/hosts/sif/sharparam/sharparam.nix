{den, ...}: let
  hostname = "sif";
  username = "sharparam";
  identifier = "${username}@${hostname}";
in {
  den.aspects."${username}".provides."${hostname}" = {
    includes = [
      den.aspects."${identifier}".provides.secrets
    ];
  };
}
