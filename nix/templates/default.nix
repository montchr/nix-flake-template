# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{...}: {
  flake.templates.default = {
    path = ../../.;
    description = ''
      nix-flake-template
    '';
  };
}
