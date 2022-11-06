# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  config,
  self,
  lib,
  flake-parts-lib,
  ...
}: let
  inherit (flake-parts-lib) mkSubmoduleOptions;
  l = lib // builtins;
in {
  options = {
    flake = mkSubmoduleOptions {
      devshellProfiles = l.mkOption {
        type = l.types.lazyAttrsOf l.types.unspecified;
        default = {};
        apply = l.mapAttrs (k: v: {
          _file = "${toString self.outPath}/flake.nix#devshellProfiles.${k}";
          imports = [v];
        });
        description = ''
          Modules with side-effects importable by <numtide/devshell>.
        '';
      };
    };
  };
}
