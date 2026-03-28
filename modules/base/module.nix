{ __findFile, ... }:
{
  den.aspects.base.includes = [
    <ssh>

    <programs/atuin-desktop>
    <programs/discord>
    <programs/ghostty>
    <programs/kde-connect>
    # <programs/kitty>
    <programs/obs>
    <programs/signal>
    <programs/spotify>
    <programs/telegram>
  ];
}
