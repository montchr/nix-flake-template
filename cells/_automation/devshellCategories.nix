# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  inputs,
  cell,
}:
inputs.cells.lib.functions.enumAttrs [
  "general"
  "legal"
  "maintenance"
]
