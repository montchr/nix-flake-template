# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  # FIXME: should probably relocate this package to the current cell
  inherit (inputs.cells) _automation;
in {
  configData = {};
  output = ".lintstagedrc.json";
  format = "json";
  packages = [_automation.packages.lint-staged];
}
