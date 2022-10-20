{pkgs, ...}: {
  commands = [
    {
      category = "tools";
      package = pkgs.yarn;
    }
    {
      category = "ci";
      package = pkgs.lefthook;
    }
    {
      category = "ci";
      package = pkgs.commitlint;
    }
    {
      category = "linters";
      package = pkgs.nodePackages.eslint;
    }
    {
      category = "linters";
      package = pkgs.nodePackages.stylelint;
    }
    {
      category = "legal";
      package = pkgs.reuse;
    }
  ];
  packages = with pkgs; [
    nodejs
  ];
  env = [];
}
