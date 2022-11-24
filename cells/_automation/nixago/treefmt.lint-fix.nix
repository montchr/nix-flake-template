# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  formatter = {
    nix = {
      command = "sh";
      options = [
        "-eucx"
        ''
          for f in "$@"; do
            statix fix -- "$f"
          done
          deadnix --edit "$@"
        ''
        "--"
      ];
      includes = ["*.nix"];
      excludes = [
        "_sources/*.nix"
      ];
    };
    eslint = {
      command = "eslint";
      includes = ["*.js" "*.jsx" "*.ts" "*.tsx"];
      options = ["--fix"];
    };
  };
}
