# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  self,
  getSystem,
  ...
}: {
  imports = [
    ./nixagoFiles/prettierrc.json.nix
  ];
  perSystem = {pkgs, ...}: {
    treefmt.formatters = {
      inherit (pkgs) alejandra shellcheck shfmt;
      inherit (pkgs.nodePackages) prettier;
    };
  };
  flake.devshellProfiles.formatters = {pkgs, ...}: {
    commands = [
      {
        name = "format";
        help = "format files with treefmt";
        category = "formatters";
        command = ''
          ${pkgs.treefmt}/bin/treefmt --no-cache -- $@
        '';
      }
    ];
    packages =
      (getSystem pkgs.system).treefmt.buildInputs
      ++ (with pkgs; [
        editorconfig-checker
      ]);
  };
}
