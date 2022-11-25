# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in
  l.mapAttrs (_: inputs.std.lib.dev.mkNixago) {
    treefmt-lint-fix = {
      configData = import ./nixago/treefmt.lint-fix.nix;
      output = "treefmt.lint-fix.toml";
      packages = [
        nixpkgs.statix
        nixpkgs.treefmt
        nixpkgs.nodePackages.eslint
      ];
    };
  }
