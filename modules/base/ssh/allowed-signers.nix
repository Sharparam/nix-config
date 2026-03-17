let
  path = ".ssh/allowed_signers";
  text = email: key: ''
    sharparam@sharparam.com ${key}
    adam.hellberg@ninetech.com ${key}
  '';
in
{
  den.aspects.ssh.includes = [
    (
      { host, user }:
      {
        homeManager = {
          home.file.${path}.text = text user.email user.ssh.publicKey;
        };
      }
    )
    (
      { home }:
      {
        homeManager = {
          home.file.${path}.text = text home.email home.ssh.publicKey;
        };
      }
    )
  ];
}
