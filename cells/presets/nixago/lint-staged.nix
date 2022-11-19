# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{inputs}: let
  l = inputs.nixpkgs.lib // builtins;
  docExts = l.concatStringsSep "|" ["md" "org" "txt"];
in {
  "*" = "treefmt --no-cache --";
  "*.!(${docExts})" = "just license-gpl --skip-unrecognised";
  "*.@(${docExts})" = "just license-cc --skip-unrecognised";
  "*.nix" = "just evalnix";
}
