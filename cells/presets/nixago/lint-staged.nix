# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{inputs}: let
  l = inputs.nixpkgs.lib // builtins;
in {
  "*" = "treefmt --no-cache --";
  "*.nix" = "just evalnix";
}
