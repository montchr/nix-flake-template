# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
{
  commit-msg = {
    commands = {
      commitlint = {
        run = ''
          # allow WIP, fixup!/squash! commits locally
          [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] \
            || commitlint --edit {1}
        '';
        skip = ["merge" "rebase"];
      };
    };
  };
  pre-commit = {
    parallel = false;
    commands = {
      lint-staged = {
        run = "lint-staged {staged_files}";
        skip = ["merge" "rebase"];
      };
      treefmt = {
        run = "treefmt --fail-on-change {staged_files}";
        skip = [
          "merge"
          "rebase"
        ];
      };
    };
  };
}
