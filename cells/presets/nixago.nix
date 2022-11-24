# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{inputs}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std) std;
  inherit (inputs.cells) lib;
  l = inputs.nixpkgs.lib // builtins;
in {
  commitlint = lib.nixago.commitlint {
    configData = import ./nixago/commitlint.nix;
  };
  lefthook = std.nixago.lefthook {
    configData = import ./nixago/lefthook.nix;
  };
  prettier = lib.nixago.prettier {
    configData = import ./nixago/prettier.nix;
  };
  statix = lib.nixago.prettier {
    configData = import ./nixago/statix.nix;
  };
  treefmt = std.nixago.treefmt {
    configData = import ./nixago/treefmt.nix;
    packages = [
      nixpkgs.alejandra
      nixpkgs.nodePackages.prettier
      nixpkgs.nodePackages.prettier-plugin-toml
      nixpkgs.shfmt
    ];
    devshell.startup.prettier-plugin-toml = l.stringsWithDeps.noDepEntry ''
      export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
    '';
  };
}
