# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later

prj-root := env_var('PRJ_ROOT')

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

# Lint and format files
fmt *FILES=prj-root:
  treefmt --no-cache {{FILES}}

# Write automatic linter fixes to files
lint-fix *FILES=prj-root: (deadnix "fix" FILES) (statix "fix" FILES)

# Run `statix`
statix action +FILES=prj-root:
  @ # Note that stderr is silenced due to an upstream bug
  @ # https://github.com/nerdypepper/statix/issues/59
  @ for f in {{FILES}}; do \
    statix {{action}} -- "$f" 2>/dev/null; \
  done

# Run `deadnix` with sane options
deadnix action +FILES=prj-root:
  @deadnix \
    {{ if action == "fix" { "--edit" } else { "--fail" } }} \
    --no-underscore \
    --no-lambda-pattern-names \
    {{FILES}}


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
