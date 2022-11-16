{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  pkgs' = inputs.nixpkgs;
in {
  configData = {};
  output = ".commitlintrc.json";
  format = "json";
  commands = [
    {
      name = "commitlint";
      package = pkgs'.commitlint;
    }
  ];
}
