{
  inputs,
  cell,
}:
builtins.mapAttrs (_: inputs.std.lib.dev.mkNixago) {
  commitlint = import ./nixago/commitlint.nix {inherit inputs cell;};
  prettier = import ./nixago/prettier.nix {inherit inputs cell;};
}
