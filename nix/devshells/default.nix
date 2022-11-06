# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{self, ...}: let
  inherit (self) project;
  inherit
    (self.devshellProfiles)
    common
    formatters
    nixago-setup-hook
    ;
in {
  imports = [./profiles];
  perSystem = {inputs', ...}: let
    inherit (inputs'.devshell.legacyPackages) mkShell;
  in {
    devShells.default = mkShell {
      inherit (project.meta) name;
      imports = [
        common
        formatters
        nixago-setup-hook
      ];
    };
  };
}
