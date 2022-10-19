# SPDX-FileCopyrightText: 2022 Chris Montgomery
#
# SPDX-License-Identifier: GPL-3.0-or-later

{pkgs, ...}: {
  commands = [
    {
      category = "legal";
      package = pkgs.reuse;
    }
  ];
  packages = [];
  env = [];
}
