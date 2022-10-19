{self, ...}: let
  inherit (self.devshellProfiles) common formatters;
in {
  imports = [./profiles];
  perSystem = {inputs', ...}: let
    inherit (inputs'.devshell.legacyPackages) mkShell;
  in {
    devShells.default = mkShell {
      imports = [common formatters];
      name = "nix-flake-template";
    };
  };
}
