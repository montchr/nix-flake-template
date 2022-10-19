{
  self,
  getSystem,
  ...
}: {
  perSystem = {pkgs, ...}: {
    treefmt.formatters = {
      inherit (pkgs) alejandra shellcheck shfmt;
      inherit (pkgs.nodePackages) prettier;
    };
  };
  flake.devshellProfiles.formatters = {pkgs, ...}: {
    commands = [
      {
        name = "format";
        help = "apply formatting rules to source files";
        command = ''nix run $PRJ_ROOT#format'';
      }
    ];
    packages = (getSystem pkgs.system).treefmt.buildInputs ++ [];
  };
}
