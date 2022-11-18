# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs.std) std;
  inherit (inputs.cells) lib presets;
  l = inputs.nixpkgs.lib // builtins;
  pkgs' = inputs.nixpkgs;
in {
  commitlint = presets.nixago.commitlint {};
  editorconfig = presets.nixago.editorconfig {
    hook.mode = "copy";
  };
  lefthook = presets.nixago.lefthook {};
  prettier = presets.nixago.prettier {};
  treefmt = presets.nixago.treefmt {};
}
