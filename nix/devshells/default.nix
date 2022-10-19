{self, ...}: let
  inherit (self.devshellProfiles) formatters;
in {
  perSystem = {inputs', ...}: let
    inherit (inputs'.devshell.legacyPackages) mkShell;
  in {
    devShells.default = mkShell {
      imports = [formatters];
      name = "nix-flake-template";
    };
  };
}
