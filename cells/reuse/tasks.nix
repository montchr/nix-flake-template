let
  copyright = "Chris Montgomery <chris@cdom.io>";
  gpl = "GPL-3.0-or-later";
  cc = "CC-BY-SA-4.0";
in {
  "license-gpl *FILES" = {
    description = "Add the project default license header to all or specified files";
    content = ''
      reuse addheader -l '${gpl}' -c '${copyright}' '{{FILES}}'
    '';
  };
  "license-cc +FILES" = {
    description = "Add a CC-BY-SA-4.0 license header to all or specified files";
    content = ''
      reuse addheader -l '${cc}' -c '${copyright}' '{{FILES}}'
    '';
  };
}
