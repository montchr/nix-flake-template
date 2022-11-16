{
  inputs,
  cell,
}: let
  pkgs' = inputs.nixpkgs;
in {
  output = ".prettierrc.json";
  configData = {};
  format = "json";
  packages = [pkgs'.nodePackages.prettier];
}
