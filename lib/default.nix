{
  lib,
  flake,
}: let
  inherit (lib) makeExtensible attrValues foldr;
  l = makeExtensible (self: {});
in
  # for convenience, provide all namespaced functions at the top level,
  # following the example of `nixpkgs.lib`.
  (l.extend
    (lfinal: lprev: (foldr
      (a: b: a // b) {} (attrValues lprev))))
