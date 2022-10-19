{...}: {
  flake.templates.default = {
    path = ../../.;
    description = ''
      nix-flake-template
    '';
  };
}
