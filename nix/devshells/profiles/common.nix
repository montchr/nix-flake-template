# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{pkgs, ...}: {
  commands = [
    {
      category = "tools";
      package = pkgs.yarn;
    }
    {
      category = "tools";
      package = pkgs.reuse;
    }
  ];
  packages = with pkgs; [
    nodejs
  ];
  env = [];
}
