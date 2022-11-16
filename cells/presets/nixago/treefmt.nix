{
  formatter = {
    nix = {
      command = "alejandra";
      includes = ["*.nix"];
      excludes = [
        "**/_sources/*"
      ];
    };
    prettier = {
      command = "prettier";
      options = ["--plugin" "prettier-plugin-toml" "--write"];
      includes = [
        "*.css"
        "*.html"
        "*.js"
        "*.json"
        "*.jsx"
        "*.md"
        "*.mdx"
        "*.scss"
        "*.toml"
        "*.ts"
        "*.tsx"
        "*.yaml"
      ];
    };
    shell = {
      command = "shfmt";
      # shfmt will read settings from `.editorconfig` as long as no parser or
      # printer flags are passed. See `man shfmt` for details.
      options = ["--write"];
      includes = ["*.sh" "*.bash"];
    };
  };
}
