# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{inputs}: let
  inherit (inputs) nixpkgs std;
  inherit (inputs.cells) lib presets;
  l = inputs.nixpkgs.lib // builtins;
  l' = inputs.cells.lib.functions;
  cats = l'.enumAttrs [
    "maintenance"
  ];
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "nix-flake-template";
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
            "*" = "treefmt --no-cache --";
            "*.nix" = "just evalnix";
          };
        })
      ];
      packages = [nixpkgs.gh];
      commands = [
        {
          category = cats.maintenance;
          package = nixpkgs.reuse;
        }
        {
          category = cats.maintenance;
          package = nixpkgs.just;
        }
      ];
      imports = [std.std.devshellProfiles.default];
    };
  }
