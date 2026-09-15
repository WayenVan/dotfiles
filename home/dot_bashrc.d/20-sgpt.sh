if command -v sgpt >/dev/null 2>&1; then
  export OPENAI_API_KEY="$DEEPSEEK_API_KEY"
  # sgpt defaults its caches to /tmp/cache and /tmp/chat_cache, which break on
  # shared hosts once another user owns them. .sgptrc can't expand `~`, but env
  # vars take priority over it, so set per-user paths here.
  export CACHE_PATH=~/.cache/shell_gpt/cache
  export CHAT_CACHE_PATH=~/.cache/shell_gpt/chat_cache

  # No quoting needed: `ai 写一段关于秋天的诗` joins all words into one prompt.
  ai() {
    sgpt "$*"
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
