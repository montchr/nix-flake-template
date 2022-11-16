# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  description = "nix-flake-template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-flake.url = "github:srid/treefmt-flake";
    nixago.url = "github:nix-community/nixago";

    devshell.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    flake-parts,
    treefmt-flake,
    ...
  }: let
    systems = ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux"];
  in
    flake-parts.lib.mkFlake
    {inherit self;}
    {
      inherit systems;
      imports = [
        treefmt-flake.flakeModule
        ./nix
      ];
      flake = {
        project.meta.name = "nix-flake-template";
      };
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
