{
  fmt = {
    description = "Format all changed source files";
    content = ''
      treefmt $(git diff --name-only --cached)
    '';
  };
}
