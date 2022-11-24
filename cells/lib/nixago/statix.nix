# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{inputs}: {
  output = "statix.toml";
  format = "toml";
  configData = {};
  packages = [inputs.nixpkgs.statix];
}
