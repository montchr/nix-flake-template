{pkgs, ...}: {
  commands = [
    {
      category = "tools";
      package = pkgs.yarn;
    }
    {
      category = "tools";
      package = pkgs.reuse;
    }
  ];
  packages = with pkgs; [
    nodejs
  ];
  env = [];
}
