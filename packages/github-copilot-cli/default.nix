{
  lib,
  pkgs,
  stdenv,
  ...
}: let
  version = "0.0.327";
in
  pkgs.buildNpmPackage {
    pname = "github-copilot-cli";
    version = version;
    src = pkgs.fetchzip {
      url = "https://registry.npmjs.org/@github/copilot/-/copilot-${version}.tgz";
      hash = "sha256-BQhYegt4Rqnzd13BCpGD0U0/Ac9WGgryHOt3tptk06s=";
    };

    npmDepsHash = "sha256-zncuZlawjxoA08vyGnmHFVYGvXxgBrAtdeFAonzI90Y=";

    postPatch = ''
      cp ${./package-lock.json} package-lock.json
    '';

    dontNpmBuild = true;

    meta = {
      description = "The power of GitHub Copilot, now in your terminal.";
      homepage = "https://github.com/features/copilot/cli";
      license = lib.licenses.unfree;
      platforms = lib.platforms.all;
      mainProgram = "copilot";
    };
  }
