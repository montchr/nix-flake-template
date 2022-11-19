# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later

copyright := 'Chris Montgomery <chris@cdom.io>'
default-license := 'GPL-3.0-or-later'
docs-license := 'CC-BY-SA-4.0'
public-domain-license := 'CC0-1.0'


##: --- linting ---

# Check for Nix syntax errors
evalnix +FILES:
  nix-instantiate --parse --quiet {{FILES}} >/dev/null

# Format source files
fmt +FILES:
  treefmt --no-cache {{FILES}}

# Format all changed source files
fmt-changed:
  treefmt --no-cache `git diff --name-only --cached`


##: --- licensing ---

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
