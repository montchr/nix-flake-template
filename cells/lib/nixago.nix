# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}:
builtins.mapAttrs (_: inputs.std.lib.dev.mkNixago) {
  commitlint = import ./nixago/commitlint.nix {inherit inputs cell;};
  lint-staged = import ./nixago/lint-staged.nix {inherit inputs cell;};
  prettier = import ./nixago/prettier.nix {inherit inputs cell;};
}
