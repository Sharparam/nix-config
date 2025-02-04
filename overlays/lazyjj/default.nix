_: final: prev: {
  lazyjj = prev.lazyjj.overrideAttrs (oldAttrs: {
    version = "0.4.3-unstable-2025-01-04";
    src = prev.fetchFromGitHub {
      owner = "misaelaguayo";
      repo = "lazyjj";
      rev = "update-snapshots-jj25";
      hash = "sha256-XRPDs4TwoDgOypLfv5H4V8YdD04Em8xJ3l+ALRngihQ=";
    };
  });
}
