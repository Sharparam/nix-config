{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
}:

buildDotnetModule rec {
  pname = "bicep";
  version = "0.43.8";

  src = fetchFromGitHub {
    owner = "Azure";
    repo = "bicep";
    rev = "v${version}";
    hash = "sha256-uQSxoPd4/q3uVGqOe2auigpiQBr2TIznYJcDSrsJ6zA=";
  };

  # patches = [
  #   ./0001-Pin-Grpc.Tools-To-2.68.1.patch
  # ];

  postPatch = ''
    substituteInPlace src/Directory.Build.props --replace-fail "<TreatWarningsAsErrors>true</TreatWarningsAsErrors>" ""
    # Upstream uses rollForward = disable, which pins to an *exact* .NET SDK version.
    # jq '.sdk.rollForward = "latestMinor"' < global.json > global.json.tmp
    # mv global.json.tmp global.json
  '';

  projectFile = [
    "src/Bicep.Cli/Bicep.Cli.csproj"
    "src/Bicep.LangServer/Bicep.LangServer.csproj"
  ];

  nugetDeps = ./deps.json;

  dotnet-sdk = dotnetCorePackages.sdk_10_0_2xx-bin;

  dotnet-runtime = dotnetCorePackages.runtime_10_0;

  # nativeBuildInputs = [ jq ];

  # Tests are currently (2026-05-28) broken
  # see: https://github.com/Azure/bicep/issues/19751
  doCheck = false;

  # dotnetTestFlags = "-p:UseAppHost=false";

  testProjectFile = "src/Bicep.Cli.UnitTests/Bicep.Cli.UnitTests.csproj";

  # passthru.updateScript = ./updater.sh;

  meta = {
    description = "Domain Specific Language (DSL) for deploying Azure resources declaratively";
    homepage = "https://github.com/Azure/bicep/";
    changelog = "https://github.com/Azure/bicep/releases/tag/v${version}";
    license = lib.licenses.mit;
    # maintainers = [ ];
    # teams = [ lib.teams.stridtech ];
    mainProgram = "bicep";
  };
}
