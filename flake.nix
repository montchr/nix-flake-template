# SPDX-FileCopyrightText: 2022-2023 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  description = "nix-flake-template";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.std.url = "github:divnix/std";
  inputs.std.inputs.nixpkgs.follows = "nixpkgs";

  inputs.dmerge.follows = "std/dmerge";

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
      std.grow.cellsFrom = ./cells;
      std.grow.cellBlocks = with inputs.std.blockTypes; [
        ##: --- public ---

        #: lib
        (functions "functions")
        (nixago "nixago")
        (installables "packages")

        #: presets
        (nixago "nixago")

        ##: --- internal ---

        #: _automation
        (devshells "devshells")
        (data "devshellCategories")
        (nixago "nixago")
      ];
      std.harvest = {
        devShells = [["_automation" "devshells"]];
        packages = [["_automation" "packages"]];
      };
      # FIXME: this is required, but shouldn't be -- needs upstream fix
      # https://github.com/divnix/std/issues/235
      std.grow.nixpkgsConfig = {};
      flake.templates.default = {
        path = ./.;
        description = "nix-flake-template";
      };
      imports = [inputs.std.flakeModule];
    };

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [
      "https://dotfield.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "dotfield.cachix.org-1:b5H/ucY/9PDARWG9uWA87ZKWUBU+hnfF30amwiXiaNk="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
