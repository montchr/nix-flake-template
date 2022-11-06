# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{self, ...}: {
  flake.devshellProfiles = {
    common = ./common.nix;
  };
}
