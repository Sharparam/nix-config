{
  programs.jetbrains-rider = {
    darwin =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.jetbrains.rider
        ];
      };
  };
}
