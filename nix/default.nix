{self, ...}: let
in {
  imports = [
    ./flake-modules
    ./devshells
    ./formatters
    ./packages
    ./templates
  ];
}
