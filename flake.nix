{
  description = "nix-flake-template";

  # Enable as needed for bootstrapping. Otherwise these entries cause warnings on every rebuild.
  # nixConfig.extra-experimental-features = "nix-command flakes";
  # nixConfig.extra-substituters = "https://dotfield.cachix.org https://nix-community.cachix.org";
  # nixConfig.extra-trusted-public-keys = "dotfield.cachix.org-1:b5H/ucY/9PDARWG9uWA87ZKWUBU+hnfF30amwiXiaNk= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    nix-std.url = "github:chessai/nix-std";

    devshell.url = "github:numtide/devshell";
    treefmt-flake.url = "github:srid/treefmt-flake";
    nixago.url = "github:nix-community/nixago";
    sops-nix.url = "github:Mic92/sops-nix";

    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.follows = "nixos-unstable";
  };

  outputs = {
    self,
    flake-parts,
    treefmt-flake,
    ...
  }:
    flake-parts.lib.mkFlake
    {inherit self;}
    {
      imports = [
        treefmt-flake.flakeModule
        ./nix
      ];
      systems = ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux"];
    };
}
