{inputs}: let
  l = inputs.nixpkgs.lib // builtins;
  docExts = l.concatStringsSep "|" ["md" "org" "txt"];
in {
  "*.!(${docExts})" = "just license-gpl";
  "*.@(${docExts})" = "just license-cc";
  "*.nix" = ''
    nix eval --no-update-lock-file --no-write-lock-file --no-warn-dirty --accept-flake-config
  '';
}
