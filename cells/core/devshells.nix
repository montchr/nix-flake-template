# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs) cells std;
  l = inputs.nixpkgs.lib // builtins;
  l' = inputs.cells.lib.functions;
  pkgs' = inputs.nixpkgs;
  cats = l'.enumAttrs [
    "maintenance"
  ];
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "nix-flake-template";
      nixago = [
        cell.configs.commitlint
        cell.configs.editorconfig
        cell.configs.just
        cell.configs.lefthook
        cell.configs.lint-staged
        cell.configs.prettier
        cell.configs.treefmt
        cells.reuse.configs.just
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
          name = "fmt";
          command = "treefmt src";
          help = "Formats the project files";
          category = cats.maintenance;
        }
      ];
      imports = [std.std.devshellProfiles.default];
    };
  }
