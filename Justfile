copyright := 'Chris Montgomery <chris@cdom.io>'


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
  reuse addheader -l 'CC-BY-SA-4.0' -c '{{copyright}}' {{FILES}}

# Add the project default license header to the specified files
license-gpl +FILES:
  reuse addheader -l 'GPL-3.0-or-later' -c '{{copyright}}' {{FILES}}
