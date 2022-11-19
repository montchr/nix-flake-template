copyright := 'Chris Montgomery <chris@cdom.io>'


##: --- linting ---

# Check for Nix syntax errors
evalnix file:
    nix-instantiate --parse --quiet {{file}} >/dev/null

# Format all changed source files
fmt:
    treefmt `git diff --name-only --cached`


##: --- licensing ---

# Add a CC-BY-SA-4.0 license header to the specified files
license-cc +FILES:
    reuse addheader -l 'CC-BY-SA-4.0' -c '{{copyright}}' {{FILES}}

# Add the project default license header to the specified files
license-gpl +FILES:
    reuse addheader -l 'GPL-3.0-or-later' -c '{{copyright}}' {{FILES}}
