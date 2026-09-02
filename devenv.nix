{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.dotnet = {
    enable = true;
    package = pkgs.dotnet-sdk_8;
  };

  # https://devenv.sh/scripts/
  scripts.build.exec = "dotnet build";
  scripts.test.exec = "dotnet test";

  # https://devenv.sh/tests/
  enterTest = ''
    dotnet test
  '';

  # See full reference at https://devenv.sh/reference/options/
}
