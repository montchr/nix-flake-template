# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  inputs,
  cell,
}: let
  inherit (inputs) dmerge std;
  inherit (inputs.cells) presets;
  l = inputs.nixpkgs.lib // builtins;
  l' = inputs.cells.lib.functions;
  pkgs' = inputs.nixpkgs;
  cats = l'.enumAttrs [
    "maintenance"
  ];
  mergeAll = l.foldl' dmerge.merge {};
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "nix-flake-template";
      nixago = [
        (presets.nixago.commitlint {})
        (presets.nixago.editorconfig {hook.mode = "copy";})
        (presets.nixago.lefthook {})
        (presets.nixago.lint-staged {hook.mode = "copy";})
        (presets.nixago.prettier {})
        (presets.nixago.treefmt {})
      ];
      packages = [
        pkgs'.gh
      ];
      commands = [
        {
          category = cats.maintenance;
          package = pkgs'.reuse;
        }
        {
          category = cats.maintenance;
          package = pkgs'.just;
        }
      ];
      imports = [std.std.devshellProfiles.default];
    };
  }
