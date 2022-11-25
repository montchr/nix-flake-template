# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  # TODO: can nix version be omitted or determined automatically?
  nix_version = "2.11";
  ignore = [
    ".direnv"
    ".std"
    "_sources/*.nix"
  ];
}