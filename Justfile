# Autogenerated! DO NOT EDIT!
# This justfile is autogenerated via https://std.divnix.com/reference/std/nixago/just.html
# It can be used without Nix by running a locally installed  `just` binary.
# NOTE: Without Nix, you are responsible for having all task dependencies
# available locally!

# Add a CC-BY-SA-4.0 license header to all or specified files
license-cc +FILES:
    reuse addheader -l 'CC-BY-SA-4.0' -c 'Chris Montgomery <chris@cdom.io>' '{{ FILES }}'

# Add the project default license header to all or specified files
license-gpl *FILES:
    reuse addheader -l 'GPL-3.0-or-later' -c 'Chris Montgomery <chris@cdom.io>' '{{ FILES }}'