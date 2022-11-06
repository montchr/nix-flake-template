// SPDX-FileCopyrightText: 2022 Temple University
//
// SPDX-License-Identifier: GPL-3.0-or-later

import path from 'path'

export default {
  '*': 'nix run nixpkgs#treefmt -- --no-cache',
}
