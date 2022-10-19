{self, ...}: {
  flake.devshellProfiles = {
    common = ./common.nix;
  };
}
