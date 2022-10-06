{
  description = "nix-flake-template";

  # Enable as needed for bootstrapping. Otherwise these entries cause warnings on every rebuild.
  # nixConfig.extra-experimental-features = "nix-command flakes";
  # nixConfig.extra-substituters = "https://dotfield.cachix.org https://nix-community.cachix.org";
  # nixConfig.extra-trusted-public-keys = "dotfield.cachix.org-1:b5H/ucY/9PDARWG9uWA87ZKWUBU+hnfF30amwiXiaNk= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-trunk.url = "github:NixOS/nixpkgs/master";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    nix-std.url = "github:chessai/nix-std";

    devshell.url = "github:numtide/devshell";
    nixago.url = "github:nix-community/nixago";
    sops-nix.url = "github:Mic92/sops-nix";

    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.follows = "nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-unstable,
    flake-parts,
    flake-utils,
    nix-std,
    ...
  }: let
    supportedSystems = with flake-utils.lib.system; [
      x86_64-linux
      x86_64-darwin
      aarch64-darwin
    ];

    lib = nixos-unstable.lib.extend (lfinal: lprev: {
      std = nix-std;
      eso = import ./lib {
        inherit peers;
        flake = self;
        lib = lfinal;
      };
    });
  in (flake-parts.lib.mkFlake {inherit self;} {
    systems = supportedSystems;
    imports = [
      ./devShells
      ./overlays
      ./packages
    ];
    perSystem = {system, ...}: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          self.overlays.externalPackages
          (final: prev: {inherit lib;})
          self.overlays.packages
          self.overlays.iosevka
          self.overlays.firefox-addons
          self.overlays.overrides
        ];
      };
    in {
      _module.args.pkgs = pkgs;
      formatter = pkgs.alejandra;
    };
    flake = {
      lib = lib.eso;
    };
  });
}
