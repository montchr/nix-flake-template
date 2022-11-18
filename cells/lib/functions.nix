# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in {
  /*
  Convert a list of strings to an attrset where the keys match the values.

  Example:
    enumAttrs ["foo" "bar"]
    => {foo = "foo"; bar = "bar";}
  */
  enumAttrs = enum: l.genAttrs enum (s: s);
}
