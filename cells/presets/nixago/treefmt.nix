# SPDX-FileCopyrightText: 2022 Chris Montgomery <chris@cdom.io>
#
# SPDX-License-Identifier: GPL-3.0-or-later
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
        "*.yml"
      ];
      excludes = ["_sources/**"];
    };
    shell = {
      command = "shfmt";
      # shfmt will read settings from `.editorconfig` as long as no parser or
      # printer flags are passed. See `man shfmt` for details.
      options = ["--simplify" "--write"];
      includes = ["*.sh" "*.bash"];
    };
  };
}
