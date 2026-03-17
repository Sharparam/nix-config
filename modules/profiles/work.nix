{ __findFile, ... }:
{
  den.aspects.work = {
    includes = [
      <dev>

      <apps/azure>
      <apps/slack>
    ];

    darwin = {
      homebrew = {
        casks = [
          "microsoft-auto-update"
          "microsoft-teams"
        ];
        masApps = {
          "Microsoft Outlook" = 985367838;
        };
      };
    };
  };
}
