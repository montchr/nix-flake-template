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
        category = "formatters";
        package = pkgs.nodePackages.prettier;
      }
    ];
    packages =
      (getSystem pkgs.system).treefmt.buildInputs
      ++ (with pkgs; [
        editorconfig-checker
      ]);
  };
}
