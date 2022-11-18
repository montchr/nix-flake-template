{
  commit-msg = {
    commands = {
      commitlint = {
        run = ''
          # allow WIP, fixup!/squash! commits locally
          [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] \
            || commitlint --edit {1}
        '';
        skip = ["merge" "rebase"];
      };
    };
  };
  pre-commit = {
    parallel = false;
    commands = {
      treefmt = {
        run = "treefmt --fail-on-change {staged_files}";
        skip = [
          "merge"
          "rebase"
        ];
      };
      # FIXME: add lint-staged pebble

      # lint-staged = {
      #   run = "lint-staged {staged_files}";
      #   skip = ["merge" "rebase"];
      # };
    };
  };
}
