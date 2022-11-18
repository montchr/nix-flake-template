# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  pkgs' = inputs.nixpkgs;
in {
  configData = {};
  output = ".commitlintrc.json";
  format = "json";
  commands = [
    {
      name = "commitlint";
      package = pkgs'.commitlint;
    }
  ];
}
