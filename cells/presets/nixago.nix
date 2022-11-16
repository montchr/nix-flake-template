{
  inputs,
  cell,
}: let
  inherit (inputs.std) std;
  inherit (inputs.cells) lib presets;
  l = inputs.nixpkgs.lib // builtins;
  pkgs' = inputs.nixpkgs;
in {
  commitlint = lib.nixago.commitlint {
    configData = import ./nixago/commitlint.nix;
  };
  editorconfig = std.nixago.editorconfig {
    configData = import ./nixago/editorconfig.nix;
  };
  lefthook = std.nixago.lefthook {
    configData = import ./nixago/lefthook.nix;
  };
  prettier = lib.nixago.prettier {
    configData = import ./nixago/prettier.nix;
  };
  treefmt = std.nixago.treefmt {
    configData = import ./nixago/treefmt.nix;
    packages = [
      pkgs'.alejandra
      pkgs'.nodePackages.prettier
      pkgs'.nodePackages.prettier-plugin-toml
      pkgs'.shfmt
    ];
    devshell.startup.prettier-plugin-toml = l.stringsWithDeps.noDepEntry ''
      export NODE_PATH=${pkgs'.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
    '';
  };
}