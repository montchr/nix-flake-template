# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  description = "nix-flake-template";

  inputs.std.url = "github:divnix/std";
  inputs.std.inputs.nixpkgs.follows = "nixpkgs";
  inputs.std.inputs.mdbook-kroki-preprocessor.follows = "std/blank";

  inputs.dmerge.follows = "std/dmerge";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    std,
    self,
    ...
  } @ inputs: let
    inherit (std) blockTypes growOn harvest;
  in
    growOn {
      inherit inputs;
      cellsFrom = ./cells;
      cellBlocks = [
        ##: --- public ---

        #: lib
        (blockTypes.functions "functions")

        #: presets
        (blockTypes.data "templates")
        (blockTypes.nixago "nixago")

        ##: --- internal ---

        #: _automation
        (blockTypes.devshells "devshells")
        (blockTypes.installables "packages")
        (blockTypes.nixago "nixago")
        (blockTypes.nixago "configs")
      ];
    }
    {
      devShells = harvest self ["_automation" "devshells"];
      packages = harvest self [["_automation" "packages"]];
      templates = harvest self ["core" "templates"];
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
