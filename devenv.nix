{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.dotnet = {
    enable = true;
    package = pkgs.dotnet-sdk_10;
  };

  # https://devenv.sh/scripts/
  scripts.build.exec = "dotnet build";
  scripts.test.exec = "dotnet test";

  # https://devenv.sh/tests/
  enterTest = ''
    dotnet test
  '';

  # Stable, project-relative symlink to the SDK root pinned in
  # languages.dotnet above, recreated on every shell entry. Rider cannot
  # resolve $DOTNET_ROOT, so its "dotnet CLI executable path" setting points
  # at <repo>/.nix-tools/dotnet/dotnet instead of a /nix/store path that goes
  # stale on every SDK update.
  enterShell = ''
    mkdir -p "${config.devenv.root}/.nix-tools"
    ln -sfn "${config.languages.dotnet.package}/share/dotnet" "${config.devenv.root}/.nix-tools/dotnet"
  '';

  # See full reference at https://devenv.sh/reference/options/
}
