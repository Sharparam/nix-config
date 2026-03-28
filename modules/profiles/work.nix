{ __findFile, ... }:
{
  den.aspects.work = {
    includes = [
      <programs/azure>
      <programs/slack>
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
