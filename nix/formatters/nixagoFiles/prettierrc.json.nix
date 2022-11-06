{
  flake.nixagoFiles."prettierrc" = {
    output = ".prettierrc.json";
    configData = {
      proseWrap = "always";
      semi = false;
      singleQuote = true;
      trailingComma = "all";
    };
  };
}
