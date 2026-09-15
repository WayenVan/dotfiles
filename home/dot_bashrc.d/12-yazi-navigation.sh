# Start Yazi and adopt its active tab's directory when it exits.
navi() {
  local tmp cwd
  tmp="$(mktemp -t 'yazi-cwd.XXXXXX')"

  command yazi "$@" --cwd-file="$tmp"

  IFS= read -r -d '' cwd < "$tmp"
  [[ "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"

  command rm -f -- "$tmp"
}
