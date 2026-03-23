{ __findFile, ... }:
{
  den.aspects.base.includes = [
    <ssh>

    <apps/atuin-desktop>
    <apps/discord>
    <apps/ghostty>
    <apps/kde-connect>
    # <apps/kitty>
    <apps/obs>
    <apps/signal>
    <apps/spotify>
    <apps/telegram>
  ];
}
