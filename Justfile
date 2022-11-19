copyright := 'Chris Montgomery <chris@cdom.io>'
default-license := 'GPL-3.0-or-later'
docs-license := 'CC-BY-SA-4.0'


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

# Add a CC-BY-SA-4.0 license header to the specified files
license-cc +FILES:
  reuse addheader -l {{docs-license}} -c '{{copyright}}' {{FILES}}

# Add the project default license header to the specified files
license-gpl +FILES:
  reuse addheader -l {{default-license}} -c '{{copyright}}' {{FILES}}
