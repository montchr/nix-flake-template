# shellcheck disable=2005
echo "$(head -n1 "$1")" | commitlint --color
