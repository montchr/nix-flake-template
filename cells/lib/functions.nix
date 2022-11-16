{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in {
  /*
  Convert a list of strings to an attrset where the keys match the values.

  Example:
    enumAttrs ["foo" "bar"]
    => {foo = "foo"; bar = "bar";}
  */
  enumAttrs = enum: l.genAttrs enum (s: s);
}
