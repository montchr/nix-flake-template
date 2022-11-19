{
  inputs,
  cell,
}: {
  lint-staged = inputs.nixpkgs.callPackage ./packages/lint-staged.nix {};
}
