{
  # FIXME: https://github.com/divnix/std/issues/188
  # root = true;

  "*" = {
    charset = "utf-8";
    end_of_line = "lf";
    insert_final_newline = true;
    trim_trailing_whitespace = true;
    indent_style = "space";
    indent_size = 2;
  };

  "*.{bash,sh}" = {
    simplify = true;
    switch_case_indent = true;
    binary_next_line = true;
  };

  "*.{plist,php,py,xml}" = {
    indent_size = 4;
    indent_style = "space";
  };

  "*.md" = {
    indent_size = 4;
    indent_style = "space";
    # Two trailing spaces can be used to render a linebreak.
    trim_trailing_whitespace = false;
  };

  # Ignore diffs/patches
  "*.{diff,patch}" = {
    end_of_line = "unset";
    insert_final_newline = "unset";
    trim_trailing_whitespace = "unset";
    indent_size = "unset";
  };

  "{LICENSES/**,LICENSE,secrets/**}" = {
    end_of_line = "unset";
    insert_final_newline = "unset";
    trim_trailing_whitespace = "unset";
    charset = "unset";
    indent_style = "unset";
    indent_size = "unset";
  };
}
