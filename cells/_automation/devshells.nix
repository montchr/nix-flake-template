# SPDX-FileCopyrightText: 2022-2023 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (inputs.cells) presets;
  l = inputs.nixpkgs.lib // builtins;
  name = "nix-flake-template";
  cats = cell.devshellCategories;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      inherit name;
      nixago = [
        (presets.nixago.commitlint {})
        (presets.nixago.editorconfig {})
        (presets.nixago.lefthook {})
        (presets.nixago.prettier {})
        (presets.nixago.treefmt {})

        (presets.nixago.statix {
          configData = {
            disabled = ["useless_parens"];
          };
        })
      ];
      packages = [
        nixpkgs.deadnix
        nixpkgs.gh
        nixpkgs.reuse
        nixpkgs.statix
        nixpkgs.treefmt
      ];
      commands = [
        {
          package = nixpkgs.reuse;
          category = cats.legal;
        }
        {
          package = nixpkgs.just;
          category = cats.general;
        }
      ];
      imports = [std.std.devshellProfiles.default];
    };
  }
