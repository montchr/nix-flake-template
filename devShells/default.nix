{lib, ...}: {
  perSystem = {
    inputs',
    system,
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) getExe;

    inherit
      (pkgs)
      alejandra
      editorconfig-checker
      shellcheck
      ssh-to-age
      sops
      treefmt
      ;
    inherit (pkgs.nodePackages) prettier;

    userConfigHome = ''''${XDG_CONFIG_HOME:-$HOME/.config}'';

    withCategory = category: attrset: attrset // {inherit category;};
    pkgWithCategory = category: package: {inherit package category;};

    # nix-flake-template = pkgWithCategory "nix-flake-template";
    # nix-flake-template' = withCategory "nix-flake-template";
    linters = pkgWithCategory "linters";
    formatters = pkgWithCategory "formatters";
    # utils = pkgWithCategory "utils";
    utils' = withCategory "utils";
    secrets = pkgWithCategory "secrets";
    secrets' = withCategory "secrets";
  in {
    devShells.default = inputs'.devshell.legacyPackages.mkShell {
      name = "nix-flake-template";

      # git.hooks.enable = true;
      # git.hooks.pre-commit.text = ''${pkgs.treefmt}/bin/treefmt'';

      commands = [
        (utils' {
          name = "format";
          command = ''
            treefmt --clear-cache -- "$@"
          '';
        })

        (utils' {
          name = "evalnix";
          help = "Check Nix parsing";
          command = ''
            ${getExe pkgs.fd} --extension nix --exec \
              nix-instantiate --parse --quiet {} >/dev/null
          '';
        })

        (formatters alejandra)
        (formatters prettier)
        (formatters treefmt)
        (linters editorconfig-checker)
        (linters shellcheck)

        (secrets sops)
        (secrets ssh-to-age)
        (secrets' {
          name = "convert-ssh-to-age-key";
          help = "helper to convert the usual ssh ed25519 keys to age keys";
          command = ''
            mkdir -p $SOPS_AGE_KEY_DIR
            ${getExe ssh-to-age} -private-key -i ~/.ssh/id_ed25519 > $SOPS_AGE_KEY_DIR/age-key.sec
            ${getExe ssh-to-age} -i ~/.ssh/id_ed25519.pub > $SOPS_AGE_KEY_DIR/age-key.pub
          '';
        })
      ];

      packages = [];

      env = [
        {
          name = "SOPS_AGE_KEY_DIR";
          eval = "${userConfigHome}/sops/age";
        }
        {
          name = "SOPS_AGE_KEY_FILE";
          eval = "${userConfigHome}/sops/age/keys";
        }
      ];
    };
  };
}
