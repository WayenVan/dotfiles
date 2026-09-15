if command -v sgpt >/dev/null 2>&1; then
  export OPENAI_API_KEY="$DEEPSEEK_API_KEY"
  # sgpt defaults its caches to /tmp/cache and /tmp/chat_cache, which break on
  # shared hosts once another user owns them. .sgptrc can't expand `~`, but env
  # vars take priority over it, so set per-user paths here.
  export CACHE_PATH=~/.cache/shell_gpt/cache
  export CHAT_CACHE_PATH=~/.cache/shell_gpt/chat_cache

  # Create a chat lazily; child shells inherit it once one exists.
  _sgpt_ensure_chat() {
    if [[ -z "${SGPT_CHAT_ID:-}" ]]; then
      export SGPT_CHAT_ID="chat-$(date +%Y%m%d-%H%M%S)-$$-$RANDOM"
    fi
  }

  # No quoting needed: `ai 写一段关于秋天的诗` joins all words into one prompt.
  ai() {
    _sgpt_ensure_chat
    command sgpt --chat "$SGPT_CHAT_ID" "$*"
  }

  # Start a new chat in this shell, optionally with an initial prompt.
  ain() {
    export SGPT_CHAT_ID="chat-$(date +%Y%m%d-%H%M%S)-$$-$RANDOM"
    printf 'New sgpt chat: %s\n' "$SGPT_CHAT_ID"
    if (( $# > 0 )); then
      ai "$@"
    fi
  }

  aic() {
    if [[ -n "${SGPT_CHAT_ID:-}" ]]; then
      printf '%s\n' "$SGPT_CHAT_ID"
    else
      printf 'No active sgpt chat\n'
    fi
  }

  ais() {
    if ! command -v fzf >/dev/null 2>&1; then
      printf 'ais: fzf is required\n' >&2
      return 1
    fi

    local selected
    selected=$(
      command sgpt --list-chats |
        while IFS= read -r chat_path; do
          basename "$chat_path"
        done |
        sort -u |
        fzf --prompt='sgpt chat> ' --header="Current: $SGPT_CHAT_ID"
    ) || return

    [[ -n "$selected" ]] || return
    export SGPT_CHAT_ID="$selected"
    printf 'Switched sgpt chat: %s\n' "$SGPT_CHAT_ID"
  }

  air() {
    _sgpt_ensure_chat
    command sgpt --repl "$SGPT_CHAT_ID"
  }

  _sgpt_bash() {
    if [[ -n "$READLINE_LINE" ]]; then
      READLINE_LINE=$(sgpt --shell <<< "$READLINE_LINE" --no-interaction)
      READLINE_POINT=${#READLINE_LINE}
    fi
  }
  # \C-l is left alone (default clear-screen); \C-x\C-g (default: abort,
  # rarely used) matches the zsh binding for consistency across shells.
  bind -x '"\C-x\C-g": _sgpt_bash'
fi
