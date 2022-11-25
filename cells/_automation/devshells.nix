# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (inputs.cells) lib presets;
  l = inputs.nixpkgs.lib // builtins;
  name = "nix-flake-template";
  cats = cell.devshellCategories;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      inherit name;
      nixago = [
        (presets.nixago.commitlint {})
        (presets.nixago.lefthook {})
        (presets.nixago.prettier {})
        (presets.nixago.treefmt {})

        (presets.nixago.statix {
          configData = {
            disabled = ["useless_parens"];
          };
        })

        (lib.nixago.lint-staged {
          hook.mode = "copy";
          configData = {
            "*" = ["just fix" "just fmt"];
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
