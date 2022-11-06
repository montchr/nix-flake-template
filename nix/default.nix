# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{self, ...}: let
in {
  imports = [
    ./flake-modules
    ./devshells
    ./formatters
    ./packages
    ./templates
  ];
}
