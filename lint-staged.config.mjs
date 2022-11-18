// SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
// SPDX-License-Identifier: GPL-3.0-or-later

/** Extensions for text documentation filetypes. */
const docExts = ['md', 'org', 'txt'].join('|')

export default {
  [`*.!(${docExts})`]: 'just license-gpl',
  [`*.@(${docExts})`]: 'just license-cc',
  '*.nix':
    'nix eval --no-update-lock-file --no-write-lock-file --no-warn-dirty --accept-flake-config',
}
