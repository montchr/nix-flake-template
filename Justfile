# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later

icon-ok := '✔'
msg-ok := icon-ok + " OK"
msg-done := icon-ok + " Done"

copyright := 'Chris Montgomery <chris@cdom.io>'
default-license := 'GPL-3.0-or-later'
docs-license := 'CC-BY-SA-4.0'
public-domain-license := 'CC0-1.0'

cachix-cache-name := 'nix-flake-template'
cachix-exec := "cachix watch-exec --jobs 2 " + cachix-cache-name


###: LINTING/FORMATTING ========================================================

# Format source files
fmt *FILES="$PRJ_ROOT":
  treefmt --no-cache \
    --config-file $PRJ_ROOT/treefmt.toml \
    --tree-root $PRJ_ROOT \
    {{FILES}}

# Write automatic linter fixes to source files
fix *FILES="$PRJ_ROOT":
  treefmt --no-cache \
    --config-file $PRJ_ROOT/treefmt.lint-fix.toml \
    --tree-root $PRJ_ROOT \
    {{FILES}}

# Prune dead code from project files
prune *FILES="$PRJ_ROOT":
  deadnix --edit "{{FILES}}"


###: LICENSING =================================================================

# Add the project default license header to the specified files
alias license := license-gpl

# Validate the project's licensing and copyright info
license-check:
  reuse lint

# Add a GPL-3.0-or-later license header to the specified files
license-gpl +FILES:
  reuse addheader -l {{default-license}} -c '{{copyright}}' {{FILES}}

# Add a CC-BY-SA-4.0 license header to the specified files
license-cc +FILES:
  reuse addheader -l {{docs-license}} -c '{{copyright}}' {{FILES}}

# Add a public domain CC0-1.0 license header to the specified files
license-public-domain +FILES:
  reuse addheader -l {{public-domain-license}} -c '{{copyright}}' {{FILES}}
