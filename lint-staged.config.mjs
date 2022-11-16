import path from 'path'

export default {
  // '*': 'nix run nixpkgs#treefmt -- --no-cache',
  '*.nix':
    'nix eval --no-update-lock-file --no-write-lock-file --no-warn-dirty --accept-flake-config',
}
