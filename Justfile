# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later

###: https://just.systems/man/en/

default:
  @just --list --unsorted --color=always | rg -v "    default"

##: feedback
icon-ok := '✔'
msg-ok := icon-ok + " OK"
msg-done := icon-ok + " Done"

##: legal/reuse
copyright := 'Chris Montgomery <chris@cdom.io>'
default-license := 'GPL-3.0-or-later'
docs-license := 'CC-BY-SA-4.0'
public-domain-license := 'CC0-1.0'

##: binary cache
cachix-cache-name := 'nix-flake-template'
cachix-exec := "cachix watch-exec --jobs 2 " + cachix-cache-name

##: directories/paths
prj-root := env_var('PRJ_ROOT')
# TODO: use env var for prj name?
prj-name := 'nix-flake-template'
# `package.json` runnables
export PATH := "./node_modules/.bin:" + env_var('PATH')


###: LINTING/FORMATTING ========================================================

# <- Lint files
lint *FILES=prj-root: (deadnix "check" FILES) (statix "check" FILES)

# Lint and format files
fmt *FILES=prj-root:
  treefmt --no-cache {{FILES}}

# Write automatic linter fixes to files
lint-fix *FILES=prj-root: (deadnix "fix" FILES) (statix "fix" FILES)

# <- Run `statix`
[private]
statix action +FILES=prj-root:
  @ # Note that stderr is silenced due to an upstream bug
  @ # https://github.com/nerdypepper/statix/issues/59
  @ for f in {{FILES}}; do \
    statix {{action}} -- "$f" 2>/dev/null; \
  done

# <- Run `deadnix` with sane options
[private]
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

###: BOOTSTRAPPING =================================================================

# TODO: run automatically on first init somehow
_rename-on-init name:
  mv .vscode/{{prj-name}}.code-snippets .vscode/{{name}}.code-snippets
  mv .vscode/{{prj-name}}.code-workspace .vscode/{{name}}.code-workspace
  fd --type file --hidden \
    -E '.git' -E '.direnv' -E 'node_modules' -E '.std' \
    . --exec-batch sd {{prj-name}} {{name}} {}
